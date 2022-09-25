class AnswerMailer < ApplicationMailer
  def answer_mail(answer, user)
    @answer = answer
    mail from: 'プロコミ<853amtg@gmail.com>',
         to: user.email,
         subject: '質問への回答について'
  end
end
