/// @description alphanumeric input
// You can write your code in this editor
if truth(menu)=4||truth(menu)=7{
	if editing=true{
		if keyboard_check_pressed(vk_enter){
			var _i=truth(selected_to_edit)
			if _i = 0 {
				if truth(position_array)=69 {
					giant_array_for_character[0][_i]=keyboard_string
				}
				else {
					var _posit = truth(position_array)+1
					giant_array_for_character[_posit][_i]=keyboard_string
				}
			}
			else if string_digits(keyboard_string)!=""{
				var tempyvar = string_digits(keyboard_string)
				var _keyboard_string=real(tempyvar)
				if truth(position_array)!=69{
					var _posit = truth(position_array)+1
					giant_array_for_character[_posit][_i]=_keyboard_string
					switch _i{
						case 2: case 3:{
							var _xoff=giant_array_for_character[_posit][2]
							var _yoff=giant_array_for_character[_posit][3]
							sprite_set_offset(current_sprite, _xoff, _yoff);
						}break
						case 4:{
							var _sprfps=giant_array_for_character[_posit][4]
							sprite_set_speed(sprite_index, _sprfps, spritespeed_framespersecond);
						}break
					}
				}
				else{giant_array_for_character[0][_i]=_keyboard_string}
			}
			editing=false
		}
		else{keyboard_string=string_replace(keyboard_string,"Please type", "")}
		global.fakeclick=true
		event_perform(ev_mouse,ev_global_left_press)
		global.fakeclick=false
	}
}
if truth(menu)=8{
	if keyboard_check_pressed( vk_up ){y_shift-=20}
	if keyboard_check_pressed(vk_down){y_shift+=20}
}
if truth(menu)=9{
				switch fix_clipping{
					case false:{
						
if keyboard_check(ord("B"))
{
				subframe-=1;var _totalframes=sprite_get_number(current_sprite)
				if subframe=-1{subframe=_totalframes-1}
		global.fakeclick=true
		event_perform(ev_mouse,ev_global_left_press)
		global.fakeclick=false
}
if keyboard_check(ord("N"))
{
				subframe+=1;var _totalframes=sprite_get_number(current_sprite)
				if subframe=_totalframes{subframe=0}
		global.fakeclick=true
		event_perform(ev_mouse,ev_global_left_press)
		global.fakeclick=false
}



			
		if keyboard_check_pressed( vk_up ){
						sprite_array[subframe] = sprite_shift(sprite_array[subframe],,-1);
						current_sprite=merge_sprite_array(sprite_array)
	}
	if keyboard_check_pressed(vk_down){
						sprite_array[subframe] = sprite_shift(sprite_array[subframe],,1);
						current_sprite=merge_sprite_array(sprite_array)
	}
	if keyboard_check_pressed(vk_left){
						sprite_array[subframe] = sprite_shift(sprite_array[subframe],-1);
						current_sprite=merge_sprite_array(sprite_array)
	}

	if keyboard_check_pressed(vk_right){
						sprite_array[subframe] = sprite_shift(sprite_array[subframe],1);
						current_sprite=merge_sprite_array(sprite_array)
	}
					}break
					case true:{
						//clipping[subframe]+=1
					}break
				}

}

if keyboard_check(ord("F"))
{
    if window_get_fullscreen()
    {
        window_set_fullscreen(false);
    }
    else
    {
        window_set_fullscreen(true);
    }
}
