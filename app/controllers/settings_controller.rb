class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize current_user, :index?
    @user = current_user
  end
end
