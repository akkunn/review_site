require 'rails_helper'

RSpec.describe "Schools", type: :request do
  describe "#index" do
    it "return http success" do
      get schools_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "#new" do
    it "return http success" do
      get new_school_path
      expect(response).to have_http_status(:success)
    end
  end

end
