extends Panel

onready var container = get_node("Container")
onready var maxhp = container.get_node("MaxHp")
onready var attackPower = container.get_node("AttackPower")
onready var maxap = container.get_node("MaxAp")
onready var maxmp = container.get_node("MaxMp")


func _process(_delta):
	maxhp.text = "MAX_HP" + str(PlayerControll.max_hp)
	maxmp.text = "MAX_HP" + str(PlayerControll.max_mp)
	maxap.text = "MAX_HP" + str(PlayerControll.max_ap)
	attackPower.text = "ATK" + str(PlayerControll.atk)
