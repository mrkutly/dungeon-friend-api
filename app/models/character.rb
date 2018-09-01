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


  def self.new_from_params(character_params, prof_params)
    character = self.new(character_params)
    languages = prof_params[:languages].map { |lang| Language.find_by(name: lang) }

    skills, profs = prof_params[:proficiencies].partition do |el|
      el[:name].include?("Skill:")
    end

    skills = skills.map { |skill| Skill.find_by(name: skill[:name][7..-1]) }

    proficiencies = profs.map { |prof| Proficiency.find_by(url: prof[:url]) }

    equipment = []

    prof_params[:equipment].each do |e|
      item = Equipment.find_by(url: e[:item][:url])
      e[:quantity].times do
        equipment << item
      end
    end

    character.languages = languages
    character.proficiencies = proficiencies
    character.equipment = equipment
    character.skills = skills
    character
  end

  def starting_equipment
    @starting_equipment_response ||= RestClient.get("http://dnd5eapi.co/api/startingequipment/#{self.job_id}")
    @starting_equipment ||= JSON.parse(@starting_equipment_response)
  end

end
