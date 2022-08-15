require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe "validation" do
    let(:school) { FactoryBot.create(:school) }
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }
    let(:question) { FactoryBot.create(:question, user_id: other_user.id, school_id: school.id) }
    let(:answer) { FactoryBot.create(:answer, user_id: user.id, question_id: question.id) }

    it "is valid with a content, user_id, questoin_id" do
      expect(answer).to be_valid
    end

    it "is invalid without a content" do
      answer_nil_content = FactoryBot.build(:answer,
        content: nil, user_id: user.id, question_id: question.id)
      answer_nil_content.valid?
      expect(answer_nil_content.errors[:content]).to include("を入力してください")
    end

    it "is invalid without a user_id" do
      answer_nil_user_id = FactoryBot.build(:answer, user_id: nil, question_id: question.id)
      answer_nil_user_id.valid?
      expect(answer_nil_user_id.errors[:user_id]).to include("を入力してください")
    end

    it "is invalid without a question_id" do
      answer_nil_question_id = FactoryBot.build(:answer, user_id: user.id, question_id: nil)
      answer_nil_question_id.valid?
      expect(answer_nil_question_id.errors[:question_id]).to include("を入力してください")
    end
  end
end
