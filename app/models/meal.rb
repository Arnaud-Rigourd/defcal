class Meal < ApplicationRecord
  has_many :foods, dependent: :destroy
end
