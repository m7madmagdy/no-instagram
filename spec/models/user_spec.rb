RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:avatars).dependent(:destroy) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:avatars) }
  end

end
