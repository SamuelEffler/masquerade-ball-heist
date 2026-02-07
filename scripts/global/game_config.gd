extends Resource
class_name GameConfig

@export_group("Game state")
@export var winning_score: int = 100000
@export var max_lives: int = 4
@export var seeker_penalty: int = 10000

@export_group("Movement")
@export var base_speed: float = 300.0
