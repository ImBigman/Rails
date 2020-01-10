class ApplicationMailer < ActionMailer::Base
  default from: ENV['SENDERS_MAIL']
  layout 'mailer'
end
