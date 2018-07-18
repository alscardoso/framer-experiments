# SETUP
Framer.Screen.backgroundColor = "#eee"
Framer.Defaults.Animation = time: .2
items = []
active = null
cols = 3
rows = 5
collapsedHeight = 100
expandedHeight = 300
gutter = 6

# FUNCTIONS
toggleItem = (layer) ->
	
	# check if any item is active, if active animate to default
	if active
		active.animate('collapsed')
	
	# if active is clicked item, set active to null
	if active == layer
		active = null
	else
		active = layer
		active.animate('expanded')	

	# update item y
# 	for each function that iterates through each item in the array, same as for layer, index in items
	items.forEach (item, index) ->		
		# set y variable for item's original position 
		y = items[index].originalFrame.y
		
		# if any item is active and index is larger than active index and items index are in the same col
		if active && index > active.index && items[index].col is active.col
			# push it dow
			y = items[index].originalFrame.y + 200
			
		# animate items
		items[index].animate
			y: y
			

# LAYERS
container = new Layer
	x: Align.center
	y:50
	backgroundColor: null
	width: 987
	height: 523

for col in [0...cols]
	for row in [0...rows]
		item = new Layer
			parent: container
			width: 300
			height: collapsedHeight
			backgroundColor: "#fff"
			borderRadius: 6
			shadowY: 1
			shadowBlur: 2
			shadowColor: "rgba(0,0,0,0.2)"
			y: row * (collapsedHeight + gutter)
			x: col * 320
		item.originalFrame = item.frame
		items.push(item)	
		item.col = col
			
# STATES
		item.states.collapsed = 
			height: collapsedHeight
		
		item.states.expanded =
			height: expandedHeight
				
# EVENTS
		item.onTap ->
			toggleItem(this)
			