require 'rails_helper'

RSpec.describe "Searches", type: :request do
  let(:school) { FactoryBot.create(:school) }
  let(:other_school) { FactoryBot.create(:school, name: "ランテック") }

  describe "#home" do
    it "returns a 200 response" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe "#result" do
    it "returns a 200 response" do
      get result_path
      expect(response).to have_http_status(200)
    end

    it "matches correct school when searching correct name" do
      @params = {}
      @params[:q] = { name_cont: school.name }
      @q = School.ransack(@params)
      @schools = @q.result
      expect(@schools).to include(school)
    end

    it "doesn't match correct school when searching uncorrect name" do
      @params = {}
      @params[:q] = { name_cont: other_school.name }
      @q = School.ransack(@params)
      @schools = @q.result
      expect(@schools.reload).not_to include(school)
    end

    it "matches all schools when name is blank" do
      @params = {}
      @params[:q] = { name_cont: nil }
      @q = School.ransack(@params)
      @schools = @q.result
      expect(@schools).to include(school)
      expect(@schools).to include(other_school)
    end
  end
end
