require 'rails_helper'

RSpec.describe School, type: :model do
  it "is valid with a name" do
    school = School.new(name: "ポテパンキャンプ")
    expect(school).to be_valid
  end

  it "is invalid without a name" do
    school = School.new(name: nil)
    school.valid?
    expect(school.errors[:name]).to include("can't be blank")
  end
end
