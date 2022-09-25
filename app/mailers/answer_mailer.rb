class AnswerMailer < ApplicationMailer
  def answer_mail(answer)
    @answer = answer
    mail from: 'プロコミ<853amtg@gmail.com>',
         to: @answer.question.user.email,
         subject: '質問への回答について'
  end
end
