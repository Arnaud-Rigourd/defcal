require 'json'
require 'open-uri'
require 'openfoodfacts'

class FoodsController < ApplicationController
  # before_action :set_api, only: [:index]

  def index
    @foods = Food.all
    @food = Food.new
  end

  def show
    @food = Food.find(params[:id])
    @actual_calories = @food.calories.to_i * @food.quantity.to_i/100
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)

    @products = Openfoodfacts::Product.search(@food.name)

    @product = @products.first

    @food.code = @product.code
    code = @product.code
    @product = Openfoodfacts::Product.get(code, locale: 'fr')
    @food.name = @product.product_name
    @food.calories = @product.nutriments.to_hash['energy-kcal_100g']

    if @food.save
      redirect_to food_path(@food)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :calories, :code, :quantity)
  end
end
