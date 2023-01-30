class Book < ApplicationRecord
    belongs_to :user,dependent: :destroy
    has_one_attached :image
    has_many :likes, dependent: :delete_all

    validates :title, presence: true
    validates :author, presence: true
    validates :image, presence: true
end


