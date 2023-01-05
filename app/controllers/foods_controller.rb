require 'json'
require 'open-uri'
require 'openfoodfacts'

class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update]
  before_action :set_meal, only: [:index, :create, :edit, :update]

  def index
    @food = Food.new
    @foods = Food.all
    @food.meal = @meal
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.meal = @meal

    if @food.save
      redirect_to edit_meal_food_path(@meal, @food)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @products = Openfoodfacts::Product.search(@food.name)
  end

  def update

    if params[:food]["code"].present?
      code = params[:food]["code"]
      @product = Openfoodfacts::Product.get(code, locale: 'fr')
      @food.name = @product.product_name
      @food.calories = @product.nutriments.to_hash['energy-kcal_100g']
      # raise

      if @food.update(food_params)
        redirect_to meal_food_path(@meal, @food)
      else
        render :edit, status: :unprocessable_entity
      end

    else
      @food.name = params[:food]['name']
      @products = Openfoodfacts::Product.search(@food.name)

      if @food.update(food_params)
        redirect_to edit_meal_food_path(@meal, @food)
      else
        render :edit, status: :unprocessable_entity
      end
    end

  end

  def show
    @actual_calories = @food.calories.to_i * @food.quantity.to_i/100
  end

  def search
  end

  private

  def food_params
    params.require(:food).permit(:name, :calories, :code, :quantity)
  end

  def set_food
    @food = Food.find(params[:id])
  end

  def set_meal
    @meal = Meal.find(params[:meal_id])
  end
end
