require "rails_helper"

RSpec.describe Posts::UseCases::Create do
  describe ".call" do
    let(:subject) { described_class.new(params).call }

    let(:params) do
      {
        title: "title",
        content: "content"
      }
    end

    it { expect { subject }.to change { RepositoryRegistry.for(:posts).count }.by(1) }
    it { expect(subject.id).not_to be_nil }
    it { expect(subject.title).to eq("title") }
    it { expect(subject.content).to eq("content") }
  end
end
