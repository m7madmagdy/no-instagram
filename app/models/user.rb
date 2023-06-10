class User < ApplicationRecord
  before_create :randomize_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  followability
  has_many :posts, foreign_key: :user_id, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :avatars, dependent: :destroy
  accepts_nested_attributes_for :avatars

  def unfollow(user)
    followerable_relationships.where(followable_id: user.id).destroy_all
  end

  private
  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000_000)
    end while User.where(id: self.id).exists?
  end
end
