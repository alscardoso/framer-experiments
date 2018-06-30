
# SETUP
Framer.Screen.backgroundColor = "#000"
Framer.Defaults.Animation = 
	curve: "spring(255,25,0)"
count = 8
totalScroll = 4
videos = []
scrollList = []
cards = []
labels = ["For You","Following", "Popular", "Continue Watching"]
x = 0

# LOAD DATA
users = JSON.parse Utils.domLoadDataSync  "https://randomuser.me/api/?results=8"
# LAYERS

# video player
videoWrapper = new Layer
	size: Screen.size
	backgroundColor: null

# panel
panel = new Layer
	width: Screen.width
	y: 289
	height: 378
	backgroundColor: null
# 	visible:false
panel.originalFrame = panel.frame
panel.draggable.enabled = true
panel.draggable.horizontal = false
panel.placeBefore(videoWrapper)
panel.draggable.directionLock = true
# panel.draggable.constraints=
# 	y: 30
# 
# panel.draggable.overdragScale = 0.25	

header = new Layer
	parent: panel
	width: Screen.width
	height: 57
	backgroundColor: null	

searchIco.parent = header
searchIco.x =  12
searchIco.y = 13
searchIco.opacity = .4

search = new TextLayer
	parent: header
	fontSize: 16
	text: "Search IGTV"
	x: 49
	y: 17
	color: "rgba(255,255,255,0.4)"
		
controls = new Layer
	parent: panel
	width: Screen.width
	y: 57
	height: 321
	y: Align.bottom
	backgroundColor: null

line = new Layer
	parent: controls
	width:420
	height: 1
	y: 32
	backgroundColor: "rgba(0,0,0,0.2)"

underline = new Layer
	parent: controls
	height: 2
	width: 58
	y: 31
	x: 12
	backgroundColor: "rgba(255,255,255,0.2)"
	
scroll = new ScrollComponent
	parent: controls
	width: Screen.width
	height: 272
	scrollVertical: false
	y: 49
scrollList.push(scroll)

for i in [0...4]
	tab = new TextLayer
		parent: controls
		fontSize: 16
		text: labels[i]
		x: i * 86 + 12
		fontWeight: 600
		color: "rgba(255,255,255,0.4)"

for card in [0...count]
	card = new Layer
		parent: scroll.content
		x: (card * 172)+ 12
		width: 164
		height: 255
		borderRadius: 5
		image: "images/0#{card}.png"
	
	videoTitleCard = new TextLayer
		parent: card
		fontSize: 14
		fontWeight: 700
		shadowY:1
		shadowColor: "rgba(0,0,0,.5)"
		text: "Sao Miguel Island, Azores"
		color: "#fff"
		y: 176
		width: 120
		x: 13
		
	avatarCard = new Layer
		parent: card
		size:30
		borderRadius: 100
		x: 11
		y: 216
		image: users.results[x].picture.thumbnail
	
	x++
	
	userCard = new TextLayer
		parent: card
		fontSize: 14
		fontWeight: 600
		text: "rafael"
		x: 47
		color: "rgba(255,255,255,0.9)"
		y: 221	
		
	timeCard = new TextLayer
		parent: card
		fontSize: 14
		fontWeight: 600
		text: "1:35"
		x: 124
		color: "rgba(255,255,255,0.9)"
		shadowY: 1
		shadowBlur:2
		shadowColor: "rgba(0,0,0,.3)"
		y: 12		
		
	cards.push(card)	
	
	# card states
	card.states.active = 
		borderWidth: 1.5
		borderColor: "#fff"
	# card Events
	# switch card and video
	card.onTap ->
		card.stateSwitch("default") for card in cards
		this.stateCycle()

cards[0].stateSwitch("active")

# overlay
overlay = new Layer
	size: Screen.size
	backgroundColor: null
		
# player
player = new Layer
	size: Screen.size
	backgroundColor: null

videoMeta = new Layer
	parent: player
	width: Screen.width
	height: 96
	backgroundColor: null
	opacity: 0

videoTitle = new TextLayer
	parent: videoMeta
	fontSize: 20
	fontWeight: 700
	shadowY:1
	shadowColor: "rgba(0,0,0,.2)"
	text: "Sao Miguel Island, Azores"
	color: "#fff"
	x: 12
	y: 14
	
avatar = new Layer
	parent: videoMeta
	size:30
	borderRadius: 100
	x: 12
	y: 48
	image: users.results[0].picture.thumbnail

user = new TextLayer
	parent: videoMeta
	fontSize: 14
	fontWeight: 600
	text: "rafael"
	x: 55
	color: "rgba(255,255,255,0.5)"
	y: 55

postTime = new TextLayer
	parent: videoMeta
	fontSize: 14
	fontWeight: 400
	text: "6 hours ago"
	x: 99
	color: "rgba(255,255,255,0.5)"
	y: 55

playerUI = new Layer
	parent: player
	y: 547
	width: Screen.width
	height: 120
	backgroundColor: null
	opacity: 0
	
pIcons.parent = playerUI
# pIcons.placeBefore(panel)	
pIcons.x = 12
pIcons.y = 28
views = new TextLayer
	parent: playerUI
	fontSize: 14
	text: "15 views"
	x: 16
	color: "rgba(255,255,255,0.5)"

browse = new Layer
	parent: playerUI
	width: 88
	y: 28
	height: 33
	x: 271
	borderWidth: 1.5
	borderRadius: 6
	borderColor: "#fff"
	backgroundColor: null
	
browseLabel = new TextLayer
	parent: browse
	fontSize: 14
	text: "Browse"
	color: "#fff"
	x: 30
	y: 7
arrow.parent = browse
arrow.x= 5
arrow.y = 4

# player controls
playerControls.parent = playerUI
playerControls.x = 0
playerControls.y = 78
time = new TextLayer
	parent: playerUI
	fontSize: 12
	text: "0:0"
	color: "#fff"
	x: 338
	y: 91
	
player.placeBehind(panel)	

gradient = new Layer
	size: Screen.size
	gradient:
		start: "rgba(0,0,0,1)"
		end: "rgba(0,0,0,0)"
		
gradient.placeBehind(player)
overlay.placeBefore(player)

# video
for vid in [0..2]
	video = new VideoLayer
		width: 375
		height: 360	
		scale:2
		backgroundColor: null
		parent: videoWrapper
		video: "videos/0#{vid}.mp4"
		y: 127
	
	videos.push(video)	

videos[2].player.autoplay = true	
videos[1].visible = false

# video2 = new VideoLayer
# 	width: 375
# 	height: 360	
# 	scale:2
# 	backgroundColor: null
# 	parent: videoWrapper
# 	video: "videos/01.mp4"
# 	visible:false
# 	y: 127

# video.player.autoplay = true	
seekBar = new SliderComponent
	parent:playerUI
	min: 0
	max: 17
	x: 45
	y: 97
	borderRadius: 4
	height:5
	width: 280
	backgroundColor: "rgba(255,255,255,.2)"
	
seekBar.knob.draggable.momentum = false
seekBar.knob.visible = false	
seekBar.fill.backgroundColor = "#00aaff"
wasPlaying = false
	
# functions
showPlay = ->
	playIcon.visible = true
	pauseIcon.visible = false
	video.player.pause()
	
showPause = ->
	playIcon.visible = false
	pauseIcon.visible = true
	video.player.play()

#load with thumbnail on mobile
# videos[0].player.play()	
# Utils.delay 0.25, -> showPlay()

# STATES
playerUI.states.hide =
	opacity:0

playerUI.states.show =
	opacity:1

videoMeta.states.hide =
	opacity:0	
	
videoMeta.states.show =
	opacity:1		

# EVENTS
# scrubbing
seekBar.knob.onDragStart ->
	wasPlaying = true unless video.player.paused
	video.player.pause()

seekBar.knob.onDragEnd ->	
	video.player.currentTime = seekBar.value
	if wasPlaying then showPause()
	return wasPlaying = false

seekBar.on "change:value" ,->
	newTime = Utils.round(this.value, 1)
	currentTime = Utils.round(video.player.currentTime, 1)
	video.player.currentTime = newTime unless newTime == currentTime

# video.player.on "timeupdate", ->
Events.wrap(video.player).addEventListener "timeupdate", ->	
	seekBar.knob.midX = seekBar.pointForValue(this.currentTime)
	time.text = "0:0" + Math.round(this.currentTime)
	if Math.round(this.currentTime) > 9 then time.text = "0:" + Math.round(this.currentTime)
	
# play, pause events
playIcon.onTap ->
	
	showPause()
	
	if video.player.currentTime is video.player.duration
		video.player.currentTime = 0
		showPause()
	
pauseIcon.onTap -> 
	showPlay()
video.player.onplaying = -> showPause()
video.player.onended = -> showPlay()		
	
# tap overlay, push panel down
overlay.onTap ->
	panel.animate
		y: 667
	overlay.ignoreEvents = true
	
playerUI.onTapStart ->
	videoWrapper.ignoreEvents = true

playerUI.onTapEnd ->
	videoWrapper.ignoreEvents = false			

videoWrapper.onTap ->
	playerUI.stateCycle("hide","show")	
	videoMeta.stateCycle("hide","show")

# on drag end update panel position
panel.onDragEnd ->
	if panel.screenFrame.y < 400
		panel.animate
			y: panel.originalFrame.y
	if panel.screenFrame.y > 380
		panel.animate
			y: 667		
	
	overlay.ignoreEvents = true
	
panel.on "change:y", ->
	videoMeta.opacity = Utils.modulate(panel.screenFrame.y,[420,600],[0,1],true)
	playerUI.opacity = Utils.modulate(panel.screenFrame.y,[420,600],[0,1],true)
	gradient.opacity = Utils.modulate(panel.screenFrame.y,[420,600],[1,.5],true)
# tap browse to bring panel back
browse.onTap ->
	panel.animate
		y: panel.originalFrame.y	
	
	overlay.ignoreEvents = false
	
cards[1].onTap ->
	videos[2].visible = false
	videos[1].visible = true
	videos[1].player.play()	
	videos[2].player.pause()	
	
cards[0].onTap ->
	videos[2].visible = true
	videos[1].visible = false	
	videos[2].player.play()	
	videos[1].player.pause()
