class CharacterCondition < ApplicationRecord
  belongs_to :character
  belongs_to :condition
end
