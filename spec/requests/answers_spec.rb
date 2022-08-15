require 'rails_helper'

RSpec.describe "Answers", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }
  let(:question) { FactoryBot.create(:question, user_id: other_user.id, school_id: school.id) }
  let!(:answer) { FactoryBot.create(:answer, user_id: user.id, question_id: question.id) }
  let(:answer_params) {
    FactoryBot.attributes_for(:answer, user_id: user.id, question_id: question.id)
  }
  let(:other_answer_params) {
    FactoryBot.attributes_for(:answer, user_id: other_user.id, question_id: question.id)
  }
  let(:update_answer_params) {
    FactoryBot.attributes_for(:answer, content: "転職についての情報をたくさん入手できます",
                                       user_id: user.id, question_id: question.id)
  }

  describe "#create" do
    context "as an authenticated user" do
      it "adds a new answer" do
        sign_in user
        expect {
          post answers_path, params: { answer: answer_params }
        }.to change { Answer.count }.by(1)
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in user
      end

      it "doesn't add a new answer" do
        expect {
          post answers_path, params: { answer: other_answer_params }
        }.not_to change { Answer.count }
      end

      it "redirects to question show page" do
        post answers_path, params: { answer: other_answer_params }
        expect(response).to redirect_to question_path(question)
      end
    end

    context "as a guest" do
      before do
        post answers_path, params: { answer: other_answer_params }
      end

      it "doesn't add a new answer" do
        expect {
          post answers_path, params: { answer: answer_params }
        }.not_to change { Answer.count }
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
        get edit_answer_path(answer), xhr: true
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "displays a correct page" do
        expect(response.body).to include(answer.content)
        expect(response.body).to include("変更")
        expect(response.body).to include("戻る")
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in other_user
        get edit_answer_path(answer), xhr: true
      end

      it "redirects to question show page" do
        expect(response).to redirect_to question_path(question)
      end
    end

    context "as a guest" do
      it "redirects to login page" do
        get edit_answer_path(answer), xhr: true
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      it "updates a answer" do
        sign_in user
        patch answer_path(answer), params: { answer: update_answer_params }
        expect(answer.reload.content).to eq "転職についての情報をたくさん入手できます"
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in other_user
        patch answer_path(answer), params: { answer: update_answer_params }
      end

      it "doesn't update a answer" do
        expect(answer.reload.content).to eq "面接対策をしてくれます"
      end

      it "redirects to question show page" do
        expect(response).to redirect_to question_path(question)
      end
    end

    context "as a guest" do
      before do
        patch answer_path(answer), params: { answer: update_answer_params }
      end

      it "doesn't update a answer" do
        expect(answer.reload.content).to eq "面接対策をしてくれます"
      end

      it "redirects to login page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      it "deletes a answer" do
        sign_in user
        expect {
          delete answer_path(answer)
        }.to change { Answer.count }.by(-1)
      end
    end

    context "as an unauthorized user" do
      before do
        sign_in other_user
      end

      it "doesn't delete a answer" do
        expect {
          delete answer_path(answer)
        }.not_to change { Answer.count }
      end

      it "redirects to question show page" do
        delete answer_path(answer)
        expect(response).to redirect_to question_path(question)
      end
    end

    context "as a guest" do
      before do
        delete answer_path(answer)
      end

      it "doesn't delete a answer" do
        expect {
          delete answer_path(answer)
        }.not_to change { Answer.count }
      end

      it "redirects to login page" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
