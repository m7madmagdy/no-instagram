class User < ApplicationRecord
  extend Devise::Models
  before_create :generate_token
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :username, presence: true, length: { minimum: 4, maximum: 20 }

  has_many :posts, foreign_key: :user_id, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :avatars, dependent: :destroy
  accepts_nested_attributes_for :avatars

  followability

  enum role: { user: 0, admin: 1 }, _default: :user

  def admin?
    role == 'admin'
  end

  def unfollow(user)
    followerable_relationships.where(followable_id: user.id).destroy_all
  end

  def generate_token
    self.token = "#{id}/#{SecureRandom.urlsafe_base64(nil, false)}"
  end

  def self.ransackable_attributes(auth_object = nil)
    super + %w[bio created_at email id remember_created_at reset_password_sent_at reset_password_token token updated_at username]
  end
end
