class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_meal, only: [:show, :destroy]
  before_action :set_user

  def index
    @meal = Meal.new
    if user_signed_in?
      @meals = @user.meals
    end
    # Meal.destroy_all if Meal.all.present?
  end

  def new
    @meal = Meal.new
  end

  def create

    if params[:meal].nil?
      @lunch_time = Time.parse("4 pm").strftime("%R")

        if Time.now.strftime("%R") < @lunch_time
          @name = "Déjeuner du #{Time.now.strftime("%d/%m/%y")}"
        else
          @name = "Diner du #{Time.now.strftime("%d/%m/%y")}"
        end

      @meal = Meal.new(name: @name)

    else
      @meal = Meal.new(meal_params)
      @meal.name = "#{@meal.name} du #{Time.now.strftime('%D')}"
    end

    @meal.user = @user

    if @meal.save
      redirect_to meal_foods_path(@meal)
    else
      redirect_to meals_path
    end
  end

  def show
    @foods = @meal.foods
    @total_calories = @foods.map { |f| f.calories.to_i * f.quantity.to_i/100 }
  end

  def meals_index
    @meals = @user.meals
    @meal = Meal.find(params[:id]) unless params[:id].nil?
  end

  def destroy
    @meal.destroy
    redirect_to meals_index_meals_path
  end

  private

  def meal_params
    params.require(:meal).permit(:name)
  end

  def set_user
    @user = current_user
  end

  def set_meal
    @meal = Meal.find(params[:id])
  end
end
