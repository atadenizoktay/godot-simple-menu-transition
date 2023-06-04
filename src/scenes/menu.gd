extends Control


const _TRANSITION_DURATION: float = 0.38

var _transition_progress: float = 1


func _unhandled_input(_event: InputEvent) -> void:
	_control_simple_menu_transition()


func _control_simple_menu_transition() -> void:
	if Input.is_action_just_pressed("ui_focus_next"):
		_simple_menu_transition()


func _simple_menu_transition() -> void:
	get_tree().root.gui_disable_input = true
	var next_transition_progress: float = 1 if _transition_progress == 0 else 0
	var tw: Tween = create_tween().set_trans(Tween.TRANS_QUART). \
			set_ease(Tween.EASE_OUT)
	tw.tween_method(_change_transition_progress, _transition_progress,
			next_transition_progress,_TRANSITION_DURATION)
	tw.tween_callback(get_tree().root.set_disable_input.bind(false))
	_transition_progress = next_transition_progress


func _change_transition_progress(progress: float) -> void:
	material.set_shader_parameter("transition_progress", progress)
