extends RigidBody2D

var max_life = 100
var life = 100

var max_mana = 100
var mana = 100

var max_stamina = 100
var stamina = 100

var move_speed = 60

var strength = 15
var melee_armor = 10
var magic_armor = 10

var is_invincible := false
onready var invincible_timer = Timer.new()
var invincible_time = 0.2

onready var ani = $AnimatedSprite

enum {
	STATE_IDLE
	STATE_MOVE
	STATE_LOSE_CONTROL
	STATE_LAUNCH
	STATE_ATTACK
}
var body_state = STATE_IDLE
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(invincible_timer)
	invincible_timer.one_shot = true
	invincible_timer.autostart = false
	invincible_timer.wait_time = invincible_time
	invincible_timer.connect("timeout", self, "_on_invincible_timer_timeout")

func _process(delta):
	pass

func _on_invincible_timer_timeout():
	self.is_invincible = false

func change_state(state):
	body_state = state

func get_damage(damage, type):
	match type:
		attack_type.ATTACK_TYPE_ELSE:
			life -= damage
		
		attack_type.ATTACK_TYPE_MELEE:
			if is_invincible:
				return
			else:
				change_state(STATE_LOSE_CONTROL)
				invincible_timer.start()
				is_invincible = true
				life -= clamp(damage - melee_armor, 1, max_life)
		
		attack_type.ATTACK_TYPE_MAGIC:
			if is_invincible:
				return
			else:
				change_state(STATE_LOSE_CONTROL)
				invincible_timer.start()
				is_invincible = true
				life -= clamp(damage - magic_armor, 1, max_life)