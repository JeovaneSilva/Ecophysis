extends Area2D
var play = 0 
var delete = false
func _on_body_entered(body):
	$Item_collect.play()
	
func _on_item_collect_finished():
		queue_free()
