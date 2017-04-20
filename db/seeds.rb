# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'
url = 'http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

ingredients = open(url).read

ingredients_hash = JSON.parse(ingredients)

ingredients = ingredients_hash['drinks'].map { |h| h['strIngredient1'] }

cocktail_names = ["margarita", "white russian", "sex on the beach", "AppleJack",
                  "Sunny Holiday Punch", "Lemon Drop", "After Dinner Cocktail",
                  "Patties Pis", "Kevins love potion", "A drink byJoe", "Robinacolada"]

ingredients.each do |ingredient|
  Ingredient.create(name: ingredient)
end

cocktail_names.each do |name|
  cocktail = Cocktail.new(name: name)
  cocktail.ingredients = Ingredient.all.sample(5)
  cocktail.save
end
