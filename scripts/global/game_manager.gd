extends Node

@export var config: GameConfig = preload("res://resources/default_settings.tres")

func _ready():
	restartGame()
	Events.round_over.connect(_on_round_over)
	Events.game_over.connext(_on_game_over)
	
	Events.object_clicked.connect(_on_cursor_mouse_event)

func restartGame():
	GameState.resetGameState()
	switch_to_menu()
	
func _on_round_over(condition):
	handle_round_over(condition)

func _on_game_over(condition):
	switch_to_game_over(condition)

func start_next_round() -> void:
	if player1_score >= winning_score || player2_score >= winning_score:
		switch_to_game_over()
		return
	is_first_player_turn = !is_first_player_turn
	round_score = 0
	current_lives = max_lives
	get_tree().paused = false
	switch_to_controls()
	
func switch_to_level():
	current_state = State.PLAYING
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func switch_to_menu():
	current_state = State.MENU
	get_tree().change_scene_to_file("res://scenes/main_menu/main.tscn")
	
func switch_to_controls():
	current_state = State.MENU
	if is_first_player_turn:
		get_tree().change_scene_to_file("res://scenes/control_overview/control_overview.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/control_overview_round_2/control_overview.tscn")
	
func handle_round_over(condition: Events.Round_over) -> void:
	if condition == Events.Round_over.THIEF_CAUGHT:
		start_next_round()
		return
	if condition == Events.Round_over.SEEKER_NO_LIVES:
		GameState.round_score += config.seeker_penalty
	
	var thief_player = GameState.current_roles.find_key(Events.Roles.THIEF)
	GameState.update_score(thief_player, GameState.round_score) 
	

func switch_to_game_over():
	Events.game_over.emit()
	print("game over")

func _on_cursor_mouse_event(hit):
	print("HIT 📍 ", hit)
	if hit.is_in_group("player"):
		handle_round_over(Round_end_condition.THIEF_CAUGHT)
	if hit.is_in_group("npc"):
		current_lives = current_lives - 1
		if current_lives <= 0:
			handle_round_over(Round_end_condition.SEEKER_NO_LIVES)
		if current_lives > -1:
			Events.lives_changed.emit(current_lives)
