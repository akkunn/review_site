module ApplicationHelper
  BASE_TITLE = "プロコミ | プログラミングスクール口コミ・質問サイト".freeze

  def full_title(page_title)
    page_title.blank? ? BASE_TITLE : "#{page_title} | #{BASE_TITLE}"
  end
end
