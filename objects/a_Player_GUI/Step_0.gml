/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if y>=topp+LandY+1 {
	y=topp +LandY
	sprite_index=sprIdle
	grassS()
	global.chkk1=false
}
else if y<topp+LandY {
	y+=2*LMS
}
if x>rightt{
	x=rightt
}
else if x<leftt{
	x=leftt
}