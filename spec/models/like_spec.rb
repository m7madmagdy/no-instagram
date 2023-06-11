RSpec.describe Like, type: :model do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user)}

    context 'assocciations' do
      it { should belong_to(:user) }
      it { should belong_to(:post) }
    end
end