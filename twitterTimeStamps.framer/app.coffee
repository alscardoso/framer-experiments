

Framer.Screen.backgroundColor = "#fff"

Framer.Defaults.Animation=
	curve: Spring(.9)
	
card = new Layer
	parent: feed
	width: 270
	x: 71
	y: 383
	clip: true
	borderRadius: 10
	backgroundColor: "#fff"
	shadowY: 1
	shadowBlur: 1
	shadowColor: "rgba(0,0,0,.2)"
	height: 180

fromTweetCard = new TextLayer
	text: "From"
	fontSize:11
	fontWeight: 400
	color: "#777"
	parent: card
	y: 159
	x: 10

nameTweetCard = new TextLayer
	text: "André Cardoso"
	fontSize:11
	fontWeight: 600
	color: "#14171A"
	parent: card
	y: 159
	x: 38

handleTweetCard = new TextLayer
	text: "@cardosoandre"
	fontSize:11
	fontWeight: 400
	color: "#777"
	parent: card
	y: 159
	x: 118
	
cardShare = new Layer
	parent: compose
	width: 270
	x: 65
	y: 150
	clip: true
	borderRadius: 10
	backgroundColor: "#fff"
	shadowY: 1
	shadowBlur: 1
	shadowColor: "rgba(0,0,0,.2)"
	height: 180

fromTweetCard = new TextLayer
	text: "From"
	fontSize:11
	fontWeight: 400
	color: "#777"
	parent: cardShare
	y: 159
	x: 10

nameTweetCard = new TextLayer
	text: "André Cardoso"
	fontSize:11
	fontWeight: 600
	color: "#14171A"
	parent: cardShare
	y: 159
	x: 38

handleTweetCard = new TextLayer
	text: "@cardosoandre"
	fontSize:11
	fontWeight: 400
	color: "#777"
	parent: cardShare
	y: 159
	x: 118
	
videoContainer = new Layer
	parent: card
	clip: true
	x: Align.center
	backgroundColor: "#fff"
	width: 270
	height: 152
	borderRadius: 
		topLeft: 10
		topRight: 10
		bottomLeft: 0
		bottomRight: 0

video = new VideoLayer
	parent: videoContainer
	width: 270
	height: 152
	video: "images/talk.mp4"
	x: Align.center
video.originalFrame = video.frame
video.player.play()

liveBadge.parent = videoContainer
liveBadge.x = -25
liveBadge.y = 120
liveBadge.scale = .6
liveBadge.placeBefore(video)

overlay = new Layer
	size: Screen.size
	backgroundColor: "#000"
	opacity: 0
	ignoreEvents: true
overlay.placeBefore(card)

shareOverlay = new Layer
	size: Screen.size
	backgroundColor: "rgba(0,0,0,.8)"
	opacity: 0
	ignoreEvents: true

videoShareContainer = new Layer
	parent: shareOverlay
	width: 144
	height: 81
	x: Align.center
	clip: true
	y: 271
	borderRadius: 
		topLeft: 0
		topRight: 0
		bottomLeft: 0
		bottomRight: 0		
			
videoShare = new VideoLayer
	parent: videoShareContainer
	width: 144
	height: 81
	video: "images/talk.mp4"
	x: Align.center
	y: 0
videoShare.originalFrame = videoShare.frame

xIcon.parent = overlay
xIcon.visible = false
xIcon.x = 320
xIcon.y = 20

toolBar.x = 0
toolBar.y = 680
toolBar.parent = overlay

videoBT.x = 0
videoBT.y = 450
videoBT.parent = shareOverlay
videoBT.scale = .9

cancel = new TextLayer
	text: "cancel"
	x: Align.center
	fontSize: 18
	y: 620
	color: "fff"
	parent: shareOverlay
	
shareSelect.x = 0
shareSelect.y = 80
shareSelect.parent = shareOverlay

timeShare = new Layer
	parent: shareOverlay
	x: Align.center
	y: 300
	width: 270
	backgroundColor: null
	
timeStamp = new TextLayer
	parent: timeShare
	x: Align.center
	y: 60
	fontSize: 14
	text: "0:36"

timeInitial = new TextLayer
	parent: timeShare
	y: 126
	fontSize: 10
	text: "0:00"

timeFinal = new TextLayer
	parent: timeShare
	y: 126
	fontSize: 10
	text: "0:36"
	x: 249

seekBar = new SliderComponent
	parent: timeShare
	y: 106
	x: Align.center
	height: 5
	width: 270
	max: 36
	value: 36
	backgroundColor: "rgba(255,255,255,0.3)"
seekBar.fill.backgroundColor = "#fff"	
seekBar.knobSize = 16
seekBar.knob.draggable.momentum = false

feed.x = 0
feed.y = 0

compose.x = 0
compose.y = 0

keyboard.parent = compose
keyboard.x = 0
keyboard.y = 660


tweetContent = new Layer
	parent: feed
	y: 282
	width: 375
	height: 88
	backgroundColor: null 

avatarTweet = new Layer
	size: 46
	borderRadius: 100
	parent: tweetContent
	y: 15
	x: 15

nameTweet = new TextLayer
	text: "Andre Cardoso"
	fontSize:16
	fontWeight: 600
	color: "#14171A"
	parent: tweetContent
	x: 72
	y: 15

handleTweet = new TextLayer
	text: "@cardosoandre"
	fontSize:14
	parent: tweetContent
	color: "#657786"
	y: 16
	x: 186

contentTweet = new TextLayer
	text: "After 80, some people don’t retire. They reign."
	fontSize: 16		
	parent: tweetContent
	color: "#14171A" 
	width: 266
	height: 47
	x: 71
	y: 34
	
newTweets.parent= feed
newTweets.x = Align.center

header.parent = feed
header.x = 0
header.placeBefore(newTweets)

# STATES
toolBar.states.show =
	y: 600
	
videoContainer.states.expanded=	
	x: 0
	y: 120
	width: 375
	height: 211
	borderRadius: 
		topLeft: 0
		topRight: 0
		bottomLeft: 0
		bottomRight: 0		

videoContainer.states.collapsed=
	x: card.screenFrame.x
	y: card.screenFrame.y
	width: 270
	height: 152
	borderRadius: 
		topLeft: 10
		topRight: 10
		bottomLeft: 0
		bottomRight: 0	

videoShareContainer.states.post =
	width: 270
	height: 152
	x: cardShare.screenFrame.x
	y: cardShare.screenFrame.y		
	borderRadius: 
		topLeft: 10
		topRight: 10
		bottomLeft: 0
		bottomRight: 0	


# EVENTS

videoContainer.onTap ->

	overlay.animate
		opacity: .95
		backgroundBlur: 20
		
	liveBadge.visible = false
	
	xIcon.visible = true
	videoContainer.frame = videoContainer.screenFrame
	videoContainer.parent = null
	
	videoContainer.animate('expanded')
			
	video.animate
		x: 0
		y: 0
		width: 375
		height: 211

	toolBar.animate('show')
		
xIcon.onTap ->
	videoContainer.animate('collapsed')
	video.animate
		width: 270
		height: 152	
	
	overlay.animate
		opacity: 0
			
	toolBar.animate('default')

videoContainer.onAnimationEnd ->
	if videoContainer.y == 383
		liveBadge.visible = true
			
share.onTap ->
	shareOverlay.bringToFront()
	shareOverlay.animate
		opacity: 1	
			
cancel.onTap ->
	shareOverlay.animate
		opacity: 0
		options:
			time: .2

seekBar.onValueChange ->
	newTime = Utils.round(seekBar.value,1)
	currentTime = Utils.round(videoShare.player.currentTime, 1)
	videoShare.player.currentTime = newTime unless newTime is currentTime
	
Events.wrap(videoShare.player).addEventListener "timeupdate", ->
	seekBar.knob.midX = seekBar.pointForValue(this.currentTime)
	timeStamp.text = "0:0"+ Math.round(this.currentTime)
	if Math.round(this.currentTime) > 9 then timeStamp.text = "0:" + Math.round(this.currentTime)	

newTweetBT.onTap ->
	
	feed.visible = false
	feed.sendToBack()
	videoContainer.visible = false
	videoContainer.animate('collapsed')
	videoShareContainer.parent = compose
	
	overlay.animate
		opacity: 0
	
	shareOverlay.animate
		opacity: 0
				
	videoShareContainer.animate('post')
	videoShare.animate
		width: 270
		height: 152	
	
	keyboard.animate
		y: 406	
	
tweet.onTap ->
	videoContainer.visible = true
	feed.visible = true
	compose.animate
		y: 660	
	
	newTweets.animate
		y: newTweets.y + 80
	
	Utils.delay 3, ->	
		newTweets.animate
			y: 0
		