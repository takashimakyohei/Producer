class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :prefecture_id, presence: true


  has_one_attached :image
  belongs_to :prefecture, optional: true
  has_many :favorites, dependent: :destroy 
  has_many :comments, dependent: :destroy 
  has_many :rooms, dependent: :destroy

end
