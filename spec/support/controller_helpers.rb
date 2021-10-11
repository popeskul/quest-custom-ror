# frozen_string_literal: true

# Helpers for test controllers
module ControllerHelpers
  def login(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in(user)
  end
end
