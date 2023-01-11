class PagesController < ApplicationController
  def dashboard
    @user = current_user
    @meals = @user.meals
    @last_meal = @meals.last
  end

  def about
    @user = current_user
  end
end
