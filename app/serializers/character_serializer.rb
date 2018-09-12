class CharacterSerializer < ActiveModel::Serializer
  attributes :charisma, :conditions, :constitution, :current_hp,
    :dexterity, :equipment, :features, :id, :intelligence, :job,
    :languages, :level, :max_hp, :name, :proficiencies, :race,
    :skills, :speed, :spells, :strength, :wisdom
end
