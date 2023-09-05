class Photo < ApplicationRecord
  belongs_to :social

  validates :image, presence: true
end
