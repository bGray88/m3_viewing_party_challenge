class Movie < ApplicationRecord
  validates :title, :rating, :description, presence: true
end
