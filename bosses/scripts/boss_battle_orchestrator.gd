@icon("res://general/icons/boss_orchestrator.svg")

class_name BossBattleOrchestrator
extends Node

signal battle_started
signal battle_ended
signal boss_reward_collected

@export var boss : Node
@export var trigger_area : Area2D

func _ready() -> void:
	if boss:
		boss.process_mode = Node.PROCESS_MODE_DISABLED
	
	if trigger_area:
		trigger_area.set_collision_mask_value(5, true)
		trigger_area.body_entered.connect(_on_body_entered)

func start_boss_battle() -> void:
	if boss:
		boss.process_mode = Node.PROCESS_MODE_INHERIT
		boss.tree_exiting.connect( end_boss_battle)

func end_boss_battle() -> void:
	print("Boss Battle Ended")

func _on_body_entered( _n : Node2D ) -> void:
	start_boss_battle()
	trigger_area.body_entered.disconnect(_on_body_entered)
	pass
