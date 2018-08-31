class Character < ApplicationRecord
  validates :name, presence: true
  validates :level, numericality: { greater_than: 0 }
  validates :race, presence: true
  validates :job, presence: true

  # belongs_to :user
  belongs_to :test_user
  belongs_to :race
  belongs_to :job

  belongs_to :magic_school, optional: true
  belongs_to :subclass, optional: true
  belongs_to :subrace, optional: true

  has_many :character_features
  has_many :features, through: :character_features

  has_many :character_spells
  has_many :spells, through: :character_spells

  has_many :ability_score_characters
  has_many :ability_scores, through: :ability_score_characters

  has_many :character_conditions
  has_many :conditions, through: :character_conditions

  has_many :character_equipment
  has_many :equipment, through: :character_equipment

  has_many :character_languages
  has_many :languages, through: :character_languages

  has_many :character_proficiencies
  has_many :proficiencies, through: :character_proficiencies

  has_many :character_skills
  has_many :skills, through: :character_skills


  def starting_equipment
    @starting_equipment_response ||= RestClient.get("http://dnd5eapi.co/api/startingequipment/#{self.job_id}")
    @starting_equipment ||= JSON.parse(@starting_equipment_response)
  end

  def formatted
    return {
      character: self,
      languages: self.languages,
      proficiencies: self.proficiencies,
      equipment: self.equipment,
      conditions: self.conditions,
      features: self.features,
      spells: self.spells,
      skills: self.skills      
    }
  end
end
