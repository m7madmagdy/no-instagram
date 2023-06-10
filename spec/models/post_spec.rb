RSpec.describe Post, type: :model do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user)}

    context 'validations' do
        it { is_expected.to validate_presence_of(:title) }
        it { is_expected.to validate_presence_of(:description) }
        it { is_expected.to validate_presence_of(:keywords) }
    end

    context 'assocciations' do
        it 'belongs to user' do
            should belong_to(:user)
        end

        it 'has many comments' do
            should have_many(:comments)
        end

        it 'has many likes' do
            should have_many(:likes)
        end

        it 'has many attachments' do
            should have_many(:attachments)
        end
        
    end
end