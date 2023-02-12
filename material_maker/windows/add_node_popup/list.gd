extends VBoxContainer

const NodeSelectionButton := preload("res://material_maker/windows/add_node_popup/node_selection_button.tscn")


signal object_selected(obj)


var button_pool := []


func clear() -> void:
	for bt in get_children():
		bt.disconnect("pressed",Callable(self,"_on_bt_pressed"))
		remove_child(bt)
		button_pool.append(bt)


func add_item(obj, path: String, name: String, icon: Texture2D = null) -> void:
	var bt = NodeSelectionButton.instantiate() if button_pool == [] else button_pool.pop_back()
	add_child(bt)
	bt.tooltip_text = path + "/" + name # Could add node description to this.
	bt.set_name(name)
	bt.set_path(path)
	bt.set_icon(icon)
	bt.connect("pressed",Callable(self,"_on_bt_pressed").bind(obj))


func _on_bt_pressed(obj) -> void:
	emit_signal("object_selected", obj)


func select_first() -> void:
	if get_child_count() != 0:
		get_children()[0].emit_signal("pressed")
