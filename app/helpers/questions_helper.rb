module QuestionsHelper
  def solve(question_solution)
    case question_solution
    when 0
      "未回答"
    when 1
      "未解決"
    when 2
      "解決済み"
    end
  end
end
