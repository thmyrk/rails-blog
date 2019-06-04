require "rails_helper"

RSpec.describe Comments::UseCases::Update do
  describe ".call" do
    let(:subject) { described_class.new(params.with_indifferent_access).call }
    let(:comment) { create(:comment) }

    let(:params) do
      {
        id: comment.id,
        content: "new content"
      }
    end

    it { expect(subject.content).to eq("new content") }
  end
end
