class Users::Mailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'
  default from: 'プロコミ<853amtg@gmail.com>'
  default reply_to: '853amtg@gmail.com'

  def confirmation_instructions(record, token, opts={})
    #record内にユーザ情報が入っていました。そこの"unconfirmed_email"の有無で登録／変更を仕分けます
    #opts属性を上書きすることで、Subjectやfromなどのヘッダー情報を変更することが可能！
    if record.unconfirmed_email != nil
      opts[:subject] = "【●●●アプリ】メールアドレス変更手続きを完了してください"
    else
      opts[:subject] = "【●●●アプリ】会員登録完了"
    end
    #件名の指定以外は親を継承
    super
  end

  def reset_password_instructions(record, token, opts={})
    # headers["Custom-header"] = "Bar"
    # opts[:from] = 'プロコミ<853amtg@gmail.com>'
    # opts[:reply_to] = '853amtg@gmail.com'
    opts[:subject] = "【●●●アプリ】会員登録完了"
    super
  end
end
