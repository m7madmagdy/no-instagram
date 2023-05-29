class Post < ApplicationRecord
  before_create :randomize_id

  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  validates :keywords, presence: true, length: { minimum: 5, maximum: 100 }

  belongs_to :user
  has_many_attached :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  private

  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000_000)
    end while User.where(id: self.id).exists?
  end
end
