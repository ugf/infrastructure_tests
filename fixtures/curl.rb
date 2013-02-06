require 'rest_client'

class Curl

  def self.client(url)
    RestClient.log = "rest.log"

    options = {
        headers: {
            accept: 'application/json'
        }
    }

    RestClient::Resource.new "http://#{url}", options
  end

  def self.get(url)
    client(url).get
  end

end