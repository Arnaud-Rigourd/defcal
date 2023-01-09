require 'json'
require 'open-uri'
require 'openfoodfacts'

class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update]
  before_action :set_meal, only: [:index, :create, :edit, :update, :show, :new]
  before_action :set_user
  before_action :set_api, only: :show

  def index
    @food = Food.new
    @foods = Food.all

    @quotes = ["Ajoute un ingrédient 🤌", "C'est l'heure de l'ingrédient secret 👀", "Un autre ingrédient chef ? 🫡"]

    @chef_quotes = ["L'apéritif, c'est la prière du soir des Français - Paul Morand", "La cuisine simple, c’est ce qu’il y a de plus compliqué - Joël Robuchon", " Il n’y a pas de bonne cuisine si au départ elle n’est pas faite par amitié pour celui ou celle à qui elle est destinée - Paul Bocuse", "La Cuisine, c’est l’envers du décor, là où s’activent les hommes et femmes pour le plaisir des autres… - Bernard Loiseau", "La perfection n’est pas de ce monde et certainement pas dans mon métier. En tout cas, tous les jours on se remet en question, on essaie de s’améliorer, demain on sera meilleur qu’hier - Alain Ducasse", "On se défend de lire ce qu’on écrit sur nous, d’abord parce que je n’ai pas le temps. … Je préfère lire ce qu’on écrit sur les autres. Ca construit - Alain Ducasse", "[...] Regardez ce que l’on rabâche aux petits enfants : la curiosité est un vilain défaut ! Mais non « pétard, il faut les encourager à être curieux ! - Guy Savoy", "Nous avons besoins de ceux qui font des produits exceptionnels et eux ont besoins de nous, qui magnifions les produits. Nous avons besoins les uns les autres - Guy Savoy"]
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
    @product_image = @product['product']['image_front_thumb_url']
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

  def set_user
    @user = current_user
  end

  def set_api
    url = "https://world.openfoodfacts.org/api/v0/product/#{@food.code}.json"
    product_serialized = URI.open(url).read
    @product = JSON.parse(product_serialized)
  end
end
