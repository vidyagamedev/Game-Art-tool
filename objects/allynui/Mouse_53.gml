/// @description update menu with every click
// You can write your code in this editor
#region retrieving values
var _menu_value=truth(menu)
var _returned_array			= auto_array_loop(button_click_array,button_click_check,true)
var _returned_sub_array		= auto_array_loop(sub_button_array,button_click_check,true)
var _returned_extra_array	= auto_array_loop(extra_button_array,button_click_check,true)
if global.fakeclick=false{editing=false}
#endregion
switch _menu_value{
	case 0:switch truth(_returned_array){
		case 0: {
			global_characters(global.icharacter_setup,global.scharacter_setup)
			with(spawn){event_user(0)}
			instance_destroy()
		}break
		case 1:{
			en_or_ds=false//enable or disable alteration for character adjustment to menu=1
			use_saved=false
			use_new=false
			preview=false
			ev_menu1()//code to enter menu=1
		}break
		case 2:{
			menu=[];menu[10]=true
		}break
		case 3:{
			en_or_ds=false
			use_saved=false
			use_new=false
			preview=true
			ev_menu1()
		}break
	}break//End Case for case: menu[0]=true
	case 1:{
		switch truth(_returned_array){
			case 0:{
				switch use_saved{
					case false:{
						switch setup{
							case false:{
								menu=[];menu[0]=true;
							}break
							case true:{
								switch preloaded{
									case false:{
										characters=characters_saved
										scharacter_setup=array_concat(global.scharacter_setup,[])
									}break
									case true:{
										characters=characters_internal
										icharacter_setup=array_concat(global.icharacter_setup,[])
									}break
								}
								setup=false
								if en_or_ds=true{menu=[];menu[10]=true
									en_or_ds=false}
								
							}break
						}
					}break
					case true:{
						menu=[];menu[10]=true
					}break
				}
			}break
			case 1:{
				switch preloaded{
					case false:{
						preloaded=true;
						characters=characters_internal
						character_setup=icharacter_setup
					}break
					case true:{
						preloaded=false
						characters=characters_saved
						character_setup=scharacter_setup
					}break
				}
				ini_open("settings.ini");
				ini_write_string("boot settings", "preloaded", preloaded);
				ini_close();
				lastpage = ceil((array_length(characters))/5);
				if lastpage = 0 {lastpage =1}
				if page > lastpage {page = lastpage}
			}break
			case 2:{
				switch setup{
					case false:{
						setup=true
					}break
					case true:{
						setup=false
						global_characters(icharacter_setup,scharacter_setup)
						global.icharacter_setup=icharacter_setup
						global.scharacter_setup=scharacter_setup
					}break
				}
			}break
		}
		if truth(_returned_sub_array)>=0 {
			//if page is more than whatever then what ever lol
			var _selected_character= ((page-1)*5)+truth(_returned_sub_array)
			switch setup{
				case false:{
					character_array=[]
					character_array[_selected_character]=true
					ev_menu2()//code to enter menu=2
					if use_saved=true{
						menu=[];menu[3]=true;position_array=[]
					}
				}break
				case true:{
					if character_setup[_selected_character]!=true{
						character_setup[_selected_character]=true}
					else if character_setup[_selected_character]!=false{
						character_setup[_selected_character]=false}
				}break
			}
		}
		switch truth(_returned_extra_array){
			case 0:if page=1 {page=lastpage} else {page-=1};break
			case 1:if page=lastpage {page=1} else {page+=1};break
		}
	}break
	case 2:{
		switch truth(_returned_array){
			case 0:{
				instance_destroy(a_Player_GUI)
				menu=[];menu[1]=true;
			}break
			case 2:{
				menu=[];menu[3]=true;position_array=[]
			}break
			case 1:{
				enable_edit()
				epixexportt()
			}
		}
	}break
	case 3:{
		switch truth(_returned_array){
			case 0:{
				var _epic_switch=(use_saved||preview)
				switch _epic_switch{
					case false:{
						ev_menu2()//code to enter menu=2
					}break
					case true:{
						ev_menu1()
						instance_destroy(a_Player_GUI)
					}
				}
			}break
			case 1:{
				instance_destroy(a_Player_GUI)
				position_array=[];position_array[69]=true
			}break
		}
		if truth(_returned_sub_array)>=0 {
			instance_destroy(a_Player_GUI)
			var _selected_position= truth(_returned_sub_array)
			position_array=[]
			position_array[_selected_position]=true
			load_sprite(_selected_position)
			sprite_set_speed(sprite_index, sprite_get_speed(current_sprite), spritespeed_framespersecond)
			if use_saved=true{
				enable_edit()
				editing=false
				ev_menu6()				
			}
		}
		if truth(_returned_extra_array)>=0 {

			enable_edit()
			if truth(position_array) == 69 || (truth(_returned_extra_array) < 1 || truth(_returned_extra_array) > 3){
				menu=[];menu[4]=true;
				editing=true
				selected_to_edit=[]
				selected_to_edit[truth(_returned_extra_array)]=true
				keyboard_string="Please type"
				if truth(position_array)!=69{
					var _posit=truth(position_array)+1
					current_sprite=giant_array_for_character[_posit][5]
				}
			}
			else{
				editing=false
				ev_menu6()
			}
		}
	}break
	case 4:{
		switch truth(_returned_array){
			case 0:{
				menu=[];menu[5]=true;
			}break
			case 1:{
				switch use_saved{
					case false:{
						menu=[];menu[3]=true;
						if truth(position_array)!=69{
							var _selected_position=truth(position_array)
							load_sprite(_selected_position)
						}
					}break
					case true:{
						switch use_new{
							case false:{ev_menu1()}break
							case true:{
								use_new=false
								menu=[];menu[10]=true
							}break
						}
					}break
				}
			}break
			case 2:{
				position_array=[];position_array[69]=true;editing=false
			}break
		}
		if truth(_returned_sub_array)>=0 {
			editing=false

			var _selected_position= truth(_returned_sub_array)
			position_array=[]
			position_array[_selected_position]=true
			var _posit = truth(position_array)+1
			var _sprfps=giant_array_for_character[_posit][4]
			current_sprite=giant_array_for_character[_posit][5]
			sprite_set_speed(sprite_index, _sprfps, spritespeed_framespersecond);
			if use_saved=true{
				editing=false
				ev_menu6()				
			}
		}
		if truth(_returned_extra_array)>=0 {
			if truth(position_array) != 69 {
				switch truth(_returned_extra_array){	
					case 1: case 2: case 3:{
						ev_menu6()
					}break
				}
			}
			if truth(position_array) == 69 || (truth(_returned_extra_array) < 1 || truth(_returned_extra_array) > 3){
				editing=true
				selected_to_edit=[]
				selected_to_edit[truth(_returned_extra_array)]=true
				keyboard_string="Please type"
			}
		}
	}break
	case 5:{
		switch truth(_returned_array){
			case 0:{
				menu=[];menu[4]=true;
			}break
			case 1:{
				_naming_new()
				var _directory	= game_save_id+"characters/file/"
				_save_character_to_disk(_directory)
				ev_menu2()//code to enter menu=2
			}break
			case 2:{
				var _directory	= game_save_id+"characters/file/"
				var _actor	= characters[truth(character_array)]
				directory_destroy(_directory+"/"+_actor)
				_save_character_to_disk(_directory)
				ev_menu2()//code to enter menu=2
			} break;
		}
	}break
	case 6:{
		switch truth(_returned_array){
			case 0:{
				menu=[];menu[4]=true;
				drag_sprite=false
				var _posit = truth(position_array)+1
				sprite_delete(giant_array_for_character[_posit][5]);
				giant_array_for_character[_posit][5]=current_sprite
			}break
			case 1:{
				drag_sprite=false
				menu=[];menu[7]=true;
				sprite_save_strip(current_sprite, "temp/spritesheet.png");
				var _posit = truth(position_array)+1
				var sprx=giant_array_for_character[_posit][2]
				var spry=giant_array_for_character[_posit][3]
				sprite_replace(current_sprite, "temp/spritesheet.png", 1, false, false, sprx, spry);
				gspx=300
				gspxf=300
				g_mx = 0
				g_mxi = device_mouse_x_to_gui(0)
			}break
			case 2:{
				menu=[];menu[4]=true
				drag_sprite=false
				sprite_delete(current_sprite);
				var _posit = truth(position_array)+1
							var _i=0;repeat(5){
								giant_array_for_character[_posit][_i]=old[_i]
								_i+=1
							}
				current_sprite= giant_array_for_character[_posit][5]
			}break
			case 3:{
				switch drag_sprite{
					case true: {drag_sprite=false}break
					case false:{
						drag_sprite=true;
						var _posit = truth(position_array)+1
						var _spx_=real(giant_array_for_character[_posit][2])
						gspx=_spx_;
						gspxf=_spx_;
						g_mx = 0;
						g_mxi = device_mouse_x_to_gui(0)
						var _spy_=real(giant_array_for_character[_posit][3])
						gspy=_spy_;
						gspyf=_spy_;
						g_my = 0;
						g_myi = device_mouse_y_to_gui(0)
					}break
				}
			}break
			case 4:{
				drag_sprite=false
				menu=[];menu[9]=true;
				//sprite_save_strip(current_sprite, "temp/spritesheet.png");
				//var _posit = truth(position_array)+1
				//var sprx=giant_array_for_character[_posit][2]
				//var spry=giant_array_for_character[_posit][3]
				//sprite_replace(current_sprite, "temp/spritesheet.png", 1, false, false, sprx, spry);
				sprite_array = split_sprite_into_array(current_sprite);
				//show_debug_message(sprite_array)
				var _totalframes=sprite_get_number(current_sprite)
				if subframe>=_totalframes{subframe=_totalframes-1}
				fix_clipping=false
				clipping=array_create(sprite_get_number(current_sprite), 0);
			}break
		}
		if truth(_returned_sub_array)>=0 {
			//individual image upload or edit or something like that?
		}
		switch truth(_returned_extra_array){
			case 0:if spage=1 {spage=slastpage} else {spage-=1};break
			case 1:if spage=slastpage {spage=1} else {spage+=1};break

		}
		if use_saved=true&&menu[4]=true{
			//preview character before saving?
			//just show other info menu
			position_array=[];position_array[69]=true
		}
		if drag_sprite=true{
			var _posit = truth(position_array)+1
			var _spx_=real(giant_array_for_character[_posit][2])
			var _v=_spx_
			gspx=_v;gspxf=_v;g_mx = 0;
			g_mxi = device_mouse_x_to_gui(0)
			var _spy_=real(giant_array_for_character[_posit][3])
			var _v=_spy_
			gspy=_v;gspyf=_v;g_my = 0;
			g_myi = device_mouse_y_to_gui(0)
			sprite_set_offset(current_sprite, _spx_, _spy_);
		}
	}break
	case 7:{
		switch truth(_returned_array){
			case 0:{
				menu=[];menu[6]=true;
				//var _selected_position=truth(position_array)
				var _posit = truth(position_array)+1
				var sprf=giant_array_for_character[_posit][1]
				var sprx=giant_array_for_character[_posit][2]
				var spry=giant_array_for_character[_posit][3]
				sprite_replace(current_sprite, "temp/spritesheet.png",sprf, false, false, sprx, spry);
				slastpage = ceil(sprite_get_number(current_sprite) / 5);
				if spage > slastpage{spage = slastpage}
				editing=false
			}break
			case 1:{
				editing=false
				menu=[];menu[8]=true;
				sprite_set_offset(current_sprite,0,0)
				select_x1 = -1
				oldsprite=current_sprite
				y_shift=0
			}break
			case 2:{
				var _wownewsprite=get_open_filename("sprite sheet png file|*.png", "");
				var _posit = truth(position_array)+1
				var sprx=giant_array_for_character[_posit][2]
				var spry=giant_array_for_character[_posit][3]
				sprite_replace(current_sprite, _wownewsprite, 1, true, false, sprx, spry);
				sprite_save_strip(current_sprite, "temp/spritesheet.png")
				giant_array_for_character[_posit][0]=filename_change_ext(filename_name(_wownewsprite),"");
			}break
			case 3:{
				giant_array_for_character[6][1]=giant_array_for_character[1][1]
				giant_array_for_character[6][2]=giant_array_for_character[1][2]
				giant_array_for_character[6][3]=giant_array_for_character[1][3]
				giant_array_for_character[6][4]=giant_array_for_character[1][4]
			}break
		}
		g_mxi = device_mouse_x_to_gui(0)
		if truth(_returned_extra_array)>=0 {
			editing=true
			selected_to_edit=[]
			selected_to_edit[truth(_returned_extra_array)]=true
			keyboard_string="Please type"
		}
	}break
	case 8:{
		select_x1 = device_mouse_x_to_gui(0)-155
		var _y_shift
		if y_shift>22{_y_shift=22}
		else{_y_shift=y_shift}
		select_y1 = device_mouse_y_to_gui(0)-22+_y_shift
		if select_x1 <=0{select_x1 =0}
		if select_y1 <=0{select_y1 =0}
		switch truth(_returned_array){
			case 0:{
				menu=[];menu[7]=true;
				gspx=300
				gspxf=300
				g_mx = 0
				g_mxi = device_mouse_x_to_gui(0)
				current_sprite=oldsprite
				var _posit = truth(position_array)+1
				var sprx=giant_array_for_character[_posit][2]
				var spry=giant_array_for_character[_posit][3]
				sprite_set_offset(current_sprite,sprx,spry)
			}break
			case 1:{
				menu=[];menu[7]=true;
				gspx=300
				gspxf=300
				g_mx = 0
				g_mxi = device_mouse_x_to_gui(0)
				var _posit = truth(position_array)+1
				var sprx=giant_array_for_character[_posit][2]
				var spry=giant_array_for_character[_posit][3]
				sprite_set_offset(current_sprite,sprx,spry)
			}break
		}
	}break
	case 9:{
		switch truth(_returned_array){
			case 0:{
				menu=[];menu[6]=true;
				for (var i = 0; i < array_length(sprite_array); i++) {
				    sprite_delete(sprite_array[i]);
				}
				fix_clipping=false
				
						//clipping=0
						
				//sprite_save_strip(current_sprite, "temp/spritesheet.png");
				//var _posit = truth(position_array)+1
				//var sprx=giant_array_for_character[_posit][2]
				//var spry=giant_array_for_character[_posit][3]
				//sprite_replace(current_sprite, "temp/spritesheet.png", 1, false, false, sprx, spry);
			}break
			case 1:{
				subframe+=1;var _totalframes=sprite_get_number(current_sprite)
				if subframe=_totalframes{subframe=0}
			}break
			case 2:{
				subframe-=1;var _totalframes=sprite_get_number(current_sprite)
				if subframe=-1{subframe=_totalframes-1}
			}break
			case 3:{
				switch fix_clipping{
					case false:{
						sprite_array[subframe] = sprite_shift(sprite_array[subframe],1);
						current_sprite=merge_sprite_array(sprite_array)
					}break
					case true:{
						clipping[subframe]+=1
					}break
				}
			}break
			case 4:{
				switch fix_clipping{
					case false:{
						sprite_array[subframe] = sprite_shift(sprite_array[subframe],-1);
						current_sprite=merge_sprite_array(sprite_array)
					}break
					case true:{
						clipping[subframe]-=1
					}break
				}
			}break

			case 5:{
				switch fix_clipping{
					case false:{
						fix_clipping=true
					}break
					case true:{
						fix_clipping=false
						//if clipping[subframe]!=0{
							//current_sprite=fix_clips(current_sprite, clipping) 
							current_sprite=fix_clips_array(current_sprite, clipping) 
							sprite_array = split_sprite_into_array(current_sprite);
							clipping=0
						//}
					}break
				}
			}break
		}
		switch truth(_returned_extra_array){
			case 0:{
				current_sprite=flip_sprite(current_sprite) 
				sprite_array = split_sprite_into_array(current_sprite);
			}break
			case 1:{
						sprite_array[subframe] = sprite_shift(sprite_array[subframe],,1);
						current_sprite=merge_sprite_array(sprite_array)
			}break
			case 2:{
						sprite_array[subframe] = sprite_shift(sprite_array[subframe],,-1);
						current_sprite=merge_sprite_array(sprite_array)
			}break
		}
	}break
	case 10:{
		switch truth(_returned_array){
			case 0:{
				menu=[];menu[0]=true;
			}break
			case 3:{
				en_or_ds=true
				use_saved=false
				ev_menu1()
				setup=true
				preview=false
			}break
			case 2:{
				en_or_ds=false
				use_saved=true
				use_new=false
				preview=false
				ev_menu1()
			}break
			case 1:{
				en_or_ds=false
				use_saved=true
				preview=false
				ev_menu1()
				editing=false
				position_array[69]=true
				menu=[];menu[4]=true
				new_character()
				use_new=true
				preloaded=true
			}
		}
	}break
}//End Switch for menu
#region finalizing menu and button arrays
menu_text_array=[]
button_click_array=[]
sub_button_array=[]
extra_button_array=[]
_menu_value=truth(menu)
#endregion
switch _menu_value{
	case 0:{
		auto_button_text(menu_text_array,320,80,"Welcome",,,,0.7,0.7)
		auto_button_text(menu_text_array,320,153, "Play game?",true,button_click_array,,,,2.2,2.2)
		auto_button_text(menu_text_array,407,269, "Extra",true,button_click_array,,,,1.1,1.1)
		auto_button_text(menu_text_array,320,217, "Change Characters?",true,button_click_array,,,,2.2,2.2)
		auto_button_text(menu_text_array,277,269, "Preview Character?",true,button_click_array,,,,1.1,1.1)
	}break//End Case for case: menu[0]=true
	case 1:{
		switch setup{
			case false:{
				var _heading1 = "Click character and then see animation..."
				var _footerbutton = "Setup game?"
				var _footerbutton_x = 477
				var _alignment =fa_right
			}break
			case true:{
				var _heading1 = "Enable or disable character..."
				var _footerbutton = "Finsihed?"
				var _footerbutton_x = 388
				var _alignment=fa_center
			}break
		}
		#region only: menu_text_array.
			auto_button_text(menu_text_array,181, 55, "Characters",,,fa_left)
			auto_button_text(menu_text_array,166, 87,_heading1,,,fa_left,.3,.3)
		#endregion
		#region       _returned_array, button_click_array
			auto_button_text(menu_text_array,177, 273,"  <--  ",true,button_click_array)
			switch preloaded{												///button_click_array
				case false:{
					auto_button_text(menu_text_array,322,33,"Show",,,fa_left,.3,.3)
					//auto_button_text(sub_menu_array,339,55,"showing",,,,.3,.3)
					auto_button_text(menu_text_array,469,33," preset characters?",true,button_click_array,fa_right,.3,.3,1.5)
					auto_button_text(menu_text_array,470.069,55,"Showing imported characters  ",,,fa_right,.3,.3)
				}break
				case true:{
					auto_button_text(menu_text_array,322,33,"Showing",,,fa_left,.3,.3)
					auto_button_text(menu_text_array,322,55,"Show",,,fa_left,.3,.3)
					auto_button_text(menu_text_array,470.069,33," preset characters  ",,,fa_right,.3,.3)
					auto_button_text(menu_text_array,469,55," imported characters?",true,button_click_array,fa_right,.3,.3,1.369)
				}break
			}
			if use_saved=false&&preview=false{auto_button_text(menu_text_array,_footerbutton_x,277, _footerbutton,true,button_click_array,_alignment)}
		#endregion
		#region   _returned_sub_array, .sub_button_array.
			var _quick_function =function(){
				{
				var _i=5*(page-1)
				var _clist = array_length(characters)
				var _x = 227
				var __i=0
				var _l=10+(page-1)*5
				var _r=10
				if _l>_clist {_r=_r-(_l-_clist)}}
				repeat (_r){
					if __i = 5 {__i = 0; _x=_x+160}
					auto_button_text(menu_text_array,_x, 123+__i*29, characters[_i],true,sub_button_array,,,,1.2)
					if setup=true{
						if character_setup[_i]=false{auto_button_text(menu_text_array,_x+81, 123+__i*29, "-./")}
						else if character_setup[_i]=true{auto_button_text(menu_text_array,_x+79, 123+__i*29, "X")}
					}
					_i+=1
					__i+=1
				}
			}
			_quick_function()
		#endregion
		#region _returned_extra_array, extra_button_array
			if lastpage>1{
				auto_button_text(menu_text_array,417,87, "<-",true,extra_button_array)
				auto_button_text(menu_text_array,471,87, "->",true,extra_button_array)
				auto_button_text(menu_text_array,444,87, page,true,extra_button_array)
			}
		#endregion
	}break//End Case for case: menu[1]=true
	case 2:{
		#region menu text
			auto_button_text(menu_text_array,181, 55, "Character: "+characters[truth(character_array)],,,fa_left)
			auto_button_text(menu_text_array,166, 87,"Character is playable!",,,fa_left,.369,.369)
			auto_button_text(menu_text_array,166, 113,"Move around and attack",,,fa_left,.369,.369)
			auto_button_text(menu_text_array,469, 123,"Hit space to attack",,,fa_right,.3,.3)
			auto_button_text(menu_text_array,469, 147,"Arrow keys or joystick to move",,,fa_right,.3,.3)
			auto_button_text(menu_text_array,469, 169,"Use joystick and press the right half of the screen for mobile",,,fa_right,.2769,.2769)
		#endregion
		#region       _returned_array, button_click_array
			auto_button_text(menu_text_array,177, 273,"  <--  ",true,button_click_array)
			auto_button_text(menu_text_array,477, 244, "Export?",true,button_click_array,fa_right)
			if preview=false{auto_button_text(menu_text_array,477, 277,"Customize?",true,button_click_array,fa_right)}
		#endregion
	}break
	case 3:{
		#region only: menu_text_array.
			if truth(position_array)!=69{
				auto_button_text(menu_text_array,181, 55, "Character: "+characters[truth(character_array)],,,fa_left)
				if truth(position_array)=-1{auto_button_text(menu_text_array,166, 87,"Click animation for preview!",,,fa_left,.3,.3)}
				else {auto_button_text(menu_text_array,166, 87,"Click to change value",,,fa_left,.3,.3)}
			}
			else {}
		#endregion
		#region       _returned_array, button_click_array
			auto_button_text(menu_text_array,177, 273,"  <--  ",true,button_click_array)
			auto_button_text(menu_text_array,420, 273, "other data",true,button_click_array)
		#endregion
		#region   _returned_sub_array, .sub_button_array
		var _quick_function =function(){
			var _i=0
			var position_names=["Attacking","Falling","Standing","Jumping","Moving","Attack hitbox"]
			repeat (array_length(position_names)){
				auto_button_text(menu_text_array,420, 77+(_i)*30, position_names[_i],true,sub_button_array)
				_i+=1
			}
		}
		_quick_function()
		#endregion
		#region _returned_extra_array, extra_button_array
			if truth(position_array)>=0{
				if truth(position_array)!=69{
					var _quick_function =function(){
						var _i=0
						var sprite_info = ["File name","Number of frames","Centre point, x","Centre point, y","Frames per second"]
						repeat (array_length(sprite_info)){
							var _stringz
							_stringz=string(sprite_data[_i])
							auto_button_text(menu_text_array,242, 123+_i*29, string(sprite_info[_i]) +": " +  _stringz ,true,extra_button_array)
							_i+=1
						}
					}
					_quick_function()
				}
				else{
					var _quick_function =function(){
						switch preloaded{
							case false:{var _directory = game_save_id+"characters/file/"}break
							case true:{ var _directory = working_directory+"duude/file/"}break
						}
						var _actor		= characters[truth(character_array)]
						var _i=0
						var general_parameters=["Character name","jumpframe","jumpspeed","walkstep2","jumpframe0","LandY","fllspd","myd"]
						var parameter_data=parameter_import(_actor,_directory)
						repeat (array_length(general_parameters)){
							var _stringz
							_stringz=string(parameter_data[_i])
							auto_button_text(menu_text_array,292,42+_i*29, string(general_parameters[_i]) +": " +  _stringz ,true,extra_button_array)
							_i+=1
						}
					}
					_quick_function()
				}
			}
		#endregion
	}break
	case 4:{
		#region only: menu_text_array.
			if truth(position_array)!=69{
				auto_button_text(menu_text_array,181, 55, "Character: "+giant_array_for_character[0][0],,,fa_left)
				switch editing{
					case false:{auto_button_text(menu_text_array,166, 87,"editing mode... click to change value",,,fa_left,.3,.3)}break
					case true:{ auto_button_text(menu_text_array,166, 87,"editing mode... type and press enter",,,fa_left,.3,.3)}break
				}
			}
		#endregion
		#region       _returned_array, button_click_array
			auto_button_text(menu_text_array,177, 273,"  -->  ",true,button_click_array)
			auto_button_text(menu_text_array,163, 33, "X",true,button_click_array)
			auto_button_text(menu_text_array,420, 273, "other data",true,button_click_array)
		#endregion
		#region   _returned_sub_array, .sub_button_array
		var _quick_function =function(){
			var _i=0
			var position_names=["Attacking","Falling","Standing","Jumping","Moving","Attack hitbox"]
			repeat (array_length(position_names)){
				auto_button_text(menu_text_array,420, 77+(_i)*30, position_names[_i],true,sub_button_array)
				_i+=1
			}
		}
		_quick_function()
		#endregion
		#region _returned_extra_array, extra_button_array
			if truth(position_array)!=69{
				var _quick_function =function(){
					var _i=0
					var sprite_info = ["File name","Number of frames","Centre point, x","Centre point, y","Frames per second"]
					var _posit = truth(position_array)+1
					repeat (array_length(sprite_info)){
						var _stringz
						if editing = true && _i=truth(selected_to_edit){_stringz=keyboard_string}
						else {_stringz=string(giant_array_for_character[_posit][_i])}
						auto_button_text(menu_text_array,242, 123+_i*29, string(sprite_info[_i]) +": " +  _stringz ,true,extra_button_array)
						_i+=1
					}
				}
				_quick_function()
			}
			else{
				var _quick_function =function(){
					var _i=0
					var general_parameters=["Character name","jumpframe","jumpspeed","walkstep2","jumpframe0","LandY","fllspd","myd"]
					switch use_new{
						case false:{
							var r_length=array_length(general_parameters)
						}break
						case true:{
							var r_length=1
							auto_button_text(menu_text_array,166,  87, "Add new animations:",,,fa_left)
							auto_button_text(menu_text_array,166, 117, "1. Click on animation",,,fa_left)
							auto_button_text(menu_text_array,166, 147, "2. Import sprite sheet!",,,fa_left)
							auto_button_text(menu_text_array,166, 177, "3. Edit parameters!",,,fa_left)
							auto_button_text(menu_text_array,166, 207, "ie. Change character name?",,,fa_left)
						}break
					}
					repeat (r_length){
						var _stringz
						if editing = true && _i=truth(selected_to_edit){_stringz=keyboard_string}
						else {_stringz=string(giant_array_for_character[0][_i])}
						auto_button_text(menu_text_array,292,42+_i*29, string(general_parameters[_i]) +": " +  _stringz ,true,extra_button_array)
						_i+=1
					}
				}
				_quick_function()
			}
		#endregion
	}break
	case 5:{
		name_error=name_check()
		auto_button_text(menu_text_array,320,80,"Save changes?",,,,0.7,0.7)
		#region       _returned_array, button_click_array
			auto_button_text(menu_text_array,177, 273,"  <--  ",true,button_click_array)
			if name_error=true{
				//auto_button_text(menu_text_array,404, 239, "error: duplicate file name!",,,,0.3,0.3)
				auto_button_text(menu_text_array,320, 123, "Error: Duplicate file name found!",,,,0.55,0.569)
				auto_button_text(menu_text_array,320, 169, "Please make sure all file names are unique!",,,,0.42,0.45)
				auto_button_text(menu_text_array,320, 210, string("Check the file names for {0}",giant_array_for_character[0][0]),,,,0.469,0.469)
				auto_button_text(menu_text_array,320, 248, "Cannot keep changes with duplicate file names",,,,0.4,0.4)
				auto_button_text(menu_text_array,339, 273, "Come back after fixing it!",,,,0.369,0.369)
				//error! duplicate file name found!
//please make sure all file names for [cahracter name] is unique!
//cannot keep changes with duplicate file names
				}
			else {
			switch preloaded{
				case true:{
					auto_button_text(menu_text_array,320, 169, "Save Character?",true,button_click_array,,0.3,0.3,,2.2)
				}break
				case false:{
					auto_button_text(menu_text_array,407, 169, "Save New character?",true,button_click_array,,0.3,0.3,,2.2)
					auto_button_text(menu_text_array,233, 169, "Modify Character?",true,button_click_array,,0.3,0.3,,2.2)
				}break
			}
			}
		#endregion
	}break
	case 6:{
		auto_button_text(menu_text_array,300,277, "> <")
		auto_button_text(menu_text_array,440,273, spage ,,,,0.3,0.3)
		auto_button_text(menu_text_array,444,277, "/" ,,,,0.369,0.369)
		auto_button_text(menu_text_array,448,281, slastpage,,,,0.3,0.3 )
		auto_button_text(menu_text_array,177, 273,"  <--  ",true,button_click_array)
		auto_button_text(menu_text_array,377,233, "Open sprite sheet?",true,button_click_array)
		auto_button_text(menu_text_array,163, 33, "X",true,button_click_array)
		switch drag_sprite{
			case false:{auto_button_text(menu_text_array,222,233, "Click to drag?",true,button_click_array)
				if slastpage>1{
					auto_button_text(menu_text_array,417,277, "<-",true,extra_button_array)
					auto_button_text(menu_text_array,471,277, "->",true,extra_button_array)
					var _lestringz=((spage+2)*5); var _totalframes=sprite_get_number(current_sprite)
					if _lestringz>_totalframes{_lestringz=_totalframes}
					var _lestring =string("{0}-{1}/{3}", ((spage-1)*5)+1,_lestringz,,_totalframes)
					auto_button_text(menu_text_array,369,277, _lestring,,,,0.3069,0.3069 )
				}
			}break
			case true:{auto_button_text(menu_text_array,222,233, "Finished dragging??",true,button_click_array)}break
		}
		auto_button_text(menu_text_array,231, 277, "Fix?",true,button_click_array)
	}break
	case 7:{
		name_error=name_check()
		auto_button_text(menu_text_array,177, 273,"  <--  ",true,button_click_array)
		auto_button_text(menu_text_array,406,123, "Crop",true,button_click_array)		
		//auto_button_text(menu_text_array,344,123, "crop from sheet",true,button_click_array)		
		auto_button_text(menu_text_array,344,277, "Import sprite sheet? (.png file)",true,button_click_array)		
		var _quick_function =function(){
			var _i=0
			var sprite_info = ["File name","Number of frames","Centre point, x","Centre point, y","Frames per second"]
			var _posit = truth(position_array)+1
			repeat (array_length(sprite_info)){
				var _stringz
				if editing = true && _i=truth(selected_to_edit){_stringz=keyboard_string}
				else {_stringz=string(giant_array_for_character[_posit][_i])}
				auto_button_text(menu_text_array,242, 123+_i*29, string(sprite_info[_i]) +": " +  _stringz ,true,extra_button_array)
				_i+=1
			}
		}
		_quick_function()
 		if editing=false{auto_button_text(menu_text_array,388, 152, "<-- Check the frames!",,,,0.3,0.3)}
		if name_error=true{auto_button_text(menu_text_array,404, 239, "Error: Duplicate file name!",,,,0.3,0.3)}
		auto_button_text(menu_text_array,406, 182, "Drag sprite sheet",,,,0.3,0.3)
		auto_button_text(menu_text_array,406, 202, "to see all frames",,,,0.3,0.3)
		if truth(position_array)=5{auto_button_text(menu_text_array,406, 242,"Sync with attack?",true,button_click_array)}
	}break
	case 8:{
		auto_button_text(menu_text_array,163, 33, "X",true,button_click_array)
		auto_button_text(menu_text_array,177, 273,"  <--  ",true,button_click_array)
	}break
	case 9:{
		auto_button_text(menu_text_array,177, 273,"  <--  ",true,button_click_array)
		auto_button_text(menu_text_array,471,277, "->",true,button_click_array)
		auto_button_text(menu_text_array,417,277, "<-",true,button_click_array)
		auto_button_text(menu_text_array,391,119.9,">",true,button_click_array,)
		auto_button_text(menu_text_array,209,119.9,"<",true,button_click_array,)
		if clipping=0 {auto_button_text(menu_text_array,406.39,233, "Clipping completed...")}
		else {
			switch fix_clipping{
				case false:{
					auto_button_text(menu_text_array,406.39,233, "Fix clipped sprite?",true,button_click_array)
		auto_button_text(menu_text_array,196,233,"Flip sprite?",true,extra_button_array)
		auto_button_text(menu_text_array,300,230,"\\/",true,extra_button_array,)
		auto_button_text(menu_text_array,300,20,"/\\",true,extra_button_array,)
					auto_button_text(menu_text_array,69,333, "Click arrows or use arrow keys",,,fa_left)
				}break
				case true:{
					auto_button_text(menu_text_array,406.39,233, "Fix it!",true,button_click_array)
					//auto_button_text(menu_text_array,69,333, "Click arrows or use arrow keys",,,fa_left)
				}break
			}
		}
		//auto_button_text(menu_text_array,596,333, "Click <- and -> or press B and N keys",,,fa_right)
		//auto_button_text(menu_text_array,163, 33, "X",true,button_click_array)
		var _totalframes=sprite_get_number(current_sprite)
		var _lestring =string("{0}/{3}", subframe+1,,,_totalframes)
		auto_button_text(menu_text_array,369,277, _lestring,,,,0.3069,0.3069 )
	}break
	case 10:{
		auto_button_text(menu_text_array,320,80,"Changing Characters",,,,0.7,0.7)
		auto_button_text(menu_text_array,177, 273,"  <--  ",true,button_click_array)
		auto_button_text(menu_text_array,233, 169, "Make New Character?",true,button_click_array,,0.3,0.3,,2.2)
		auto_button_text(menu_text_array,407, 169, "Modify Character?",true,button_click_array,,0.3,0.3,,2.2)
		auto_button_text(menu_text_array,320, 233, "Enable or Disable Character?",true,button_click_array,,0.3,0.3,,2.2)
	}
}//End Switch for menu
#region debug messages
show_debug_message("1. button array ={1} : {0}",_returned_array, truth(_returned_array))
show_debug_message("2. button array ={1} : {0}",_returned_sub_array, truth(_returned_sub_array))
show_debug_message("3. button array ={1} : {0}",_returned_extra_array, truth(_returned_extra_array))
show_debug_message("currently in menu {1} : {0}",menu, truth(menu))
//show_debug_message("setup variable is {0}",setup)
var _mx = device_mouse_x_to_gui(0)
var _my = device_mouse_y_to_gui(0)
show_debug_message("x is {0} and y is {1}", _mx, _my)

//math_set_epsilon(0.01);
//math_set_epsilon(0.9999);

//var epi = math_get_epsilon();
//show_debug_message("math_get_epsilon is {0}", epi)

		//show_debug_message("name_error is {0} and _name_check is {1}", name_error, _name_check)
#endregion