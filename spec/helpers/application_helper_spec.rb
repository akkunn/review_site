require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "full_title" do
    it "exists full_title" do
      expect(helper.full_title('プログラミングスクール一覧')).
        to eq('プログラミングスクール一覧 | プロコミ | プログラミングスクール口コミ・質問サイト')
    end

    it "is full_title blank" do
      expect(helper.full_title('')).to eq('プロコミ | プログラミングスクール口コミ・質問サイト')
    end

    it "is full_title nil" do
      expect(helper.full_title(nil)).to eq('プロコミ | プログラミングスクール口コミ・質問サイト')
    end
  end
end
