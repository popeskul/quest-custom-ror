require 'i18n'

module FeatureHelpers
  def t(key)
    I18n.t(key)
  end
end
