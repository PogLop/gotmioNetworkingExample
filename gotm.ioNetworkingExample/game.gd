extends Control

onready var label = get_node("CenterContainer/VBoxContainer/text_label")
onready var input = get_node("CenterContainer/VBoxContainer/input")
onready var host_btn = get_node("CenterContainer/VBoxContainer/HBoxContainer/host")
onready var join_btn = get_node("CenterContainer/VBoxContainer/HBoxContainer/join")

func _on_submit_pressed():
	rpc("set_label_text", input.text)
	input.text = ""

func host():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(8070)
	get_tree().set_network_peer(peer)
	get_tree().connect("network_peer_connected", self, "_player_connected")

func join():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client("127.0.0.1", 8070)
	get_tree().set_network_peer(peer)
	
remotesync func set_label_text(text):
	label.text = text

func _on_host_pressed():
	host()
	host_btn.disabled = true
	join_btn.disabled = true

func _on_join_pressed():
	join()
	host_btn.disabled = true
	join_btn.disabled = true
