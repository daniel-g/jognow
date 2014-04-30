class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  def layout
    return false if controller_name != 'welcome'
    'application'
  end
end
