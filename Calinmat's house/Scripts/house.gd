extends Node2D

@onready var monster_container = $Monsters
@onready var turn_label = $CanvasLayer/TurnCounter
@export var monster_scene: PackedScene
@export var total_pairs := 8

var flipped_monsters: Array = []
var matched_count := 0
var turns := 0
var is_checking := false

func _ready():
	spawn_cards()
	update_turn_label()

func spawn_cards():
	var ids = []
	for i in range(total_pairs):
		ids.append(i)
		ids.append(i)
	ids.shuffle()
	
	var columns = 4
	var spacing = Vector2(140, 140)
	var start_pos = Vector2(375, 150)
	
	for i in range(ids.size()):
		var monster = monster_scene.instantiate()
		monster.monster_id = ids[i]
		monster.position = start_pos + Vector2((i % columns) * spacing.x, floor(i / columns) * spacing.y)
		monster.connect("flipped", Callable(self, "_on_monster_flipped"))
		monster_container.add_child(monster)

func _on_monster_flipped(monster):
	if is_checking or flipped_monsters.size() >= 2:
		return
	
	flipped_monsters.append(monster)
	
	if flipped_monsters.size() == 2:
		is_checking = true
		set_all_cards_input(false) 
		turns += 1
		update_turn_label()
		await get_tree().create_timer(0.8).timeout
		check_match()
		set_all_cards_input(true) 
		is_checking = false

func check_match():
	var first = flipped_monsters[0]
	var second = flipped_monsters[1]
	
	if first.monster_id == second.monster_id:
		matched_count += 1
		first.disabled = true
		second.disabled = true
		if matched_count == total_pairs:
			game_won()
	else:
		first.flip_back()
		second.flip_back()
	
	flipped_monsters.clear()

func set_all_cards_input(enabled: bool):
	for monster in monster_container.get_children():
		if not monster.disabled:  
			monster.set_process_input(enabled)
			monster.mouse_filter = Control.MOUSE_FILTER_IGNORE if not enabled else Control.MOUSE_FILTER_STOP

func update_turn_label():
	turn_label.text = "Turns: %d" % turns

func game_won():
	turn_label.text = "🎉 You won in %d turns!" % turns
	print("You win!")
	
	await get_tree().create_timer(5.0).timeout
	reset_game()
	
func reset_game():
	for monster in monster_container.get_children():
		monster.queue_free()
	
	flipped_monsters.clear()
	matched_count = 0
	turns = 0
	is_checking = false
	
	await get_tree().process_frame
	
	spawn_cards()
	update_turn_label()
