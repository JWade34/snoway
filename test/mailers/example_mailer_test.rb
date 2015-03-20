require 'test_helper'

class ExampleMailerTest < ActionMailer::TestCase
  def sample_mail_preview
    ExampleMailer.sample_email(User.first)
  end
end
