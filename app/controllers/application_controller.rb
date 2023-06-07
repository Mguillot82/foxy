class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization

  after_action :verify_authorized, except: [:index], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: [:index], unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t "#{policy_name}.#{eexception.query}", scope: "pundit", default: :default
    redirect_back(fallback_location: root_path)
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
