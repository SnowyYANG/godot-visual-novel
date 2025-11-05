extends Node2D

@onready var bg = $Bg
@onready var tachie = $Tachie
@onready var dialog = $UI/Dialog
@onready var dialog_name = $UI/Dialog/Label
@onready var dialog_text = $UI/Dialog/RichTextLabel
@onready var voice = $Voice
@onready var bgm = $Bgm
@onready var options = $UI/Options

var step = 0
var ed = 0
var week = 0

func story(step):
	match(step):
		0:
			return story(1)
		1:
			bg.texture = preload("res://assets/BG-park.jpg")
			tachie.show()
			tachie.animation = "welcome"
			dialog.show()
			type_text("今天在小区门口，被一个穿运动装的妹子拦住，递给我一张传单。")
			bgm.stream = preload("res://assets/BGM-hotmilktea.mp3")
			bgm.play()
		2:
			tachie.animation = "wonderful0"
			tachie.play()
			dialog_name.text = "运动装的妹子"
			type_text("帅哥！我们在隔壁商场新开了一个健身房。")
			voice.stream = preload("res://assets/Voice-welcome.ogg")
			voice.play()
		3:
			tachie.animation = "wonderful"
			tachie.play()
			type_text("设施条件啊……这么这么这么……那么那么那么……好……~~~")
			voice.stream = preload("res://assets/Voice-wonderful.ogg")
			voice.play()
		4:
			tachie.animation = "presale"
			type_text("现在[font_size=9]预售[/font_size]，只要100元一个月哦！")
			voice.stream = preload("res://assets/Voice-presale.ogg")
			voice.play()
		5:
			options.show()
			options.get_child(0).text = "马上付款"
			options.get_child(1).text = "先去现场看看"
			return 5
		10:
			dialog_name.text = "我"
			type_text("那我先去看看。")
		11:
			tachie.animation = "shame2normal"
			dialog_name.text = "运动装的妹子"
			type_text("好的呀，就在商场B区，特别好找！")
			voice.stream = preload("res://assets/Voice-justthere.ogg")
			voice.play()
		12:
			bg.texture = preload("res://assets/BG-comingsoon.jpg")
			tachie.hide()
			dialog_name.text = ""
			type_text("我走到商场B区，果然看到一个围起来正在装修的门面，上面简单贴了张纸：“健身会所，敬请期待。”")
			voice.stop()
		13:
			type_text("要我付的100元，怕不是他们欠的装修队尾款的1/N吧。")
			ed = 0
			return 88
		20:
			tachie.animation = "normal"
			type_text("下周一，我们不见不散！")
			voice.stream = preload("res://assets/Voice-seeyou.ogg")
			voice.play()
		21:
			bg.texture = preload("res://assets/BG-blank.jpg")
			bg.modulate = Color(0.34, 0.568, 0.569, 1.0)
			tachie.hide()
			dialog_name.text = ""
			type_text("周一，我兴冲冲赶到商场。")
		22:
			bg.texture = preload("res://assets/BG-comingsoon.jpg")
			bg.modulate = Color(1,1,1)
			type_text("眼前的景象让我石化——一个围起来正在装修的门面，上面简单贴了张纸：“健身会所，敬请期待。”")
			bgm.stream = preload("res://assets/BGM-utaukizu.mp3")
			bgm.play()
		23:
			dialog_name.text = "妹子（微信）"
			type_text("实在不好意思呢亲~消防检查还没通过，我们再耐心等一周哦~[可爱表情包]")
		24:
			options.show()
			options.get_child(0).text = "再等一周"
			options.get_child(1).text = "要求退费"
			return 24
		25:
			dialog_name.text = ""
			if week == 1:
				type_text("第二周过去了，健身房依然没有开业的迹象。")
			elif week == 3:
				type_text("一个月过去了，健身房依然没有开业的迹象。")
			elif week == 7:
				type_text("两个月过去了，健身房依然没有开业的迹象。")
			elif week < 7:
				type_text("又是一周过去了，健身房依然没有开业的迹象。")
			else:
				type_text("这个健身房看来是不会开业了……")
		26:
			dialog_name.text = "妹子（微信）"
			if week > 7:
				type_text("亲爱的~真的很抱歉呢……")
			else:
				type_text("亲爱的~真的很抱歉呢~这样这样这样……那样那样那样……我们再耐心等一周哦~[可爱表情包]")
			return 24
		50:
			dialog_name.text = ""
			type_text("我坚持要求退费，妹子给了我一个“领导电话”。")
		51:
			dialog_name.text = "领导"
			type_text("退费？行，按规定扣30%手续费。")
			voice.stream = preload("res://assets/Voice-refund.ogg")
			voice.play()
			ed = 5
			return 88
		88:
			bg.texture = preload("res://assets/BG-blank.jpg")
			bg.modulate = Color(0,0,0)
			dialog.hide()
			$UI/Credits/AnimationPlayer.play("up")
			if ed == 0:
				return 99
			else:
				return 100
		99:
			$UI/Credits/AnimationPlayer.play("RESET")
			$BgColor/Label.hide()
			bg.texture = preload("res://assets/CG.jpg")
			bg.modulate = Color(1,1,1)
			bgm.stream = preload("res://assets/BGM-utaukizu.mp3")
			bgm.play()
			voice.stream = preload("res://assets/Voice-afterstory.ogg")
			voice.play()
			$Bg/EffectsAfterstory.show()
			$Bg/EffectsAfterstory/AnimationPlayer.play("fade")
		100:
			pass
	return step + 1

func _on_option_pressed(index) -> void:
	match(step):
		5:
			if index == 1:
				step = story(10)
			if index == 0:
				step = story(20)
		24:
			if index == 1:
				step = story(50)
			if index == 0:
				week += 1
				step = story(25)
	options.hide()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		step = story(step)

var _type_id = 0
var _typing_total_chars = 0
var type_speed = 0.03  # 秒/字符，按需要调整
func type_text(text: String, char_delay: float = -1.0) -> void:
	if char_delay <= 0:
		char_delay = type_speed
	_type_id += 1
	var id = _type_id
	dialog_text.bbcode_text = text
	await get_tree().process_frame
	_typing_total_chars = dialog_text.get_total_character_count()
	if _typing_total_chars <= 0:
		_typing_total_chars = 0
		return
	dialog_text.visible_characters = 0
	var i = 0
	while i < _typing_total_chars:
		if id != _type_id:
			return
		i += 1
		dialog_text.visible_characters = i
		await get_tree().create_timer(char_delay).timeout
	_typing_total_chars = 0

func _on_restart_button_pressed() -> void:
	restart()

func restart():
	$BgColor/Label.show()
	bg.texture = null
	bg.modulate = Color(1,1,1)
	tachie.hide()
	dialog.hide()
	dialog_name.text = ""
	options.hide()
	$UI/Credits/AnimationPlayer.play("RESET")
	$Bg/EffectsAfterstory.hide()
	$Bg/EffectsAfterstory/AnimationPlayer.play("RESET")
	step = 0
	ed = 0
	week = 0
	voice.stop()
	bgm.stop()
	
