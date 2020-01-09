class Contact < MailForm::Base
  attribute :name,      validate: true
  attribute :email,     validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :nickname, captcha: true

  def headers
    {
      subject: "TestGuru contact's form",
      to: ENV['SMTP_USERNAME'],
      from: %("#{name}" <#{email}>)
    }
  end
end
