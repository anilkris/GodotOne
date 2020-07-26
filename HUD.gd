extends CanvasLayer

var coins: int = 0
var lives: int = 3

func _ready():
	$Coins.text = String(coins)
	$Lives.text = String(lives)


func _on_coin_collected():
	print("Coins Got",coins)
	coins = coins + 1
	_ready()
	if(coins>=50):
		get_tree().change_scene("res://YouWin.tscn")
		





func _on_Enemy_gotcha_steve():
	print("they got steve")
	lives = lives - 1
	_ready()
	if(lives==0):
		get_tree().change_scene("res://GameOver.tscn")


