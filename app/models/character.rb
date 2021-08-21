class Character < ApplicationRecord
  has_and_belongs_to_many :movies
  belongs_to :planet, optional: true
end
