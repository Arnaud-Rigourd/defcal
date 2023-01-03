require 'json'
require 'open-uri'
require 'openfoodfacts'

class FoodsController < ApplicationController
  before_action :set_api, only: [:index]

  def index
    @foods = Food.all
  end

  def create
    @food = Food.new(food_params)
  end

  private

  def set_api
    @food = Food.new
    url = "https://world.openfoodfacts.org/api/v0/product/#{@food}.json"
    food_serialized = URI.open(url).read
    @food = JSON.parse(food_serialized)
  end

  def food_params
    params.require(:food).permit(:name, :calories, :code)
  end
end
