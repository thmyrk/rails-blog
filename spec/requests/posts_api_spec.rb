require "rails_helper"

RSpec.describe "Posts API" do
  let(:parsed_response) do
    JSON.parse(response.body)
  end

  describe "POST #create" do
    subject { post "/api/v1/posts", params: request_params }

    let(:show_response_keys) { %w[id title content] }
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
        it { expect(response).to have_http_status(201) }
        it { expect(post_response.keys).to match_array(show_response_keys) }
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

  describe "GET #show" do
    subject { get "/api/v1/posts/#{post_id}" }

    let(:show_response_keys) { %w[id title content] }
    let(:post_response) { parsed_response["post"] }
    let(:post_object) { create(:post) }
    let(:post_id) { post_object.id }

    context "when given id exists" do
      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(200) }
        it { expect(post_response.keys).to match_array(show_response_keys) }
        it { expect(post_response["id"]).to eq(post_object.id) }
        it { expect(post_response["title"]).to eq(post_object.title) }
        it { expect(post_response["content"]).to eq(post_object.content) }
      end
    end

    context "when invalid id given" do
      let(:post_id) { 9999 }

      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(404) }
      end
    end
  end

  describe "DELETE #destroy" do
    subject { delete "/api/v1/posts/#{post_id}" }

    let!(:post_object) { create(:post) }
    let(:post_id) { post_object.id }

    context "when given id exists" do
      it { expect { subject }.to change { RepositoryRegistry.for(:posts).count }.by(-1) }

      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(204) }
      end
    end

    context "when given id doesn't exist" do
      let(:post_id) { 9999 }

      it { expect { subject }.to change { RepositoryRegistry.for(:posts).count }.by(0) }
      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(404) }
      end
    end
  end

  describe "PATCH #update" do
    subject { patch "/api/v1/posts/#{post_id}", params: request_params }

    let(:update_response_keys) { %w[id title content] }
    let(:post_response) { parsed_response["post"] }
    let(:title) { "new title" }
    let(:content) { "new content" }
    let!(:post_object) { create(:post) }
    let(:post_id) { post_object.id }

    let(:request_params) do
      {
        title: title,
        content: content
      }
    end

    context "when the given id is valid" do
      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(200) }
        it { expect(post_response.keys).to match_array(update_response_keys) }
        it { expect(post_response["id"]).not_to be_nil }
        it { expect(post_response["title"]).to eq(title) }
        it { expect(post_response["content"]).to eq(content) }
      end
    end

    context "when the given id is invalid" do
      let(:post_id) { 9999 }

      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(404) }
      end
    end
  end
end
