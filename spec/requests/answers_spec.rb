require 'rails_helper'

RSpec.describe "Answers", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:school) { FactoryBot.create(:school) }
  let(:question) { FactoryBot.create(:question, user_id: other_user.id, school_id: school.id) }
  let(:answer_params) {
    FactoryBot.attributes_for(:answer, user_id: user.id, question_id: question.id)
  }
  let(:other_answer_params) {
    FactoryBot.attributes_for(:answer, user_id: other_user.id, question_id: question.id)
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

end
