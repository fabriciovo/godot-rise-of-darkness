extends Panel


onready var maxhp = get_node("MaxHp")
onready var attackPower = get_node("AttackPower")
onready var maxap = get_node("MaxAp")
onready var maxmp = get_node("MaxMp")


func _process(delta):
	maxhp.text = "Max HP: " + str(PlayerControll.max_hp)
	maxmp.text = "Max MP: " + str(PlayerControll.max_mp)
	maxap.text = "Max AP: " + str(PlayerControll.max_ap)
	attackPower.text = "Attack Power: " + str(PlayerControll.atk)
