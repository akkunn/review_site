require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation test" do
    before do
      @user = User.create(
        name: "rails",
        email: "test@example.com",
        password: "password"
      )
    end

    it "is valid with a name, email, password" do
      expect(@user).to be_valid
    end

    it "is invalid without a name" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "is invalid without an email" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do
      user = User.new(password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid with a duplicate email address" do
      user = User.new(
        name: "ruby",
        email: "test@example.com",
        password: "password"
      )
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "is invalid with a password 5 characters or less" do
      user = User.new(
        name: "rails",
        email: "test@example.com",
        password: "a" * 5
      )
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end
end
