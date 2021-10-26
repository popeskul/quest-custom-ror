# frozen_string_literal: true

require 'i18n'

# Helpers for features
module FeatureHelpers
  def t(key)
    I18n.t(key)
  end

  def sign_in(user)
    visit user.instance_of?(User) ? new_user_session_path : new_staff_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end
end
