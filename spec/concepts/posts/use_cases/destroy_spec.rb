require "rails_helper"

RSpec.describe Posts::UseCases::Destroy do
  describe ".call" do
    let(:subject) { described_class.new(params.with_indifferent_access).call }
    let!(:post) { create(:post) }

    let(:params) do
      {
        id: post.id.to_s
      }
    end

    it { expect { subject }.to change { RepositoryRegistry.for(:posts).count }.by(-1) }
  end
end
