class_name Fire_Mage extends Dark_Mage

const PROJECTILE_PATH = "res://Assets/Enemy/World Enemy/Fire_Mage_Projectile.tscn"
var projectile_scene = preload(PROJECTILE_PATH)
var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
var key_chest

func _ready():
	battle_unit_xp = 25
	intro_dialog = "fire_mage.json"
	dath_dialog = "fire_mage_death.json"
	key_chest = get_tree().current_scene.key_chest

func create_projectile():
	if Global.stop: return
	for i in range(4):
		var projectile = projectile_scene.instance()
		projectile.direction = directions[i]
		projectile.position = position
		projectile.damage = battle_unit_damage + 1
		get_parent().add_child(projectile)

func _on_Text_Box_on_end_dialog():
	if spr.visible:
		Global.stop = false
		Global.cutscene = false
		SoundController.transition_to_music(SoundController.MUSIC.invasion)
		$Change_Position_Timer.start(3)
	else:
		SoundController.play_music(SoundController.MUSIC.florest)
		Global.stop = false
		Global.cutscene = false
		Global.dark_mages.fire_mage = true
		Global.QUESTS["DEFEAT_DARK_MAGES"].Progress+=1
		queue_free()

func _exit_tree():
	key_chest.Show()
