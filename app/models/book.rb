class Book < ApplicationRecord
    belongs_to :user
    has_one_attached :image

    validates :title,:author,:image,presence: true
end


