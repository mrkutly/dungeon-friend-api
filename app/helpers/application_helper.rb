module ApplicationHelper

  module SeedMethods

    def get_seed_response(plural_name)
      response = RestClient.get("http://dnd5eapi.co/api/#{plural_name}")
      return JSON.parse(response)
    end

    def seed(plural_name)
      response = self.get_seed_response(plural_name)

      response["results"].each do |attributes_hash|
        if self.find_by(url: attributes_hash["url"]).nil?
          instance = self.create(attributes_hash)
        end
      end
    end
  end


  module InstanceMethods

    def data
      @response ||= RestClient.get(self.url)
      @data ||= JSON.parse(@response)
    end
  end
end
