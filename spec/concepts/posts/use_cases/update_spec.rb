require "rails_helper"

RSpec.describe Posts::UseCases::Update do
  describe ".call" do
    let(:subject) { described_class.new(params.with_indifferent_access).call }
    let(:post) { create(:post) }

    let(:params) do
      {
        id: post.id,
        title: "new title",
        content: "new content"
      }
    end

    it { expect(subject.title).to eq("new title") }
    it { expect(subject.content).to eq("new content") }
  end
end
