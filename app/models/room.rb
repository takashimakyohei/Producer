class Room < ApplicationRecord
  has_many :messages
  belongs_to :producer
  belongs_to :user
end
