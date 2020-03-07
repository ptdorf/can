require "net/http"

module Can

  module Util

    def self.latest()
      uri = URI("https://rubygems.org/api/v1/gems/can.json")
      res = Net::HTTP.get(uri)
      data = JSON.load(res)
      return data["version"]
    end

  end
end
