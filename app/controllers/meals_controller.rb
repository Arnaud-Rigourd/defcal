class MealsController < ApplicationController

  def index
    @meal = Meal.new
    @meals = Meal.all
    Meal.destroy_all if Meal.all.present?
  end

  def create
    @lunch_time = Time.parse("4 pm").strftime("%r")

    if Time.now.strftime("%r") < @lunch_time
      @name = 'Lunch'
    else
      @name = 'Diner'
    end

    @meal = Meal.new(name: @name)

    if @meal.save
      redirect_to meal_foods_path(@meal)
    else
      redirect_to meals_path
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name)
  end
end
