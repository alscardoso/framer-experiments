Utils.insertCSS(
	"""
		@font-face {
			font-family: 'Circular Std';
			font-weight: normal;
			src: url('fonts/CircularStd-Book.woff') format("woff");
			src: url('fonts/CircularStd-Medium.woff') format("woff");
			src: url('fonts/CircularStd-Bold.woff') format("woff");
		}
	""")

# setup
player.draggable.enabled = true
player.draggable.horizontal = false
top_1.opacity = 0

# animations
playerOpen = new Animation player,
	y: 0
	options:
		time: .5

playerClose = new Animation player,
	y: 573	
	options:
		time: .5
		

# events
player.on "change:y", (scrollY) ->
	playingBar.opacity = Utils.modulate(scrollY,[572,525],[1,0],true)
	top_1.opacity = Utils.modulate(scrollY,[525,400],[0,1],true)
	bottomBar.y = Utils.modulate(scrollY,[572,0],[617,617 + bottomBar.height],true)
	
	if player.y >= 573
		player.y = 573
	if player.y <= 0
		player.y = 0	
	
player.onDragEnd ->
	if event.offsetDirection is "up" 
		if player.draggable.offset.y < -60
			playerOpen.start()
		else
			playerClose.start()
	else
		if player.draggable.offset.y > 80
			playerClose.start()
		else
			playerOpen.start()			

