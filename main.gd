extends Node2D

@onready var bg = $Bg
@onready var tachie = $Tachie
@onready var dialog = $UI/Dialog
@onready var dialog_name = $UI/Dialog/Label
@onready var dialog_text = $UI/Dialog/RichTextLabel
@onready var voice = $Voice
@onready var bgm = $Bgm

var step = 0

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		step += 1
		match(step):
			1:
				bg.texture = preload("res://assets/Bg-park.jpg")
				tachie.animation = "welcome"
				dialog.show()
				dialog_text.set_text("今天在小区门口，被一个穿运动装的妹子拦住，递给我一张传单。")
				bgm.stream = preload("res://assets/BGM-hotmilktea.mp3")
				bgm.play()
			2:
				tachie.animation = "wonderful0"
				tachie.play()
				dialog_name.set_text("运动装的妹子")
				dialog_text.set_text("帅哥！我们在隔壁商场新开了一个健身房。")
				voice.stream = preload("res://assets/Voice-welcome.ogg")
				voice.play()
			3:
				tachie.animation = "wonderful"
				tachie.play()
				dialog_text.set_text("设施条件啊……这么这么这么……那么那么那么……好……~~~")
				voice.stream = preload("res://assets/Voice-wonderful.ogg")
				voice.play()
			4:
				tachie.animation = "presale"
				dialog_text.text = "现在[font_size=9]预售[/font_size]，只要100元一个月哦！"
				voice.stream = preload("res://assets/Voice-presale.ogg")
				voice.play()
			_:
				dialog.set_text("The End.")
