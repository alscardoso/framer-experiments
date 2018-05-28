

cover.image = Utils.randomImage()


# initial setup
tweets = 10
topOffset = -60

# headerOverlay
headerOverlay = new Layer
	parent: header
	width: header.width
	height: header.width
	backgroundColor: "rgba(0,0,0,.7)"
	opacity: 0	

header.originY = 0

# scroll component
scroll = new ScrollComponent
	size: Screen.size
	scrollHorizontal: false
	parent: profile

	
navBar.bringToFront()	

# add layers to scroll content
twitterLayers = [avatar, info, tab]
for layer in twitterLayers
	layer.parent = scroll.content

avatar.borderRadius = 100
avatar.originY = 1.3
avatar.image = "images/user.jpeg"
avatar.style =
	"border":"6px solid #fff"
	
headerActions.bringToFront()
	
# tweet list
for tweet in [0...tweets]
	tweet = new Layer
		width: Screen.width
		height: 130
		parent: scroll.content
		y: tweet * 130 + 376
		backgroundColor: null
		name: "tweet"+tweet
		style:
			"borderBottom": "1px solid #BBC6CE"
	
	avatarTweet = new Layer
		size: 46
		borderRadius: 100
		parent: tweet
		y: 15
		x: 15
	
	nameTweet = new TextLayer
		text: "Andre Cardoso"
		fontSize:16
		fontWeight: 600
		color: "#14171A"
		parent: tweet
		x: 72
		y: 15
	
	handleTweet = new TextLayer
		text: "@cardosoandre"
		fontSize:14
		parent: tweet
		color: "#657786"
		y: 16
		x: 186
	
	contentTweet = new TextLayer
		text: "After 80, some people don’t retire. They reign."
		fontSize: 16		
		parent: tweet
		color: "#14171A" 
		width: 266
		height: 47
		x: 71
		y: 34
	
	Icon_Comments = new Layer
		width: 15
		height: 15
		image: "images/Icon%3A%20Comments.png"
		parent: tweet
		y: 98
		x: 70
	
	Retweet = new Layer
		width: 20
		height: 14
		image: "images/Retweet.png"
		parent: tweet	
		y: 98
		x: 163
	
	Loves = new Layer
		width: 16
		height: 15
		image: "images/Loves.png"
		parent: tweet	
		x: 259
		y: 98

tab.bringToFront()	

updateTabBar = ->
	if scroll.scrollY > 265
		tab.y = scroll.scrollY - topOffset
	else
		tab.y = 332	

# events
scroll.content.on "change:y", (scrollY) ->
	header.y = Utils.modulate(scrollY,[0,topOffset],[0,topOffset],true)
	avatar.scale = Utils.modulate(scrollY,[0,topOffset],[1,.6],true)
	headerMeta.y = Utils.modulate(scrollY,[-120,-145],[152,80],true) 
	header.scale = Utils.modulate(scrollY,[0,screen.height],[1,12],true)
	cover.blur = Utils.modulate(scrollY,[0,screen.height],[0,20],true)
	headerOverlay.opacity = Utils.modulate(scrollY,[0,screen.height/2],[0,1],true)
	
	updateTabBar()

	if scrollY < topOffset
		header.placeBefore(scroll)
	else
		header.placeBehind(scroll)	
