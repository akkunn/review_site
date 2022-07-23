require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }
  let(:question) { FactoryBot.create(:question, user_id: user.id, school_id: school.id) }
  let(:question_params) { FactoryBot.attributes_for(:question, user_id: user.id, school_id: school.id) }

  describe "#index" do
    it "returns http success" do
      get questions_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "#show" do
    it "returns http success" do
      get question_path(1)
      expect(response).to have_http_status(:success)
    end
  end

  describe "#new" do
    context "as an authenticated user" do
      before do
        sign_in user
        get new_question_path
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "exists a correct page" do
        expect(response.body).to include("質問投稿")
        expect(response.body).to include(user.name)
      end
    end

    context "as a guest" do
      it "redirects to login page" do
        get new_question_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#create" do
    context "as an authorized user" do
      it "adds a new question" do
        sign_in user
        expect {
          post questions_path, params: { question: question_params }
        }.to change { Question.count }.by(1)
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in other_user
      end

      it "doesn't add a new question" do
        expect {
          post questions_path, params: { question: question_params }
        }.not_to change { Question.count }
      end

      it "redirects to question new page" do
        post questions_path, params: { question: question_params }
        expect(response).to redirect_to new_question_path
      end
    end
  end

  describe "#edit" do
    it "returns http success" do
      get edit_question_path(1)
      expect(response).to have_http_status(:success)
    end
  end

end
