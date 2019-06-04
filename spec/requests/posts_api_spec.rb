require "rails_helper"

RSpec.describe "Posts API" do
  let(:parsed_response) do
    JSON.parse(response.body)
  end

  describe "POST #create" do
    subject { post "/api/v1/posts", params: request_params }

    let(:create_response_keys) { %w[id title content] }
    let(:post_response) { parsed_response["post"] }
    let(:title) { "valid title" }
    let(:content) { "valid content" }

    let(:request_params) do
      {
        title: title,
        content: content
      }
    end

    context "when all params are valid" do
      it { expect { subject }.to change { RepositoryRegistry.for(:posts).count }.by(1) }

      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(200) }
        it { expect(post_response.keys).to match_array(create_response_keys) }
        it { expect(post_response["id"]).not_to be_nil }
        it { expect(post_response["title"]).to eq(title) }
        it { expect(post_response["content"]).to eq(content) }
      end
    end

    context "when some params are invalid" do
      shared_examples "posts invalid parameter response" do |parameter_name, incorrect_value|
        let(:request_params) { super().merge(parameter_name => incorrect_value) }
        it do
          subject
          expect(response).to have_http_status(400)
        end
        it { expect { subject }.to change { RepositoryRegistry.for(:posts).count }.by(0) }
        it do
          subject
          expect(parsed_response).to include("errors")
        end
      end

      it_behaves_like "posts invalid parameter response", :title, ""
      it_behaves_like "posts invalid parameter response", :title, nil
      it_behaves_like "posts invalid parameter response", :content, ""
      it_behaves_like "posts invalid parameter response", :content, nil
    end
  end
end
