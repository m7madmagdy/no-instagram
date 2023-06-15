class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  validates :keywords, presence: true, length: { minimum: 5, maximum: 100 }

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments

end
