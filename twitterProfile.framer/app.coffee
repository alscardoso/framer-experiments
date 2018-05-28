cover.image = Utils.randomImage(cover)

# initial setup
tweets = 10
topOffset = -80

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

