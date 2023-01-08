class PagesController < ApplicationController
  def dashboard
    @user = current_user
    @meals = @user.meals
    # @foods = @meals.map { |m| m.foods }
  end
end
