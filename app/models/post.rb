class Post < ApplicationRecord
  belongs_to :user
  has_many :likes

  validates :message, presence: true

  scope :published, -> { where(published: true) }
end
