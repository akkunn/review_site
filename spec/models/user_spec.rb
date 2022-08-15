require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    it "has a valid factory" do
      expect(FactoryBot.build(:user)).to be_valid
    end

    it "is invalid without a name" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "is invalid without an email" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "is invalid without a password" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "is invalid with a duplicate email address" do
      FactoryBot.create(:user, email: "rails@example.com")
      user = FactoryBot.build(:user, email: "rails@example.com")
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end

    it "is invalid with a password 5 characters or less" do
      user = FactoryBot.build(:user, password: "a" * 5)
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end
  end
end
