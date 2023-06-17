RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:username) }
    it { should validate_length_of(:username).is_at_least(4).is_at_most(20) }
  end

  describe 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_one(:avatar).dependent(:destroy) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:avatar) }
  end

  describe '#admin' do
    let(:user) { create(:user, role: :admin) }

    it 'returns true if user is admin' do
      expect(user.admin?).to be_truthy
    end
  end

  describe '#unfollow' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    it 'follows a user' do
      user1.send_follow_request_to(user2)
      user2.accept_follow_request_of(user1)

      expect(user1.followerable_relationships.where(followable_id: user2.id)).not_to be_empty
    end

    it 'unfollows a user' do
      user1.unfollow(user2)

      expect(user1.followerable_relationships.where(followable_id: user2.id)).to be_empty
    end
  end
end
