# frozen_string_literal: true

# Controller for all controllers
class ApplicationController < ActionController::Base
  include Pundit

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  def default_url_options
    { lang: (I18n.locale == I18n.default_locale ? nil : I18n.locale) }
  end

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, notice: exception.message
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:admin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:admin])
  end

  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end
end
