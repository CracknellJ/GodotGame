extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = -500
const ACCELERATION = 50
var motion = Vector2()
var PunchingFlag = false

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false

	#Animations relating to player input events
	if Input.is_action_just_pressed("ui_down") and PunchingFlag == false:
		PunchingFlag = true
		$AnimatedSprite.play("Punch")
	elif Input.is_action_pressed("ui_left") and PunchingFlag == false:
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Run")
	elif Input.is_action_pressed("ui_right") and PunchingFlag == false:
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Run")
	else:
		friction = true
		
	#Exit out of the running animation if the keys are no longer being pressed
	if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
		$AnimatedSprite.play("Idle")
	
	if is_on_floor():
		#Jumping code, needs refactoring honestly doesnt even do what i thought it did lol
		if Input.is_action_just_pressed("ui_up") and PunchingFlag == false:
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.1)
	else:
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.1)
	
	motion = move_and_slide(motion, UP)
	pass

#unlock player from attack animation root, if not running then play idle anim
func _on_AnimatedSprite_animation_finished():
	PunchingFlag = false
	if Input.is_action_pressed("ui_right") == false and Input.is_action_pressed("ui_left") == false:
		$AnimatedSprite.play("Idle")

