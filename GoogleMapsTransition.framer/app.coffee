
# DEFINE CONTENT INSET
topOffset = Screen.height - header.height

# CREATE SCROLL COMPONENT
scroll = new ScrollComponent
	size: Screen
	scrollHorizontal: false
	clip: false
scroll.contentInset=
	top: topOffset	
scroll.content.clip = false

# SET OVERLAY PARENT AND POSITION
overlay.x = 0
overlay.parent = scroll.content
overlay.width = scroll.width

# CREATE A FUNCTION TO UPDATE THE LAYOUT, HANDLE MODULATION AND POSITIONS ON SCROLLEND
updateLayout = ->
	# Create a variable to store fractions from modulation of scroll.scrollY, from 0 to topOffset and 0 to 1
	headerFraction = Utils.modulate(scroll.scrollY, [0, topOffset], [0, 1], true)
	
	# Modulate the handle opacity using the headerFraction as an input
	handle.opacity = Utils.modulate(headerFraction, [0.8, 1], [1, 0], true)
	
	# Create a variable to store fractions from modulation of scroll.scrollY, from 0 to topOffset and 0 to 1
	pageFraction = Utils.modulate(scroll.scrollY, [0, topOffset - photo.height], [0, 1], true)

	# Change photo.y by multiplying negative pageFraction by photo.height
	photo.y = -pageFraction * photo.height
	
	# Blend the handle, header and text colors passing pageFraction as argument
	handle.backgroundColor = Color.mix("#CCC", "white", pageFraction)
	header.backgroundColor = Color.mix("white", "#0AF", pageFraction)
	
	# Create a variable to blend text colors
	textColor = Color.mix("black", "white", pageFraction)
	
	# Assign textColor to title, subtitle and stars
	title.color = textColor
	subTitle.color = textColor
	star1.fill = textColor
	star2.fill = textColor
	star3.fill = textColor
	star4.fill = textColor
	
	# Check if scroll.scrollY is greater than topOffset			
	if scroll.scrollY > topOffset
		# if yes set it to the top of the screen
		print header.y = scroll.scrollY - topOffset
	else 
		# otherwise set it to its original position
		header.y = 0
	
	
# On scroll move invoke the updateLayout function	
scroll.onMove(updateLayout)
updateLayout()

# On scrollEnd, pass the event as argument
scroll.onScrollEnd (event) ->
	# if offsetDirection is up 
	if event.offsetDirection is "up"
		# and if scroll.scrollY greater than 0 and less than 337
		if scroll.scrollY > 0 and scroll.scrollY < 337
			# scroll to point y:327
			scroll.scrollToPoint y: 327
		# else if scroll.scrollY < 327, scrollToPoint 0	
	else if scroll.scrollY < 327
			scroll.scrollToPoint y: 0