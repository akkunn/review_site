require 'rails_helper'

RSpec.describe "Questions", type: :request do
  describe "#index" do
    it "returns http success" do
      get questions_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "#show" do
    it "returns http success" do
      get question_path(1)
      expect(response).to have_http_status(:success)
    end
  end

  describe "#new" do
    it "returns http success" do
      get new_question_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "#edit" do
    it "returns http success" do
      get edit_question_path(1)
      expect(response).to have_http_status(:success)
    end
  end

end
