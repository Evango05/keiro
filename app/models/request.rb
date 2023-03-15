class Request < ApplicationRecord
  belongs_to :user
  has_many :itineraries
end
