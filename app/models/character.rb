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

  def assign_hp(prof_params)
    hit_die = prof_params[:hit_die]

    case prof_params[:constitution]
    when 1
      modifier = -5
    when 2,3
      modifier = -4
    when 4,5
      modifier = -3
    when 6,7
      modifier = -2
    when 8,9
      modifier = -1
    when 10,11
      modifier = 0
    when 12,13
      modifier = 1
    when 14,15
      modifier = 2
    when 16,17
      modifier = 3
    when 18,19
      modifier = 4
    when 20
      modifier = 5
    end

    self.max_hp = hit_die + modifier
    self.current_hp = hit_die + modifier
  end

  def assign_languages(prof_params)
    languages = prof_params[:languages].map { |lang| Language.find_by(name: lang) }
    self.languages = languages
  end

  def assign_equipment(prof_params)
    equipment = []

    prof_params[:equipment].each do |e|
      item = Equipment.find_by(url: e[:item][:url])
      e[:quantity].times do
        equipment << item
      end
    end

    self.equipment = equipment
  end

  def assign_skills_and_proficiencies(prof_params)
    skills, profs = prof_params[:proficiencies].partition do |el|
      el[:name].include?("Skill:")
    end

    skills = skills.map { |skill| Skill.find_by(name: skill[:name][7..-1]) }
    proficiencies = profs.map { |prof| Proficiency.find_by(url: prof[:url]) }

    self.proficiencies = proficiencies
    self.skills = skills
  end

  def self.new_from_params(character_params, prof_params)
    character = self.new(character_params)

    character.assign_hp(prof_params)
    character.assign_languages(prof_params)
    character.assign_equipment(prof_params)
    character.assign_skills_and_proficiencies(prof_params)
    return character
  end

  def starting_equipment
    @starting_equipment_response ||= RestClient.get("http://dnd5eapi.co/api/startingequipment/#{self.job_id}")
    @starting_equipment ||= JSON.parse(@starting_equipment_response)
  end

end
