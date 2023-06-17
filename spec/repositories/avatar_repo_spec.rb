RSpec.describe AvatarRepo, type: :repo do
    let(:user) { FactoryBot.create(:user) }
    let(:avatar) { FactoryBot.create(:avatar, user: user) }
    let(:avatar_repo) { 
      AvatarRepo.new(user, avatar.raw_response, avatar.avatar_id, 
        avatar.avatar_type, avatar.avatar_url)
    }
  
    describe "#create_avatar" do
        it "creates a new avatar" do
            expect {
                avatar_repo.create_avatar
            }.to change(Avatar, :count).by(1)
            user_avatar = user.avatar
            expect(user_avatar.raw_response).to eq(avatar.raw_response)
            expect(user_avatar.avatar_id).to eq(avatar.avatar_id)
            expect(user_avatar.avatar_type).to eq(avatar.avatar_type)
            expect(user_avatar.avatar_url).to eq(avatar.avatar_url)
        end
    end
end