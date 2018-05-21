
# create a page component with horizontal tabs for main views and vertical pages for item navigation within views

# pages counter
verticalPages = 3
horizontalPages = 3
counter = 0

# navbar
navbar = new Layer
	width: Screen.width
	height: 53
	backgroundColor: "black"
	y: 515

# page component
pageComp = new PageComponent
	width: Screen.width
	height: 540
	directionLock: true
	backgroundColor: null
	originX: 1
	y: -25

# pages
pages = []
for verticalIndex in [0...verticalPages]
	for horizontalIndex in [0...horizontalPages]
		page = new Layer
			width: Screen.width
			height: 400
			x: horizontalIndex * 340
			y: verticalIndex * 420
			parent: pageComp.content
			backgroundColor: "00aaff"
			image: "images/0#{counter}.png"
			name:"page" + "#{horizontalIndex}:#{verticalIndex}"
		pages.push(page)
		counter++

# tabs
tabs=[]
for horizontalIndex in [0...3]
	tab = new Layer
		parent: navbar
		height: navbar.height
		width: navbar.width / horizontalPages
		x: horizontalIndex * (navbar.width / horizontalPages)
		html: "tab#{horizontalIndex}"
		backgroundColor: "null"
		style:
			textAlign: "center"
			lineHeight: 2.5
			fontSize: "18px"
			fontFamily:"-apple-system"
			fontWeight: "500"
	
	tabs.push(tab)

	tab.states.add
		active:
			backgroundColor: "red"		

tabs[0].onTap ->
	pageComp.snapToPage(pages[0])

tabs[1].onTap ->
	pageComp.snapToPage(pages[1])

tabs[2].onTap ->
	pageComp.snapToPage(pages[2])
			
pageComp.on "change:currentPage", (currentPage) -> 
	if pageComp.currentPage.x == 340
		tabs[0].stateSwitch("default")
		tabs[1].stateSwitch("active")
		tabs[2].stateSwitch("default")
	else if pageComp.currentPage.x < 340
		tabs[0].stateSwitch("active")
		tabs[1].stateSwitch("default")
		tabs[2].stateSwitch("default")
	else if pageComp.currentPage.x > 340
		tabs[0].stateSwitch("default")	
		tabs[1].stateSwitch("default")
		tabs[2].stateSwitch("active")

pageComp.snapToNextPage("right", false)