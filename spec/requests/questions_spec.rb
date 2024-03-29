require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }
  let!(:other_school) { FactoryBot.create(:school) }
  let!(:question) { FactoryBot.create(:question, user_id: user.id, school_id: school.id) }
  let(:solved_question_noanswer) {
    FactoryBot.create(:question, user_id: user.id, school_id: school.id, solution: 2)
  }
  let(:solved_question) {
    FactoryBot.create(:question, user_id: user.id, school_id: school.id, solution: 2)
  }
  let(:other_school_question) {
    FactoryBot.create(:question, name: "難易度について", user_id: user.id, school_id: other_school.id)
  }
  let(:other_user_question) {
    FactoryBot.create(:question, name: "カリキュラムについて", user_id: other_user.id, school_id: school.id)
  }
  let!(:answer) { FactoryBot.create(:answer, user_id: other_user.id, question_id: question.id) }
  let!(:answer_solved_question) {
    FactoryBot.create(:answer, user_id: other_user.id, question_id: solved_question.id)
  }
  let(:question_params) {
    FactoryBot.attributes_for(:question, user_id: user.id, school_id: school.id)
  }
  let(:update_question_params) {
    FactoryBot.attributes_for(:question, name: "転職活動について", user_id: user.id, school_id: school.id)
  }

  describe "#index" do
    before do
      get questions_path(school_id: question.school_id)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "displays a correct page" do
      expect(response.body).to include(question.name)
      expect(response.body).to include(question.user.name)
      expect(response.body).to include(question.updated_at.to_s(:datetime_jp))
      expect(response.body).not_to include(other_school_question.name)
    end
  end

  describe "#show" do
    context "as an authenticated user" do
      before do
        sign_in user
        get question_path(question)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "displays a correct page" do
        expect(response.body).to include(question.user.name)
        expect(response.body).to include(question.name)
        expect(response.body).to include(question.content)
        expect(response.body).to include("編集する")
        expect(response.body).to include(answer.content)
        expect(response.body).to include("回答する")
      end
    end

    context "as an unauthorized user" do
      it "displays a correct page" do
        sign_in other_user
        get question_path(question)
        expect(response.body).to include(question.user.name)
        expect(response.body).to include(question.name)
        expect(response.body).to include(question.content)
        within ".question-box" do
          expect(response.body).not_to include("編集する")
        end
        expect(response.body).to include(answer.content)
        expect(response.body).to include("回答する")
      end
    end

    context "as a guest" do
      it "displays a correct page" do
        get question_path(question)
        expect(response.body).to include(question.user.name)
        expect(response.body).to include(question.name)
        expect(response.body).to include(question.content)
        expect(response.body).not_to include("編集する")
        expect(response.body).to include(answer.content)
        expect(response.body).not_to include("回答する")
      end
    end
  end

  describe "#new" do
    context "as an authenticated user" do
      before do
        sign_in user
        get new_question_path(school_id: school.id)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "displays a correct page" do
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

    context "as a guest" do
      before do
        post questions_path, params: { question: question_params }
      end

      it "doesn't add a new question" do
        expect {
          post questions_path, params: { question: question_params }
        }.not_to change { Question.count }
      end

      it "redirects to login page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#edit" do
    context "as an authenticated user" do
      before do
        sign_in user
        get edit_question_path(question)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "displays a correct page" do
        expect(response.body).to include(user.name)
        expect(response.body).to include(question.name)
        expect(response.body).to include(question.content)
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in other_user
        get edit_question_path(question)
      end

      it "redirects to question show page" do
        expect(response).to redirect_to question_path(question)
      end
    end

    context "as a guest" do
      it "redirects to login page" do
        get edit_question_path(question)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      it "updates a question" do
        sign_in user
        patch question_path(question), params: { question: update_question_params }
        expect(question.reload.name).to eq "転職活動について"
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in other_user
        patch question_path(question), params: { question: update_question_params }
      end

      it "doesn't update a question" do
        expect(question.reload.name).to eq "転職できますか？"
      end

      it "redirects to question show page" do
        expect(response).to redirect_to question_path(question)
      end
    end

    context "as a guest" do
      before do
        patch question_path(question), params: { question: update_question_params }
      end

      it "doesn't update a question" do
        expect(question.reload.name).to eq "転職できますか？"
      end

      it "redirects to login page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      it "deletes a question" do
        sign_in user
        expect {
          delete question_path(question)
        }.to change { Question.count }.by(-1)
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in other_user
      end

      it "doesn't delete a question" do
        expect {
          delete question_path(question)
        }.not_to change { Question.count }
      end

      it "redirects to question show page" do
        delete question_path(question)
        expect(response).to redirect_to question_path(question)
      end
    end

    context "as a guest" do
      before do
        delete question_path(question)
      end

      it "doesn't delete a question" do
        expect {
          delete question_path(question)
        }.not_to change { Question.count }
      end

      it "redirects to login page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#solved" do
    context "as an authorized user" do
      before do
        sign_in user
      end

      it "solved a question" do
        get solved_path(question_id: question.id)
        expect(question.reload.solution).to eq 2
      end

      it "changes from solved question to unsolved question when answer is nil" do
        get solved_path(question_id: solved_question_noanswer.id)
        expect(solved_question_noanswer.reload.solution).to eq 0
      end

      it "changes from solved question to unsolved question when an answer exists" do
        get solved_path(question_id: solved_question.id)
        expect(solved_question.reload.solution).to eq 1
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in other_user
        get solved_path(question_id: question.id)
      end

      it "doesn't solve a question" do
        expect(question.reload.solution).to eq 0
      end

      it "redirects to question show page" do
        expect(response).to redirect_to question_path(question)
      end
    end

    context "as a guest" do
      before do
        get solved_path(question_id: question.id)
      end

      it "doesn't solve a question" do
        expect(question.reload.solution).to eq 0
      end

      it "redirects to login page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
