class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes

  validates :user_id, uniqueness: { scope: :post_id }
end
