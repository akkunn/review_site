require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validation" do
    let(:school) { FactoryBot.create(:school) }
    let(:user) { FactoryBot.create(:user) }
    let(:review) { FactoryBot.build(:review, user_id: user.id, school_id: school.id) }

    it "is valid with a name" do
      expect(review).to be_valid
    end

    it "is invalid without a name" do
      review = FactoryBot.build(:review, name: nil)
      review.valid?
      expect(review.errors[:name]).to include("can't be blank")
    end

    it "is invalid without user_id" do
      review = FactoryBot.build(:review, user_id: nil)
      review.valid?
      expect(review.errors[:user_id]).to include("can't be blank")
    end

    it "is invalid without school_id" do
      review = FactoryBot.build(:review, school_id: nil)
      review.valid?
      expect(review.errors[:school_id]).to include("can't be blank")
    end
  end
end
