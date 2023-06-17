RSpec.describe "Posts", type: :request do
    let(:user) { create(:user, :with_avatar) }
    let(:post) { create(:post, user: user) }

    describe "#show" do
        context "when user is logged in" do
            before do
                sign_in user
            end

            it "returns http success" do
                get "/posts/#{post.id}"
                expect(response).to have_http_status(:success)
            end
        end
    end
end