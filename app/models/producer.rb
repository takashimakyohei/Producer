class Producer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :prefecture_id, presence: true       
  has_many :products, dependent: :destroy
  has_one_attached :image
  belongs_to :prefecture, optional: true
  has_many :rooms, dependent: :destroy

end
