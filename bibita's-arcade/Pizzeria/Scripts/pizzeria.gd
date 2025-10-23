extends Node2D

var all_ingredients = ["tomato", "cheese", "basil", "pepperoni"]

var pizzas = [
	{"name": "Margherita", "ingredients": ["tomato", "cheese", "basil"]},
	{"name": "Pepperoni", "ingredients": ["tomato", "cheese", "pepperoni"]},
	{"name": "Veggie", "ingredients": ["tomato", "cheese", "basil", "pepperoni"]},
	{"name": "Carnivora", "ingredients": ["pepperoni"]},
	{"name": "Vegan", "ingredients": ["tomato","basil"]},
	{"name": "QuatroFormaggi", "ingredients": ["tomato","cheese"]}
]

var current_pizza = {}
var selected_ingredients = []

func _ready() {
	
}

func load_new_pizza():
	current_pizza = pizzas.pick_random()
	selected_ingredients.clear()
	$TargetPizzaIngredients.text = "Make: %s" % current_pizza["name"]
	$Score.text = "Score: %n"
