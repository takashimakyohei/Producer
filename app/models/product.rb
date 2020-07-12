class Product < ApplicationRecord
  belongs_to :producer, dependent: :destroy
  has_many :favorites, dependent: :destroy 
  has_one_attached :image
end
