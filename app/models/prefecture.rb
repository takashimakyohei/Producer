class Prefecture < ApplicationRecord
  has_many :users
  has_many :producers
end
