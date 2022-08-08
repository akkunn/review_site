require 'rails_helper'

RSpec.describe School, type: :model do
  let(:school) { FactoryBot.create(:school) }

  it "is valid with a name, explanation" do
    expect(school).to be_valid
  end

  it "is invalid without a name" do
    school = FactoryBot.build(:school, name: nil)
    school.valid?
    expect(school.errors[:name]).to include("can't be blank")
  end

  it "is invalid without explanation" do
    school = FactoryBot.build(:school, explanation: nil)
    school.valid?
    expect(school.errors[:explanation]).to include("can't be blank")
  end

  it "is invalid 300 characters or more explanation" do
    school = FactoryBot.build(:school, explanation: "a" * 301)
    school.valid?
    expect(school.errors[:explanation]).
      to include("is too long (maximum is 300 characters)")
  end

  it "is invalid same name" do
    FactoryBot.create(:school, name: "ポテパンキャンプ")
    school = FactoryBot.build(:school, name: "ポテパンキャンプ")
    school.valid?
    expect(school.errors[:name]).to include("has already been taken")
  end
end
