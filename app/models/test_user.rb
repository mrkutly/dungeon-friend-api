class TestUser < ApplicationRecord
  # validates :name, { presence: true, length: { greater_than: 3 } }
  has_many :characters
end
