require 'win32/registry'

class Registry

  @@native_registry_constant = ENV['PROCESSOR_ARCHITEW6432'] == 'AMD64' ? 0x0100 : 0x0200

  def self.get_hive_name(path)
    reg_path = path.split("\\")
    hive_name = reg_path.shift

    {
        "HKLM" => "HKEY_LOCAL_MACHINE",
        "HKCU" => "HKEY_CURRENT_USER",
        "HKU" => "HKEY_USERS"
    }[hive_name] || hive_name
  end

  def self.get_hive(path)
    {
        "HKEY_LOCAL_MACHINE" => ::Win32::Registry::HKEY_LOCAL_MACHINE,
        "HKEY_USERS" => ::Win32::Registry::HKEY_USERS,
        "HKEY_CURRENT_USER" => ::Win32::Registry::HKEY_CURRENT_USER
    }[get_hive_name(path)]
  end

  def self.unload_hive(path)
    hive = get_hive(path)
    if hive == ::Win32::Registry::HKEY_USERS
      reg_path = path.split("\\")
      priv = Chef::WindowsPrivileged.new
      begin
        priv.reg_unload_key(reg_path[1])
      rescue
        # ignored
      end
    end
  end

  def self.get_value(path, value)
    hive, reg_path, hive_name, root_key, hive_loaded = get_reg_path_info(path)
    key = reg_path.join("\\")

    hive.open(key, ::Win32::Registry::KEY_ALL_ACCESS | @@native_registry_constant) do |reg|
      begin
        return reg[value]
      rescue
        return nil
      ensure
        ensure_hive_unloaded(hive_loaded)
      end
    end
  end

  def self.get_values(path)
    hive, reg_path, hive_name, root_key, hive_loaded = get_reg_path_info(path)
    key = reg_path.join("\\")
    hive.open(key, ::Win32::Registry::KEY_ALL_ACCESS | @@native_registry_constant) do |reg|
      values = []
      begin
        reg.each_value do |name, type, data|
          values << [name, type, data]
        end
      rescue
        # ignored
      ensure
        ensure_hive_unloaded(hive_loaded)
      end
      values
    end
  end

  def self.value_exists?(path, value)
    return false unless key_exists?(path, true)

    hive, reg_path, hive_name, root_key, hive_loaded = get_reg_path_info(path)
    key = reg_path.join("\\")

    hive.open(key, ::Win32::Registry::KEY_READ | @@native_registry_constant) do |reg|
      begin
        reg[value]
        return true
      rescue
        return false
      ensure
        ensure_hive_unloaded(hive_loaded)
      end
    end
  end

  def self.key_exists?(path, load_hive = false)
    if load_hive
      hive, reg_path, hive_name, root_key, hive_loaded = get_reg_path_info(path)
      key = reg_path.join("\\")
    else
      hive = get_hive(path)
      reg_path = path.split("\\")
      hive_name = reg_path.shift
      root_key = reg_path[0]
      key = reg_path.join("\\")
      hive_loaded = false
    end

    begin
      hive.open(key, ::Win32::Registry::Constants::KEY_READ | @@native_registry_constant)
      return true
    rescue
      return false
    ensure
      ensure_hive_unloaded(hive_loaded)
    end
  end

  def self.get_user_hive_location(sid)
    reg_key = "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\ProfileList\\#{sid}"

    if key_exists?(reg_key)
      get_value(reg_key, 'ProfileImagePath')
    else
      nil
    end

  end

  def self.resolve_user_to_sid(username)
    begin
      sid = WMI::Win32_UserAccount.find(:first, :conditions => {:name => username}).sid
      Chef::Log.debug("Resolved user SID to #{sid}")
      return sid
    rescue
      return nil
    end
  end

  def self.hive_loaded?(path)
    hive = get_hive(path)
    reg_path = path.split("\\")
    hive_name = reg_path.shift
    user_hive = path[0]

    if is_user_hive?(hive)
      key_exists?("#{hive_name}\\#{user_hive}")
    else
      true
    end
  end

  def self.is_user_hive?(hive)
    hive == ::Win32::Registry::HKEY_USERS
  end

  def self.get_reg_path_info(path)
    hive = get_hive(path)
    reg_path = path.split("\\")
    hive_name = reg_path.shift
    root_key = reg_path[0]
    hive_loaded = false

    if is_user_hive?(hive) && !key_exists?("#{hive_name}\\#{root_key}")
      reg_path, hive_loaded = load_user_hive(hive, reg_path, root_key)
      root_key = reg_path[0]
    end

    return hive, reg_path, hive_name, root_key, hive_loaded
  end

  private

  def self.ensure_hive_unloaded(hive_loaded=false)
    unload_hive path if hive_loaded
  end
end
