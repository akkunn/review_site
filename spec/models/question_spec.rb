require 'rails_helper'

RSpec.describe Question, type: :model do
  describe "validation" do
    let(:school) { FactoryBot.create(:school) }
    let(:user) { FactoryBot.create(:user) }
    let(:question) { FactoryBot.create(:question, user_id: user.id, school_id: school.id) }

    it "is valid with a name" do
      expect(question).to be_valid
    end

    it "is invalid without a name" do
      question_nil_name = FactoryBot.build(:question, name: nil)
      question_nil_name.valid?
      expect(question_nil_name.errors[:name]).to include("を入力してください")
    end

    it "is invalid without a content" do
      question_nil_content = FactoryBot.build(:question, content: nil)
      question_nil_content.valid?
      expect(question_nil_content.errors[:content]).to include("を入力してください")
    end

    it "is invalid without a user_id" do
      question_nil_user_id = FactoryBot.build(:question, user_id: nil)
      question_nil_user_id.valid?
      expect(question_nil_user_id.errors[:user_id]).to include("を入力してください")
    end

    it "is invalid 60 characters or more name" do
      question_long_name = FactoryBot.build(:question, name: "a" * 61)
      question_long_name.valid?
      expect(question_long_name.errors[:name]).
        to include("は60文字以内で入力してください")
    end
  end
end
