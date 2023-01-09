class PagesController < ApplicationController
  def dashboard
    @user = current_user
    @meals = @user.meals
  end

  def about
    @user = current_user
  end
end
