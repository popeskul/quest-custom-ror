# frozen_string_literal: true

require 'i18n'

# Helpers for features
module MailerHelpers
  def t(key)
    I18n.t(key)
  end
end
