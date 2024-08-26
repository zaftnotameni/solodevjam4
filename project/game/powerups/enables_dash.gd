class_name EnablesDash extends Node


func _ready() -> void:
	await try_again()

func try_again():
	await get_tree().process_frame
	var character : CharacterScene = CharacterScene.first()
	if not character: return await try_again()
	var components : PlayerComponents = PlayerComponents.resolve(character)
	if not components: return await try_again()
	var machine_button2 := components.resolve_machine_button2()
	if not machine_button2: return await try_again()
	machine_button2.transition.call_deferred(PlayerEnums.Button2.DASH, 'enables-dash')
