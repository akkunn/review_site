class Users::Mailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'
  default from: 'プロコミ<853amtg@gmail.com>'
  default reply_to: '853amtg@gmail.com'

  def confirmation_instructions(record, token, opts={})
    opts[:subject] = "メールアドレス確認メール"
    super
  end

  def reset_password_instructions(record, token, opts={})
    opts[:subject] = "パスワードの再設定について"
    super
  end
end
