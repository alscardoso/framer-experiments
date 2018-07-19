InputModule = require "input-framer/input"

Framer.Defaults.Animation = 
	curve: Bezier(0.25, 0.1, 0.25, 1)

# SETUP
goals = []
goalNames = ["Learn React", "Teach Skillshare Class"]
items = 2

# GRADIENTS
gBlue = new Gradient
	start: "#7F00FF"
	end: "#00EAFF"
	angle: 64

# LAYERS

	
goalList = new Layer
	size: Screen.size
	gradient: gBlue

goalCompose = new Layer
	size: Screen.size
	backgroundColor: "#fff"
	y: 667

overlay = new Layer
	backgroundColor: "#000"
	opacity: 0
	size: Screen.size
overlay.placeBehind(goalCompose)	

closeIcon.parent = goalCompose
closeIcon.x = 20
closeIcon.y = 20

goalInput = new InputModule.Input
	parent: goalCompose
	placeholder: "Goal"
	fontSize: 42
	fontFamily: "SF Pro Display"
	fontWeight: 800
	color: "#ccc"
	letterSpacing: -1	
	y: 91
	x: 10
# 	virtualKeyboard: true
# 	autofocus:true

endDateLabel = new TextLayer
	parent: goalCompose
	text: "Days to complete:"
	fontSize: 18
	fontFamily: "SF Pro Display"
	fontWeight: 500
	color: "#ccc"
	letterSpacing: 0	
	y: 166
	x: 20

endDate = new InputModule.Input
	parent: goalCompose
	placeholder: "30"
	fontSize: 18
	fontFamily: "SF Pro Display"
	fontWeight: 500
	color: "#ccc"
	letterSpacing:0	
	y: 140
	x: 155


for i in [0...items]	
	goal = new Layer
		parent: goalList
		width: 300
		height: 80
		backgroundColor: "#fff"
		borderRadius: 3
		y: i * 90 + 50
		x: Align.center
		clip: true
		shadow1: 
			y: 1
			x: 0
			color: "rgba(0,0,0,0.3)"
			blur: 2
	
	goalName = new TextLayer
		parent: goal
		text: goalNames[i]
		fontSize: 14
		fontWeight: 600
		color: "#222"
		x: 16
		y: 14

	progress = new SliderComponent
		parent: goal
		width: 270
		height: 8
		x: Align.center
		y: 41
		value: i * (.5 + .2)
	progress.knob.visible = false	
	progress.fill.backgroundColor = "#24B24B "
	
	daysLeft = new TextLayer
		fontFamily: "SF Compact Display"
		parent: goal
		text: "28 days"
		fontSize: 10
		color: "#ccc"
		x: 16
		y: 57

addGoal = new Layer		
	parent: goalList
	width: 300
	height: 55
	backgroundColor: "#fff"
	borderRadius: 3
	y: i * 90 + 50
	x: Align.center
	shadow1: 
		y: 1
		x: 0
		color: "rgba(0,0,0,0.3)"
		blur: 2

addGoalLabel = new TextLayer
	parent: addGoal
	text: "Add a new goal"
	fontSize: 15
	color: "#00aaff"
	y: 17
	x: 57

addIcon.parent = addGoal
addIcon.y = 15
addIcon.x = 20	


addGoal.onTap ->
	overlay.animate
		opacity: 1
		
	goalCompose.animate
		y: 0
		
	
	goalInput.autofocus = true	
  
closeIcon.onTap ->
	overlay.animate
		opacity: 0
	goalCompose.animate
		y: 700
	
