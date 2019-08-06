class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :delete_all

  validates :message, presence: true

  scope :published, -> { where(published: true) }
end
