extends Panel

onready var hpLabel = $StatsContainer/HP
onready var mpLabel = $StatsContainer/MP
onready var apLabel = $StatsContainer/AP

func _ready():
	hpLabel.text = "HP\n"+str(PlayerControll.hp)
	mpLabel.text = "MP\n"+str(PlayerControll.mp)
	apLabel.text = "AP\n"+str(PlayerControll.ap)

func _on_PlayerStats_ap_changed(value):
	apLabel.text = "AP\n"+str(value)


func _on_PlayerStats_mp_changed(value):
	mpLabel.text = "MP\n"+str(value)


func _on_PlayerStats_hp_changed(value):
	hpLabel.text = "HP\n"+str(value)
