class UsersController < ApplicationController
  before_action :authenticate_user!

  def show_me
  end
end
