extends Node

enum Round_over {SEEKER_NO_LIVES, THIEF_CAUGHT, THIEF_FLED}
enum Game_over {PLAYER1_WINS, PLAYER2_WINS}
enum Players {PLAYER1, PLAYER2}
enum Roles {SEEKER, THIEF}

signal object_clicked(object_node: Node)

signal lives_changed(new_lives: int)
signal lives_depleted()

signal round_score_changed(new_score: int)
signal player_score_changed(player: Players, new_score: int)

signal round_over(condition: Round_over)

signal game_over(condition: Game_over)
