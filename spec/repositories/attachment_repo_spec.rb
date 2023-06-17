RSpec.describe AttachmentRepo, type: :repo do
  let(:post) { FactoryBot.create(:post, :with_user) }
  let(:attachment) { FactoryBot.create(:attachment, :with_post) }
  let(:attachment_repo) { 
    AttachmentRepo.new(post, attachment.raw_response, attachment.resource_id, 
    attachment.resource_type, attachment.resource_url)
  }

  describe "#create_attachment" do
    it "creates a new attachment and returns its resource URL" do
      expect {
        attachment_repo.create_attachment
      }.to change { post.attachments.count }.by(1)

      last_attachment = post.attachments.last
      expect(last_attachment.raw_response).to eq(attachment.raw_response)
      expect(last_attachment.resource_id).to eq(attachment.resource_id)
      expect(last_attachment.resource_type).to eq(attachment.resource_type)
      expect(last_attachment.resource_url).to eq(attachment.resource_url)
    end
  end
end