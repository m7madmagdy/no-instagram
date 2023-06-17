RSpec.describe "Posts", type: :request do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }

    describe "GET /posts" do
        it "returns http success" do
            get "/posts"
            expect(response).to have_http_status(:success)
        end
    end

    describe '#myposts' do
        context 'when user is logged in' do
            before do
                sign_in user
            end

            it 'returns http success' do
                get '/posts/myposts'
                expect(response).to have_http_status(:success)
            end
        end

        context 'when user is not logged in' do
            it 'redirects to login page' do
                get '/posts/myposts'
                expect(response).to redirect_to('/users/sign_in')
            end
        end
    end
end