require "rails_helper"

RSpec.describe Comments::UseCases::Destroy do
  describe ".call" do
    let(:subject) { described_class.new(params.with_indifferent_access).call }
    let!(:comment) { create(:comment) }

    let(:params) do
      {
        id: comment.id.to_s
      }
    end

    it { expect { subject }.to change { RepositoryRegistry.for(:comments).count }.by(-1) }
  end
end
