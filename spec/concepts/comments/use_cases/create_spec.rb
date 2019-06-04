require "rails_helper"

RSpec.describe Comments::UseCases::Create do
  describe ".call" do
    let(:subject) { described_class.new(params.with_indifferent_access).call }
    let(:post_object) { create(:post) }

    let(:params) do
      {
        post_id: post_object.id.to_s,
        content: "content",
        commentable_id: post_object.id.to_s,
        commentable_type: "post"
      }
    end

    it { expect { subject }.to change { RepositoryRegistry.for(:comments).count }.by(1) }
    it { expect(subject.id).not_to be_nil }
    it { expect(subject.post_id).to eq(post_object.id) }
    it { expect(subject.content).to eq("content") }
    it { expect(subject.commentable_id).to eq(post_object.id) }
    it { expect(subject.commentable_type).to eq("Posts::Model") }
  end
end
