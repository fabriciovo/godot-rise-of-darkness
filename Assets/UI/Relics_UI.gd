extends Control

onready var relic_list = $Relics_List.get_children()
onready var text_label = $Text_Label

var ring_icon = preload("res://Sprites/Button/ring_relic_icon.png")
var neckalce_icon = preload("res://Sprites/Button/necklace_relic_icon.png")
var boots_of_speed_icon = preload("res://Sprites/Button/boots_of_speed_icon.png")

func _ready():
	pass 

func set_relics():
	relic_list[0].grab_focus()
	for relic in PlayerControll.relics:
		match relic:
			Global.RELICS.RING_OF_DASH:
				relic_list[0].icon = ring_icon
				relic_list[0].disabled = false
				relic_list[0].text = ""
				text_label.bbcode_text = "Ring Text"
			Global.RELICS.NECKLACE_OF_PROTECTION:
				relic_list[1].icon = neckalce_icon
				relic_list[1].disabled = false
				relic_list[1].text = ""
			Global.RELICS.BOOTS_OF_SPEED:
				relic_list[2].icon = boots_of_speed_icon
				relic_list[2].disabled = false
				relic_list[2].text = ""

func _on_Ring_focus_entered():
	if relic_list[0].icon != null:
		text_label.bbcode_text = "Ring Text"
	else:
		text_label.bbcode_text = "?????"

func _on_necklace_focus_entered():
	if relic_list[1].icon != null:
		text_label.bbcode_text = "Necklace Text"
	else:
		text_label.bbcode_text = "?????"

func _on_Boots_Of_Speed_focus_entered():
	if relic_list[2].icon != null:
		text_label.bbcode_text = "Boots Text"
	else:
		text_label.bbcode_text = "?????"
