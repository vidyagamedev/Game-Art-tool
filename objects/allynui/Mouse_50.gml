/// @description click to drag
// You can write your code in this editor
if drag_sprite=true||truth(menu)=7{
	g_mxc = device_mouse_x_to_gui(0)
	g_myc = device_mouse_y_to_gui(0)
	if drag_sprite=false{
		g_mx=g_mxc - g_mxi
		gspx=gspxf+g_mx
	}
	else{
		g_mx=g_mxi - g_mxc 
		gspx=g_mx
		var _posit = truth(position_array)+1
		giant_array_for_character[_posit][2]=gspxf+gspx
		var _spx_=real(giant_array_for_character[_posit][2])
		g_my=g_myi - g_myc 
		gspy=g_my
		giant_array_for_character[_posit][3]=gspyf+gspy
		var _spy_=real(giant_array_for_character[_posit][3])
		sprite_set_offset(current_sprite, _spx_, _spy_);
	}
}