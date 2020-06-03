# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'imi-map@htw-berlin.de'
  layout 'mailer'
end
