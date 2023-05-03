class User < ApplicationRecord
  before_create :randomize_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  private

  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000_000)
    end while User.where(id: self.id).exists?
  end
end