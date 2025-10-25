extends Node2D

# --- Nodes ---
@onready var player_pizza_sprite: TextureRect = $CanvasLayer/PlayerPizza
@onready var target_pizza_sprite: TextureRect = $CanvasLayer/TargetPizza
@onready var score_label: Label = $CanvasLayer/ScoreLabel

@onready var button_cheese: TextureButton = $CanvasLayer/ButtonCheese
@onready var button_rucola: TextureButton = $CanvasLayer/ButtonRucola
@onready var button_pepperoni: TextureButton = $CanvasLayer/ButtonPepperoni
@onready var button_tomato: TextureButton = $CanvasLayer/ButtonTomato
@onready var button_submit: TextureButton = $CanvasLayer/ButtonSubmit
@onready var button_trash: TextureButton = $CanvasLayer/ButtonTrash

# --- Data ---
var current_ingredients: Array[String] = []
var current_target: Array = []
var score: int = 0

const RECIPES = [
	["pepperoni"],
	["rucola"],
	["cheese"],
	["tomato"],
	["cheese", "tomato"],
	["rucola", "pepperoni"],
	["cheese", "tomato", "pepperoni"],
	["cheese", "rucola"],
	["tomato", "pepperoni"],
	["cheese", "pepperoni"],
	["rucola", "tomato"],
	["rucola", "cheese", "tomato"]
]

const PIZZA_TEXTURES = {
	"": preload("res://Pizzeria/PNGs/pizzas/plain_pizza.png"),
	"cheese": preload("res://Pizzeria/PNGs/pizzas/cheese_pizza.png"),
	"pepperoni": preload("res://Pizzeria/PNGs/pizzas/pepperoni_pizza.png"),
	"rucola": preload("res://Pizzeria/PNGs/pizzas/rucola_pizza.png"),
	"tomato": preload("res://Pizzeria/PNGs/pizzas/tomato_pizza.png"),
	"cheese+tomato": preload("res://Pizzeria/PNGs/pizzas/cheese_tomato_pizza.png"),
	"pepperoni+rucola": preload("res://Pizzeria/PNGs/pizzas/pepperoni_rucola_pizza.png"),
	"cheese+pepperoni+tomato": preload("res://Pizzeria/PNGs/pizzas/cheese_pepperoni_tomato_pizza.png"),
	"cheese+rucola": preload("res://Pizzeria/PNGs/pizzas/cheese_rucola_pizza.png"),
	"pepperoni+tomato": preload("res://Pizzeria/PNGs/pizzas/pepperoni_tomato_pizza.png"),
	"cheese+pepperoni": preload("res://Pizzeria/PNGs/pizzas/cheese_pepperoni_pizza.png"),
	"rucola+tomato": preload("res://Pizzeria/PNGs/pizzas/rucola_tomato_pizza.png"),
	"cheese+rucola+tomato": preload("res://Pizzeria/PNGs/pizzas/cheese_rucola_tomato_pizza.png")
}


# --- READY ---
func _ready():
	reset_player_pizza()
	set_random_target_pizza()
	update_score_label()

	# Connect buttons
	button_cheese.pressed.connect(func(): add_ingredient("cheese"))
	button_rucola.pressed.connect(func(): add_ingredient("rucola"))
	button_pepperoni.pressed.connect(func(): add_ingredient("pepperoni"))
	button_tomato.pressed.connect(func(): add_ingredient("tomato"))
	button_submit.pressed.connect(_on_submit_pressed)
	button_trash.pressed.connect(_on_trash_pressed)


func _on_trash_pressed():
	reset_player_pizza()

func add_ingredient(ingredient: String):
	if ingredient not in current_ingredients:
		current_ingredients.append(ingredient)
		update_pizza_texture()


func update_pizza_texture():
	var sorted_ingredients = current_ingredients.duplicate()
	sorted_ingredients.sort()
	var key = "+".join(sorted_ingredients)
	if key in PIZZA_TEXTURES:
		player_pizza_sprite.texture = PIZZA_TEXTURES[key]
	else:
		print("⚠️ No texture for:", key)


func reset_player_pizza():
	current_ingredients.clear()
	player_pizza_sprite.texture = PIZZA_TEXTURES[""]


func set_random_target_pizza():
	current_target = RECIPES.pick_random()
	var sorted_target = current_target.duplicate()
	sorted_target.sort()
	var key = "+".join(sorted_target)
	if key in PIZZA_TEXTURES:
		target_pizza_sprite.texture = PIZZA_TEXTURES[key]
	else:
		print("⚠️ Missing target texture for:", key)


func _on_submit_pressed():
	var sorted_player = current_ingredients.duplicate()
	sorted_player.sort()
	var sorted_target = current_target.duplicate()
	sorted_target.sort()

	if sorted_player == sorted_target:
		score += 1
		print("✅ Correct! Score:", score)
	else:
		print("❌ Wrong pizza!")

	update_score_label()
	reset_player_pizza()
	set_random_target_pizza()


func update_score_label():
	score_label.text = "Score: " + str(score)
