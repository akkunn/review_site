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

    context 'correct parameter' do
      it "exists correct school" do
        @params = {}
        @params[:q] = { name_cont: school.name }
        @q = School.ransack(@params)
        @schools = @q.result
        expect(@schools).to include(school)
      end
    end

    context 'uncorrect parameter' do
      it "doesn't exist correct school" do
        @params = {}
        @params[:q] = { name_cont: other_school.name }
        @q = School.ransack(@params)
        @schools = @q.result
        expect(@schools.reload).not_to include(school)
      end
    end
  end
end
