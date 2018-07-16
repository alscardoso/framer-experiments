
# Setup
Framer.Defaults.Animation=
	curve: "spring(200,25,0)"
	

Framer.Extras.Hints.disable()

photos = []
cols = 4
rows = 5

# Functions
sendPhotoBack = (photoCopy) ->
	photoCopy.animate
		y: photoCopy.originalFrame.y
		x: photoCopy.originalFrame.x
		scale: 1
		
	photoDetail.animate
		opacity: 0

# Photos
photoDetail.x = 0
photoDetail.opacity = 0

scroll = new ScrollComponent
	parent: album
	width: Screen.width
	height: Screen.height
	scrollHorizontal: false

scroll.contentInset = 
	top: albumTopBar.height
	bottom: albumTabBar.height
		
scroll.placeBehind(albumTabBar)	

for col in [0...cols]
	for row in [0...rows]
		photo = new Layer
			parent: scroll.content
			size: 93
			x: col * 94
			y: row * 94
			color: "red"
			image: Utils.randomImage()
		photo.draggable.enabled = false		
# Events	
		photo.onTap (event, layer) ->
			
			if not scroll.isMoving
			
				photoCopy = this.copy()
				photoCopy.frame = this.screenFrame
				photoCopy.originalFrame = photoCopy.frame
				photoCopy.placeBefore(photoDetail)
				photoCopy.draggable.enabled = true
				this.visible = false	
				
				photoCopy.animate
					y: Screen.midY - 100
					x: Align.center
					scale: Screen.width / photoCopy.width
					backgroundColor: "red"
				
				photoDetail.animate
					opacity: 1	
		
		
				photoCopy.onTap ->
					active = this
					if active
						album.animate
							opacity: 0
							
						photoDetail.animate
							opacity: 0
							
						active = null
					
					if !active
						album.animate
							opacity: 1
						
						photoDetail.animate
							opacity: 1			
		
				photoCopy.onDrag ->
					photoDetail.opacity = Utils.modulate(this.screenFrame.y,[95,200],[1,0], true)
					album.opacity = Utils.modulate(this.screenFrame.y,[95,200],[0,1], true)
					photoCopy.scale = Utils.modulate(this.screenFrame.y,[95,800],[Screen.width / photoCopy.width, 1], true)
					
				photoCopy.onDragEnd ->
					sendPhotoBack(photoCopy)
					
					photoCopy.onAnimationEnd ->
						photoCopy.destroy()	
						layer.visible = true
						
			
				backAlbum.onTap ->
					sendPhotoBack(photoCopy)
					photoCopy.onAnimationEnd ->
						photoCopy.destroy()	
						layer.visible = true
				
							