/// @description draw button and text
// You can write your code in this editor

//var _menu_value=truth(menu)


switch truth(menu){
	case 0:{
		draw_sprite_ext(spr_button, -1, 320, 153, 0.4, 0.4, 0, c_white, .8)
		draw_sprite_ext(spr_button, -1, 320, 217, 0.4, 0.4, 0, c_white, .8);
		draw_sprite_ext(spr_button, -1, 277, 269, 0.3, 0.33, 0, c_white, .9)
		draw_sprite_ext(spr_button, -1, 407, 269, 0.17, 0.33, 0, c_white, .9)
	}break
	case 6: {
		var _i = (spage - 1) * 5;
		var _j = 0;
		var _k = 0;
		var _r=15
		var _sprfs=sprite_get_number(current_sprite)-((spage-1)*5)
		if _r>_sprfs{_r=_sprfs}
		repeat(_r){
			draw_sprite(current_sprite, _i, 178.9 + _j * 69, 56.9 + _k * 63);
			_i += 1;
			_j += 1;
			if _j >= 5 { _j = 0; _k += 1; }
		}
		if drag_sprite=true{
			var _posit = truth(position_array)+1
			var sprx=giant_array_for_character[_posit][2]
			var spry=giant_array_for_character[_posit][3]
			var _lestring =string("x:{0} y:{1}", sprx,spry)
			draw_set_halign(fa_center);draw_text_transformed(369,277,_lestring,0.3069,0.3069, 0)
		}
	}
	//WOOWAAAHH
	case 3: case 4:{
		if truth(position_array)>=0 && truth(position_array)!=69 {
			if image_index > sprite_get_number(current_sprite) {image_index =0}
			draw_sprite(current_sprite,image_index,300,277)
		}
	}break
	case 9:{
		var _k=-1
		repeat (3){
			var _frame=subframe+_k
			var _totalframes=sprite_get_number(current_sprite)
			if _frame=-1{_frame=_totalframes-1}
			if _frame=_totalframes{_frame=   0}
			//draw_sprite(current_sprite,_frame,300,56.9 + ((_k+1) * 63))
			//draw_sprite(sprite_array[_frame], 0, 300-sprite_get_xoffset(current_sprite),56.9 + ((_k+1) * 63)-sprite_get_yoffset(current_sprite));
			draw_sprite(sprite_array[_frame], 0, 300,56.9 + ((_k+1) * 63));

			 
			    var _sprite_width = sprite_get_width(current_sprite);
			    var _sprite_height = sprite_get_height(current_sprite);
			    var _xoffset = sprite_get_xoffset(current_sprite);
			    var _yoffset = sprite_get_yoffset(current_sprite);
				var x1=300-_xoffset
				var y1=119.9-_yoffset+ ((_k) * 63)
				var x2=x1+_sprite_width
				var y2=y1+_sprite_height
			if fix_clipping=true{
				if clipping[_frame]>0{draw_rectangle(x1,y1,x2-_sprite_width+clipping[_frame],y2, true);}
				//draw_rectangle(x1,y1,x2,y2, true);
				if clipping[_frame]<0{draw_rectangle(x1+_sprite_width+clipping[_frame],y1,x2,y2, true);}
			}
			else if _k=0	{draw_rectangle(x1,y1,x2,y2, true)}
			
			_k += 1
		}
		if image_index > sprite_get_number(current_sprite) {image_index =0}
		draw_sprite(current_sprite,image_index,300,277)
	}break
	case 10:{
		draw_sprite_ext(spr_button, -1, 320, 233, 0.33, 0.33, 0, c_white, .8)
		draw_sprite_ext(spr_button, -1, 233, 169, 0.25, 0.33, 0, c_white, .9)
		draw_sprite_ext(spr_button, -1, 407, 169, 0.25, 0.33, 0, c_white, .9)
	}break
	case 5:{
			if name_error=false{
		switch preloaded{
			case true:{
				draw_sprite_ext(spr_button, -1, 320, 169, 0.25, 0.33, 0, c_white, .9)
			}break
			case false:{
				draw_sprite_ext(spr_button, -1, 233, 169, 0.25, 0.33, 0, c_white, .9)
				draw_sprite_ext(spr_button, -1, 407, 169, 0.25, 0.33, 0, c_white, .9)
			}break
		}
			}
	}break
	case 7:{
		draw_sprite(current_sprite,image_index,gspx,69)
	}break
	case 8:{
		draw_sprite(current_sprite,image_index,155,22-y_shift)
		if (mouse_check_button(mb_left)) {
			if select_x1 >=0{//instead of creating a new boolean variable. simply makes x1 negative initially. check for mouse clicl release will continue after first mouse click, not after the click from previous menu clicking button into new menu....
				var _y_shift
				if y_shift>22{_y_shift=22}
				else{_y_shift=y_shift}
				draw_rectangle(select_x1+155, select_y1+22-_y_shift, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), true);
			}
		}
	}break
}

auto_array_loop(menu_text_array,auto_text)