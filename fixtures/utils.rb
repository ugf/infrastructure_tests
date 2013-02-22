module Utils

  module Assertions

    def verify(actual, expected)
      should_include expected, actual
    rescue
      should_match expected, actual
    end

    def should_include(expected, actual)
      actual.downcase.should(
        include (interpolate expected).downcase)
    end

    def should_match(expected, actual)
      actual.should match /#{interpolate expected}/i
    end

  end

  module Meta

    def interpolate(string)
      return string unless string.match /\#\{.*?\}/
      string = string.gsub '"', '\"'
      eval '"' + string + '"'
    end

  end
end