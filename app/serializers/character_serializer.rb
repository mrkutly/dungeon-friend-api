class CharacterSerializer < ActiveModel::Serializer
  attributes :id, :name, :level, :race, :job, :features,
    :features, :spells, :strength, :constitution, :wisdom, :dexterity,
    :intelligence, :charisma, :conditions, :equipment, :languages,
    :proficiencies, :skills, :max_hp, :current_hp
end
