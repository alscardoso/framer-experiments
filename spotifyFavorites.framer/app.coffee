
# Spotify API

hashElements = window.location.hash.split('&')
accessToken = hashElements[0].split('=')[1]

Framer.Screen.backgroundColor = "#fff"
if window.location.href.indexOf('access_token') == -1
	window.location = "https://accounts.spotify.com/authorize?response_type=token&client_id=7189d48d5f5742edad3fb960598093cc&redirect_uri=http://127.0.0.1:8000/3bd13c/spotifyAPI_0616.framer/.viewer.html?reloader=0&scope=user-library-read"
	
else

	# Defaults
	Framer.Defaults.Animation=
		time: .3
		curve: "spring(200,25,0)"
	
	# Setup
	cols = 2
	rows = 5
	boxSize = 172
	gutter = 9
	count = 0
	delay= .2
	boxes = []
	
	# Scroll
	scroll = new ScrollComponent
		parent: dribbble
		width: 352
		height: Screen.height
		x: Align.center
		scrollHorizontal: false	
	scroll.contentInset=
		top: 67
		bottom: 67
		
	# Grid
	for rowIndex in [0...rows]
		for colIndex in [0...cols]
			box = new Layer
				parent: scroll.content
				size: boxSize
				name: "box"+count
				x: colIndex * (boxSize + gutter)
				y: rowIndex * (boxSize + gutter) + 12
				borderRadius: 2
				image: Utils.randomImage(box)
			
			boxes.push(box)	
			count+=1	
	
	
	# NavBar
	navBar.bringToFront()
	navBar.x = Align.center
	navBar.y = 0
	

	# Events
	for box in boxes
		box.onTap (event, layer) ->

			
			## on tap save box original frame and copy this box
			currentBox = this.copy()
			
			## save currentbox position relative to the screen
			currentBox.screenFrame = this.screenFrame
	
			# set tis box to visible false
			this.visible = false
			
			# fade other items
			scroll.content.animate
				opacity: 0
			
		
			## animate box copy to the center			
			currentBox.animate
				size: 375
				y: Screen.midY /3
				x: Screen.width / currentBox.width 
			
	# 		tabbar.visible = false			
			#ignore events 
			box.ignoreEvents = true for box in scroll.content.children	
			
			currentBox.onTap ->
				currentBox.animate
					x: layer.screenFrame.x
					y: layer.screenFrame.y
					size: boxSize
					
					# fade other items
				scroll.content.animate
					opacity: 1
							
				currentBox.onAnimationEnd ->
					currentBox.destroy()
					layer.visible = true
					box.ignoreEvents = false for box in scroll.content.children				
								
						
	r = new XMLHttpRequest
	r.open 'GET', "https://api.spotify.com/v1/me/albums?"
	r.responseType = 'json'
	r.setRequestHeader('Authorization', 'Bearer ' + accessToken)

	r.onreadystatechange = ->
		if(r.status >= 400)
			print "Error #{r.status}"
		
		if(r.readyState == XMLHttpRequest.DONE && r.status == 200)
			albumInformation = r.response
			for layer, index in boxes
				layer.image = albumInformation.items[index].album.images[0].url

	r.send()			

