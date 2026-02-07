extends Node

@export var config: GameConfig = preload("res://resources/default_settings.tres")

func _ready() -> void:
	reset_score()

var current_roles: Dictionary[Events.Players, Events.Roles] = {
	Events.Players.PLAYER1: Events.Roles.SEEKER,
	Events.Players.PLAYER2: Events.Roles.THIEF,
}

func swap_roles():
	if current_roles[Events.Players.PLAYER1] == Events.Roles.SEEKER:
		current_roles = {
			Events.Players.PLAYER1: Events.Roles.THIEF,
			Events.Players.PLAYER2: Events.Roles.SEEKER,
		}
	else:
		current_roles = {
			Events.Players.PLAYER1: Events.Roles.SEEKER,
			Events.Players.PLAYER2: Events.Roles.THIEF,
		}
		
func reset_roles():
	current_roles = {
		Events.Players.PLAYER1: Events.Roles.SEEKER,
		Events.Players.PLAYER2: Events.Roles.THIEF,
	}
	

var round_score: int = 0:
	set(value):
		round_score = value
		Events.round_score_changed.emit(round_score)

var score: Dictionary[Events.Players, int] = {
	Events.Players.PLAYER1: 0,
	Events.Players.PLAYER2: 0,
}

func update_score(player: Events.Players, new_score: int):
	score[player] = new_score
	Events.player_score_changed.emit(player, new_score)
	
	
func reset_score():
	score = {
		Events.Players.PLAYER1: 0,
		Events.Players.PLAYER2: 0,
	}

var current_lives: int = config.max_lives:
	set(value):
		current_lives = value
		Events.lives_changed.emit(current_lives)
		if current_lives <= 0:
			Events.round_over.emit(Events.Round_over.SEEKER_NO_LIVES)		

func reset_game_state():
	reset_roles()
	reset_score()
	round_score = 0
	current_lives = config.max_lives
	
