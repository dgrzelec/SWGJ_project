extends Label

var score = 0

func _on_EnemyKill():
	score += 1
	text = "Kill Count: %s" % score
