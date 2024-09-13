extends Panel

onready var container = get_node("Container")
onready var maxhp = container.get_node("MaxHp")
onready var attackPower = container.get_node("AttackPower")
onready var maxap = container.get_node("MaxAp")
onready var maxmp = container.get_node("MaxMp")


func _process(_delta):
	maxhp.text = tr("MAX_HP") + ":" + str(PlayerControll.max_hp)
	maxmp.text = tr("MAX_MP") + ":" + str(PlayerControll.max_mp)
	maxap.text = tr("MAX_AP") + ":" + str(PlayerControll.max_ap)
	attackPower.text = tr("ATK") + ":" + str(PlayerControll.atk)
