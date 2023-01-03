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
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    # set_api
    # @food.name = @food_h['product']['generic_name']
    # @food_calories = @food_h['product']['nutriments']['energy-kcal_100g']
    # @food_calories_unit = @food_h['product']['nutriments']['energy-kcal_unit']

    code = @food.code
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

  # def set_api
  #   url = "https://world.openfoodfacts.org/api/v0/product/#{@food.code}.json"
  #   food_serialized = URI.open(url).read
  #   @food_h = JSON.parse(food_serialized)
  # end

  def food_params
    params.require(:food).permit(:name, :calories, :code)
  end
end
