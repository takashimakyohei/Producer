class Product < ApplicationRecord
  belongs_to :producer
  has_many :favorites, dependent: :destroy 
  has_many :comments, dependent: :destroy
  has_one_attached :image
  validates :name, :content, :description, :price, presence: true
  validate :image_presence

  def image_presence
    if image.attached?
      if !image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:image, 'にはjpegまたはpngファイルを添付してください')
      end
    else
      errors.add(:image, 'ファイルを添付してください')
    end
  end

end
