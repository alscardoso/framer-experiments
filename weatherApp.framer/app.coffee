
# setup
# Framer.Defaults.Animation =
# 	time: .2
cities = ["New York City", "Rio de Janeiro", "Amsterdam", "London", "Barcelona", "San Francisco"]
gutter = 1
itemHeight = 94
space = gutter + itemHeight

# function

# sort cities
getIndexLByLayer = (layer) ->
	index = parseInt((layer.y + (layer.height/2))/(space))

swapLayers = (arr, indexA, indexB) ->
	tmp = arr[indexA]
	arr[indexA] = arr[indexB]
	arr[indexB] = tmp


# toggle cities
toggleExpand = (layer, distance) ->

	layer.states.expanded =
		height: layer.height + distance
		y: 0
	
	layer.states.collapsed =
		height: itemHeight
		y: layer.originalFrame.y	
	
	distance = if layer.expanded is false then distance else -distance
	
	delay = 0
	
	for sib in layer.siblings
		if sib.expanded is true
			delay = .25
			toggleExpand(sib, sib.body.height)
			print "oi"
			
		layer.stateCycle()
				
	Utils.delay delay, ->
		for sib in layer.siblings
			if sib.y > layer.y
				sib.animate
					y: sib.y + distance
			if sib.y < layer.y	
				sib.animate
					y: sib.y - distance	
		layer.expanded = !layer.expanded
	

# layers
cityList = new Layer
	size: Screen.size
	backgroundColor: null

for i in [0..4]
	src = cities[i]
	city = new Layer
		width: 375
		height: itemHeight
		y: i * space
		opacity: 1
		name: src
		parent: cityList
		clip: true
		image: "images/bg.png"
		
	city.draggable.enabled = true
	city.draggable.horizontal = false	
	city.listIndex = i

	cityTime = new TextLayer
		text: "8:41 PM"
		fontSize: 15
		parent: city
		y: 19
		x: 16	
		color: "#fff"	
	
	cityName = new TextLayer
		text: cities[i]
		fontSize: 28
		parent: city
		y: 39
		x: 16
		color: "#fff"

	cityTemp = new TextLayer
		parent: city
		text: "21°"	
		fontSize: 60
		fontWeight: 200
		letterSpacing: 7
		x: 267
		y: 10
		color: "#fff"
	
	city.originalFrame = city.frame
	city.expanded = false	
	
	
	# EXPANDED STATE
	city.body = new Layer
		parent: city
		size:Screen.size
		
	detailScroll = new ScrollComponent
		parent: city.body
		size: Screen.size
		scrollHorizontal: false
	
	detailScroll.content.ignoreEvents = true
	
	header = new Layer
		width: Screen.width
		height: 36
		y: 289
		x: Align.center
		parent: detailScroll.content
		backgroundColor: null
		
	dayHeader = new TextLayer
		parent: header
		fontSize: 17
		text: "Thursday"
		y: 10
		x: 18
		color: "#fff"
	
	todayHeader = new TextLayer
		parent: header
		fontSize: 17
		text: "Today"
		y: 10
		x: 95
		color: "#fff"
	
	todayMax = new TextLayer
		parent: header
		fontSize: 17
		text: "7"
		y: 10
		x: 315
		color: "#fff"
	
	todayMin = new TextLayer
		parent: header
		fontSize: 17
		text: "6"
		y: 10
		x: 345
		color: "#fff"
	
	todayScroll = new ScrollComponent
		parent: detailScroll.content
		width: Screen.width
		height: 95
		y: 324
		scrollVertical: false
			
	todayB = new Layer
		parent: todayScroll.content
		width: 900
		height: 95
		image: "images/today.png"	
		x: -100
	
	week = new Layer
		parent: detailScroll.content
		width: 375
		height: 539
		image: "images/week.png"	
		y: 439

	bottombar = new Layer
		parent: city.body
		width: 375
		height: 45
		image: "images/bottombar.png"
		y: 622
		
# events
	city.onTap ->
		toggleExpand(this, city.body.height)
		
	city.onDragMove ->
		this.bringToFront()
		currentIndex = cities.indexOf(this.name)
		hoveredIndex = getIndexLByLayer(this)
	
		this.animate
				scale: 1.05
				options:
					time: .2
		
		if hoveredIndex < cities.length && hoveredIndex >= 0
			swapLayers(cities, currentIndex, hoveredIndex)
			for city in cityList.children
				if city != this
					city.animate
						y: cities.indexOf(city.name) * space
						options:
							time: .2	
	city.onDragEnd ->
	
		this.animateStop()
		this.animate
			scale: 1
			y: cities.indexOf(this.name) * space
			options:
				time: .2	
