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
      expect(question_nil_name.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a user_id" do
      question_nil_user_id = FactoryBot.build(:question, user_id: nil)
      question_nil_user_id.valid?
      expect(question_nil_user_id.errors[:user_id]).to include("can't be blank")
    end

    it "is invalid without a school_id" do
      question_nil_school_id = FactoryBot.build(:question, school_id: nil)
      question_nil_school_id.valid?
      expect(question_nil_school_id.errors[:school_id]).to include("can't be blank")
    end
  end
end
