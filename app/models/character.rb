class Character < ApplicationRecord
  validates :name, presence: true
  validates :level, numericality: { greater_than: 0 }
  validates :race, presence: true
  validates :job, presence: true

  belongs_to :user
  belongs_to :race
  belongs_to :job

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

  def self.new_from_params(character_params, prof_params)
    character = self.new(character_params)

    character.assign_hp(prof_params)
    character.assign_languages(prof_params)
    character.assign_equipment(prof_params)
    character.assign_skills_and_proficiencies(prof_params)
    return character
  end

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
      id = e[:item][:url].split("/").last.to_i

      # if it's a pack, open it up and get all the items inside
      if id > 153 && id < 161
        resp = RestClient.get(e[:item][:url])
        json = JSON.parse(resp)
        json["contents"].each do |el|
          item = Equipment.find_by(url: el["item_url"])
          el["quantity"].times do
            equipment << item
          end
        end
      end

      # then also add the pack so players can see what the pack gave them if they want
      item = Equipment.find_by(url: e[:item][:url]) || Equipment.find_by(name: e[:item][:name])

      e[:quantity].times do
        equipment << item
      end
    end

    self.equipment = equipment
  end

  def assign_skills_and_proficiencies(prof_params)
    skills, profs = prof_params[:proficiencies].partition do |el|
      # The DND5eAPI has these listed as proficiencies sometimes.
      # Need to filter them out to prevent internal server errors
      skill_names = [
        "Acrobatics", "Animal Handling", "Stealth",
        "Arcana", "Athletics", "Deception", "History",
        "Insight", "Intimidation", "Investigation", "Medicine",
        "Nature", "Perception", "Performance", "Persuasion", "Religion",
        "Sleight of Hand", "Sleight Of Hand", "Stealth", "Survival"
      ]

      el[:name].include?("Skill:") || skill_names.include?(el[:name])
    end

    skills = skills.map { |skill| Skill.find_by(name: skill[:name][7..-1]) || Skill.find_by(name: skill[:name]) }
    proficiencies = profs.map { |prof|
      Proficiency.find_by(url: prof[:url]) || Proficiency.find_by(name: prof[:name])
    }

    self.proficiencies = proficiencies
    self.skills = skills
  end

  def starting_equipment
    @starting_equipment_response ||= RestClient.get("http://dnd5eapi.co/api/startingequipment/#{self.job_id}")
    @starting_equipment ||= JSON.parse(@starting_equipment_response)
  end

  def update_equipment(new_equipment)
    equipment = new_equipment.map { |el| Equipment.find(el["id"]) }
    self.equipment.delete_all
    self.update(equipment: equipment)
  end

  def update_features(new_feats)
    feats = new_feats.map { |el| Feature.find(el["id"]) }
    self.update(features: feats)
  end

  def update_languages(new_langs)
    langs = new_langs.map { |el| Language.find(el["id"]) }
    self.update(languages: langs)
  end

  def update_profs(new_profs)
    profs = new_profs.map { |el| Proficiency.find(el["id"]) }
    self.update(proficiencies: profs)
  end

  def update_skills(new_skills)
    skills = new_skills.map { |el| Skill.find(el["id"]) }
    self.update(skills: skills)
  end

  def update_spells(new_spells)
    spells = new_spells.map { |el| Spell.find(el["id"]) }
    self.update(spells: spells)
  end

  def update_from_params(params)
    self.update_equipment(params["equipment"])
    self.update_profs(params["proficiencies"])
    self.update_skills(params["skills"])
    self.update_spells(params["spells"])
    self.update_languages(params["languages"])
    self.update_features(params["features"])

    self.update(
      charisma: params["charisma"],
      constitution: params["constitution"],
      current_hp: params["current_hp"],
      dexterity: params["dexterity"],
      intelligence: params["intelligence"],
      level: params["level"],
      max_hp: params["max_hp"],
      speed: params["speed"],
      strength: params["strength"],
      wisdom: params["wisdom"]
    )
  end
end
