# frozen_string_literal: true

class ModelMailer < ApplicationMailer
  def send_inquiry
    mail to:  User.all.pluck(:email).join(','), subject: 'Inquiry form Website!'
  end
end
