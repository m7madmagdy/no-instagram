RSpec.describe 'PostsController', type: :request do
  describe "POST #create" do
    let(:user) { create(:user, :with_avatar) }
    let(:attachment) { fixture_file_upload('spec/fixture_files/1.jpeg', 'image/png') }
    let(:imgur_response) do
        '{"data":{"id":"3O9qUDG", "type":"image/png"}, "success": true}'
      end
    let(:post_params) do
      { post: { title: "Test Post", description: "Test description", keywords: "keywords", user_id: user.id } }
    end

    before do
        stub_request(:post, 'https://api.imgur.com/3/upload.json')
          .to_return(body: imgur_response,
                     headers: { "Content-Type": 'application/json' })
    end  

    context "with valid user and parameters" do
        before do
            sign_in user
        end

        it "creates a new post" do
            expect do
                post "/posts", params: post_params
            end.to change(Post, :count).by(1)

            expect(response).to have_http_status(:redirect)
        end
    end

    context "with invalid user" do
      it "redirect to log in" do
        expect do
          post "/posts", params: post_params
        end.not_to change(Post, :count)

        expect(response).to redirect_to("/users/sign_in")
      end
    end

    context "with attachment" do
        let(:post_params) do
            { post: { title: "Test Post", description: "Test description", keywords: "keywords", user_id: user.id, attachment: attachment } }
        end

        before do
            sign_in user
        end
    
        it "creates a new post with attachment" do
            expect {
                post "/posts", params: post_params
            }.to change(Post, :count).by(1)

            expect(Post.last.attachments.count).to eq(1)
            expect(response).to have_http_status(:redirect)
            expect(response).to redirect_to("/posts/#{Post.last.id}")
        end
    end
  end
end
