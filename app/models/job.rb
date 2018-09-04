class Job < ApplicationRecord
  extend ApplicationHelper::SeedMethods
  include ApplicationHelper::InstanceMethods

  has_many :characters

  def show_format
    data = self.data

    if data["spellcasting"]
      s = RestClient.get(data["spellcasting"]["url"])
      spellcasting = JSON.parse(s)
      data["spellcasting"] = spellcasting
    end

    return { id: self.id, data: data }
  end
end
