RSpec.describe 'User' do
  context 'assocciations' do
    it 'has many likes' do
      t = User.reflect_on_association(:likes)
      expect(t.macro).to eq(:has_many)
    end
  end
end