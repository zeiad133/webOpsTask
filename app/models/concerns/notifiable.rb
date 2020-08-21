# frozen_string_literal: true

module Notifiable
  extend ActiveSupport::Concern

  def notify(title, body, tokens)
    client = Exponent::Push::Client.new
    messages = []
    tokens.each do |token|
      message = {
        to: token,
        sound: 'default',
        body: body,
        title: title
      }
      messages.push(message)
    end
    client.publish messages
  end
end
