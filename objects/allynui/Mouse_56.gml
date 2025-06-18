/// @description you can stop dragging now
// You can write your code in this editor
if drag_sprite=true||truth(menu)=7{
	gspxf=gspx
	if drag_sprite=true{
		gspyf=gspy
	}
}
if truth(menu)=8{
	if select_x1 >=0{
	//&&select_y1 >=0{
	//instead of creating a new boolean variable. simply makes x1 negative initially.
		var _y_shift
		if y_shift>22{_y_shift=22}
		else{_y_shift=y_shift}
		select_x2 = device_mouse_x_to_gui(0)-155
		select_y2 = device_mouse_y_to_gui(0)-22+_y_shift
	
	
				var _y_shift
				if y_shift>22{_y_shift=y_shift-22}
				else{_y_shift=0}
				select_y1+=_y_shift
				select_y2+=_y_shift
	    // Create a surface for the selected area
	    var width = abs(select_x2 - select_x1);
	    var height = abs(select_y2 - select_y1);
		if width!=0&&height!=0{
		    var surf = surface_create(width, height);    
						//backwards?
			var _x=select_x1

			var _y=select_y1
			if _x >select_x2{_x=select_x2}
			if _y >select_y2{_y=select_y2}

			surface_set_target(surf);
			draw_clear_alpha(c_black, 0); // Clear the surface
		    draw_sprite_part(current_sprite, 0, _x, _y, width, height, 0, 0);
		    surface_reset_target();
    
		    // Convert to sprite
		    var new_sprite = sprite_create_from_surface(surf, 0, 0, width, height, false, false, 0, 0);
		    surface_free(surf); // Clean up
    
		    // Store or use the new sprite
		    current_sprite = new_sprite;
			sprite_save_strip(current_sprite, "temp/spritesheet.png")
			y_shift=0
		}
	}
}