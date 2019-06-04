require "rails_helper"

RSpec.describe "Comments API" do
  let(:parsed_response) do
    JSON.parse(response.body)
  end

  describe "POST #create" do
    subject { post "/api/v1/comments", params: request_params }

    let(:create_response_keys) { %w[id post_id content commentable_id commentable_type] }
    let(:comment_response) { parsed_response["comment"] }
    let(:post_object) { create(:post) }
    let(:post_id) { post_object.id }
    let(:content) { "valid content" }
    let(:commentable_id) { post_id }
    let(:commentable_type) { "post" }

    let(:request_params) do
      {
        post_id: post_id,
        content: content,
        commentable_id: commentable_id,
        commentable_type: commentable_type
      }
    end

    context "when commentable is a post and params are valid" do
      it { expect { subject }.to change { RepositoryRegistry.for(:comments).count }.by(1) }

      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(200) }
        it { expect(parsed_response["errors"]).to be_nil }
        it { expect(comment_response.keys).to match_array(create_response_keys) }
        it { expect(comment_response["id"]).not_to be_nil }
        it { expect(comment_response["post_id"]).to eq(post_id) }
        it { expect(comment_response["content"]).to eq(content) }
        it { expect(comment_response["commentable_id"]).to eq(commentable_id) }
        it { expect(comment_response["commentable_type"]).to eq(commentable_type) }
      end
    end

    context "when commentable is a post and post_id does not exist" do
      let(:post_id) { 99999 }
      let(:commentable_id) { post_object.id }
      it { expect { subject }.to change { RepositoryRegistry.for(:comments).count }.by(0) }

      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(400) }
        it { expect(parsed_response).to include("errors") }
      end
    end

    context "when commentable is a post and commentable_id does not exist" do
      let(:commentable_id) { 99999 }
      it { expect { subject }.to change { RepositoryRegistry.for(:comments).count }.by(0) }

      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(400) }
        it { expect(parsed_response).to include("errors") }
      end
    end

    context "when commentable is a comment and params are valid" do
      let!(:comment) { create(:comment) }
      let(:commentable_id) { comment.id }
      let(:commentable_type) { "comment" }

      it { expect { subject }.to change { RepositoryRegistry.for(:comments).count }.by(1) }

      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(200) }
        it { expect(parsed_response["errors"]).to be_nil }
        it { expect(comment_response.keys).to match_array(create_response_keys) }
        it { expect(comment_response["id"]).not_to be_nil }
        it { expect(comment_response["post_id"]).to eq(post_id) }
        it { expect(comment_response["content"]).to eq(content) }
        it { expect(comment_response["commentable_id"]).to eq(commentable_id) }
        it { expect(comment_response["commentable_type"]).to eq(commentable_type) }
      end
    end

    context "when some params are invalid" do
      shared_examples "comments invalid parameter response" do |parameter_name, incorrect_value|
        let(:request_params) { super().merge(parameter_name => incorrect_value) }
        it do
          subject
          expect(response).to have_http_status(400)
        end
        it { expect { subject }.to change { RepositoryRegistry.for(:comments).count }.by(0) }
        it do
          subject
          expect(parsed_response).to include("errors")
        end
      end

      it_behaves_like "comments invalid parameter response", :content, ""
      it_behaves_like "comments invalid parameter response", :content, nil
      it_behaves_like "comments invalid parameter response", :post_id, ""
      it_behaves_like "comments invalid parameter response", :post_id, nil
      it_behaves_like "comments invalid parameter response", :commentable_id, nil
      it_behaves_like "comments invalid parameter response", :commentable_id, ""
      it_behaves_like "comments invalid parameter response", :commentable_type, nil
      it_behaves_like "comments invalid parameter response", :commentable_type, ""
      it_behaves_like "comments invalid parameter response", :commentable_type, "invalid"
    end
  end

  describe "GET #show" do
    subject { get "/api/v1/comments/#{comment_id}" }

    let(:show_response_keys) { %w[id post_id content commentable_id commentable_type] }
    let(:comment_response) { parsed_response["comment"] }
    let(:comment_object) { create(:comment) }
    let(:comment_id) { comment_object.id }

    context "when given id exists" do
      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(200) }
        it { expect(comment_response.keys).to match_array(show_response_keys) }
        it { expect(comment_response["id"]).to eq(comment_object.id) }
        it { expect(comment_response["content"]).to eq(comment_object.content) }
        it { expect(comment_response["commentable_id"]).to eq(comment_object.commentable_id) }
        it { expect(comment_response["commentable_type"]).to eq("post") }
      end
    end

    context "when invalid id given" do
      let(:comment_id) { 9999 }

      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(404) }
      end
    end
  end

  describe "DELETE #destroy" do
    subject { delete "/api/v1/comments/#{comment_id}" }

    let!(:comment_object) { create(:comment) }
    let(:comment_id) { comment_object.id }

    context "when given id exists" do
      it { expect { subject }.to change { RepositoryRegistry.for(:comments).count }.by(-1) }

      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(204) }
      end
    end

    context "when given id doesn't exist" do
      let(:comment_id) { 9999 }

      it { expect { subject }.to change { RepositoryRegistry.for(:comments).count }.by(0) }
      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(404) }
      end
    end
  end

  describe "PATCH #update" do
    subject { patch "/api/v1/comments/#{comment_id}", params: request_params }

    let(:update_response_keys) { %w[id post_id content commentable_id commentable_type] }
    let(:comment_response) { parsed_response["comment"] }
    let(:content) { "new content" }
    let!(:comment_object) { create(:comment) }
    let(:comment_id) { comment_object.id }

    let(:request_params) do
      {
        content: content
      }
    end

    context "when the given id is valid" do
      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(200) }
        it { expect(comment_response.keys).to match_array(update_response_keys) }
        it { expect(comment_response["id"]).not_to be_nil }
        it { expect(comment_response["content"]).to eq(content) }
      end
    end

    context "when the given id is invalid" do
      let(:comment_id) { 9999 }

      describe "response" do
        before { subject }
        it { expect(response).to have_http_status(404) }
      end
    end
  end
end
