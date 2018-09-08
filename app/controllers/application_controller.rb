class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :unset_hsts
  include SessionsHelper

  def unset_hsts
    response.headers['Strict-Transport-Security'] = 'max-age=0; includeSubDomains'
  end
end
