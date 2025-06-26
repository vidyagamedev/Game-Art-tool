// 
#region script 1
function grassS(){
	audio_stop_sound(Grass_Running)
	//audio_play_sound_at(Grass_Running,xx,yy,0,1,0,1,false,10)
	audio_play_sound_at(Grass_Running, 640-x, y, 0, 100, 300, 1, false, 1);
	//audio_play_sound(Grass_Running,false,10)
}

function nbCr(){
	sprIdle=NBIdle;
	sprWalk=NBRun;
	spJump=false
	spJump2=false;
	spAttack=NBAttack;
	jumpframe=2;
	jumpspeed=3;
	walkstep2=3;
	jumpframe0=4;
	LandY=-21.75;
	HspAttack=NBAttackH
	fllspd=0
	myd=1
}

function ewCr(){
	sprIdle=EWIdle
	sprWalk=EWRun;
	spJump=EWJump;
	spJump2=EWFall;
	spAttack=EWAttack;
	jumpframe=0;
	jumpspeed=2.5;
	walkstep2=5;
	jumpframe0=2;
	LandY=-19.75;
	HspAttack=EWAttackH
	fllspd=-0
	myd=2
}


function layer_shader_start()
{
    if event_type == ev_draw
    {
        if event_number == 0
        {
			gpu_set_texfilter(false);
		}
    }
}
function layer_shader_shift()
{
    if event_type == ev_draw
    {
        if event_number == 0
        {
			if (
				(
				keyboard_check(vk_lshift)
				)
				&&
				(
				keyboard_check(ord("2"))
				)	
			)||global.BGMVMT==false
			{gpu_set_texfilter(false)};
}
    }
}

function layer_shader_end()
{
    if event_type == ev_draw
    {
        if event_number == 0
        {
			gpu_set_texfilter(true);
        }
    }
}



function pCr(){
	sprIdle=PIdle
	sprWalk=PMove;
	spJump=false;
	spJump2=false;
	spAttack=PIdle74;
	jumpframe=1;
	jumpspeed=2
	walkstep2=12;
	jumpframe0=4;
	LandY=-19.75;
	HspAttack=PIdleH
	fllspd=-0
	myd=4.5
}

function BACr(){
	sprIdle=BAIdle
	sprWalk=BAIdle;
	spJump=false;
	spJump2=false;
	spAttack=BAIdle77;
	jumpframe=1;
	jumpspeed=2
	walkstep2=12;
	jumpframe0=4;
	LandY=-19.75;
	HspAttack=BAIdleH
	fllspd=-0
	myd=4.5
}


function sprite_creator(colour,index){
	EPIC_LUL(colour)
	sprite_save_strip(current_sprite, "temp/spritesheet.png")
	current_sprite=sprite_add( "temp/spritesheet.png",4, false, false, 1, 1);
	giant_array_for_character[index][5]=current_sprite
}

function new_character(){
	giant_array_for_character=[ 
	//[ "Question Mark",1,3,3,2,-19.75,-0.37,5.50 ],
	[ "New Character",1,3,3,2,-19.75,-0.37,5.50 ],
	[ "RED",4,33,42,9 ],
	[ "PURPLE",4,33,42,9 ],
	[ "GREEN",4,33,42,9 ],
	[ "orange",4,33,42,9 ],
	[ "Navy Blue",4,33,42,9 ],
	[ "YELLOW",4,33,42,12 ] ]
	var color_array=[c_red,c_purple,c_green,c_orange,c_navy,c_yellow]
	_i=0
	repeat(6){
		_i+=1
		sprite_creator(color_array[_i-1],_i)
	}
}
#endregion


///////script 2
// 
// 
function EPIC_LUL(c_WHAT){
//ai made this for me LMFAO. i customize for colourz.

// Sprite dimensions and subframes
var frame_width = 64;
var frame_height = 64;
var num_frames = 4;
var total_width = frame_width * num_frames;

// Create a surface for all frames
var surf = surface_create(total_width, frame_height);
surface_set_target(surf);
draw_clear_alpha(c_black, 0); // Transparent background

// Loop through each frame
for (var i = 0; i < num_frames; i++) {
    // Calculate the x-offset for this frame
    var x_offset = i * frame_width;
    
    // Base question mark (white, static)
    draw_set_colour(c_white);
    
    // Draw the top half-circle
    var center_x = x_offset + 32;
    var center_y = 24;
    var radius = 12;
    draw_ellipse(center_x - radius, center_y - radius, center_x + radius, center_y + radius, false); // Full ellipse
    // Mask the bottom half with a rectangle
    draw_rectangle(center_x - radius, center_y, center_x + radius, center_y + radius, false); // Covers bottom
    
    // Connect the curve to the body
    draw_line_width(center_x + radius, center_y, center_x + radius, 36, 4); // Right side down
    draw_line_width(center_x + radius, 36, center_x + 4, 48, 4); // Diagonal left
    draw_line_width(center_x + 4, 48, center_x - 4, 56, 4); // Curve left
    
    // Draw the dot
    draw_circle(center_x, 60, 4, false);
    
    // Animation: Pulsing glow (yellow outline)
    draw_set_colour(c_WHAT);
    var glow_scale = 1 + 0.5 * abs(sin(i * pi / num_frames)); // Pulse effect
    var glow_alpha = 0.5 * (1 - (i / num_frames)); // Fade out
    draw_set_alpha(glow_alpha);
    
    // Glow outline
    draw_ellipse(center_x - radius * glow_scale, center_y - radius * glow_scale, 
                 center_x + radius * glow_scale, center_y + radius * glow_scale, false);
    draw_rectangle(center_x - radius * glow_scale, center_y, 
                   center_x + radius * glow_scale, center_y + radius * glow_scale, false);
    draw_line_width(center_x + radius, center_y, center_x + radius, 36, 4 * glow_scale);
    draw_line_width(center_x + radius, 36, center_x + 4, 48, 4 * glow_scale);
    draw_line_width(center_x + 4, 48, center_x - 4, 56, 4 * glow_scale);
    draw_circle(center_x, 60, 4 * glow_scale, false);
}

// Reset drawing state
draw_set_alpha(1);
surface_reset_target();

// Create the sprite with subimages
var new_sprite = sprite_create_from_surface(surf, 0, 0, total_width, frame_height, false, false, frame_width / 2, frame_height / 2);
sprite_set_speed(new_sprite, 15, spritespeed_framespersecond); // 15 FPS

// Clean up
surface_free(surf);
draw_set_colour(c_white);

// Use the sprite
current_sprite = new_sprite;
}


///script 3
function Script3(){
#region functions!!
//~~~ proffesionals have standards ~~~// uwu

//these are (my) essential functions for (efficient (easiest) coding of) menus and buttons
#region auto_button_text:	epic button creator
/// @description	input into: menu_text_array, button_click_array
/// @function		auto_button_text(_text_array,_x,_y,_text,_clicky,_button_array,_halign,_xscale,_yscale,_angle,_device)
/// @arg			_text_array
/// @arg {real}	_x
/// @arg {real}	_y
auto_button_text=function(_text_array,_x,_y,_text,_clicky=false,_button_array=[],_halign=fa_center,_xscale=.4,_yscale=.4,_button_xscale=1,_button_yscale=1,_angle=0,_device=0){
	if _clicky=true{
		var _dx = .5*_xscale*(string_width(_text))*_button_xscale
		var _dy = .44*_yscale*(string_height(_text))*_button_yscale
		if _halign=fa_center{array_push(_button_array,[_device,_x,_y,_dx,_dy])}
		if _halign=fa_left{	array_push(_button_array,[_device,_x+_dx,_y,_dx,_dy])}
		if _halign=fa_right{array_push(_button_array,[_device,_x-_dx,_y,_dx,_dy])}
	}
	array_push(_text_array,[_halign,_x,_y,_text,_xscale,_yscale, _angle])
}
#endregion
#region	button_click_check:	button click checker
/// @description	takes values from an array like _button_array, button_click_array, 
///
/// checks if user device (mouse) is clicking/pressing on button
/// 
/// returns rectangle_in_rectangle(runtime function)
///
/// ..
/// @function		button_click_check(_array)
button_click_check=function(_array){
	var _device=_array[0]
if global.fakeclick=false{
	var _mx = device_mouse_x_to_gui(_device)
	var _my = device_mouse_y_to_gui(_device)
}else if global.fakeclick=true{var _mx =-1; var _my= -1}
	var _x=		_array[1]
	var _y=		_array[2]
	var _dx=	_array[3]
	var _dy=	_array[4]
	//show_debug_message("_x, autocalculated, mousecheck, ratio: {0}, {1}, {2}, {3}",_x,_x-(_x-_dx),(_x-_mx),(_x-_mx)/(_x-(_x-_dx)))
	//show_debug_message("_y, autocalculated, mousecheck, ratio: {0}, {1}, {2}, {3}",_y,_y-(_y-_dy),(_y-_my),(_y-_my)/(_y-(_y-_dy)))
	return rectangle_in_rectangle(_x-_dx,_y-_dy,_x+_dx,_y+_dy,_mx-1,_my-1,_mx+1,_my+1)
}
#endregion
#region	auto_array_loop:	universal 2d array function applier
/// @description	running another function through each array in a bigger array (auto_text,button_click_check)
///
/// optionally returning an array with possibly returned values from the other function. use returned array with runtime function array_get_index or my truth function
///
/// ..
/// @function		auto_array_loop(_bigarray,_arrayfunction,_return)
/// @arg			_bigarray
auto_array_loop=function(_bigarray,_array_function,_return=false,_bool=true){
	var _i=0;
	var _returned_array=[];var _returned_object//if _return=true{}
	repeat (array_length(_bigarray)){
		if _return=true{
			_returned_object=_array_function(_bigarray[_i])
			if _bool=true{_returned_object=bool(_returned_object)}
			array_push(_returned_array,_returned_object)
		}
		else{_array_function(_bigarray[_i])}
		_i+=1}
	if _return=true{return _returned_array;}
}

var _btw_same_thing=function(){
	var _i=0;
	var _returned_array=[];var _returned_object//if _return=true{}
	repeat (array_length(_bigarray)){
		_returned_object=_array_function(_bigarray[_i])
		if _bool=true{_returned_object=bool(_returned_object)}
		array_push(_returned_array,_returned_object)
		_i+=1}
	return _returned_array;
}//so btw same thing? returning things is always optional...
//	????	////	running another function through each element in an array (auto_text,button_click_check)		//_any_d_array
#endregion
#region	auto_text:			auto text maker
/// @description	takes values from an array like _text_array, menu_text_array
///
/// all it does is it draws text... like for the menu
///
/// ..
/// @function		auto_text(_array)
auto_text=function(_array){
	var _halign=_array[0]
	var _x=_array[1]
	var _y=_array[2]
	var _text=_array[3]
	var _xscale=_array[4]
	var _yscale=_array[5]
	var _angle=_array[6]
	draw_set_halign(_halign);draw_text_transformed(_x,_y,_text,_xscale,_yscale, _angle)
}
#endregion

//easiest way to check what should be happenig (is) by using arrays with boolean values
#region truth
/// @description	returns array_get_index(_array ,true)
///
/// ..
/// @function		truth(_array)
truth=function(_array){return array_get_index(_array ,true)}						#endregion

/// @description import characters from local folders with png and ini files
///
///.:
/// @function full_import()
full_import=function(_directory){
	//var _directory	= working_directory+"duude/file/"
	 //var _INCLUDEDFILES="duude/file/" 		//	"actors/"
	spradding=function(_actor,_postn,_directory,_i,__i){///////function to do all the image file importing... 	return spr
		var _spi = ["file name","number of frames","centre point, x","centre point, y","frames per second"]
		var sprstr=ini_read_string(_postn, _spi[0], "");				

		var sprf=ini_read_real(_postn, _spi[1], 1 );
		var sprx=ini_read_real(_postn, _spi[2], 0);
		var spry=ini_read_real(_postn, _spi[3], 0);
		var sprfps=ini_read_real(_postn, _spi[4], 5 );

		var spr = sprite_add(_directory +_actor +"/"+ sprstr +".png" ,sprf, false, false, 0, 0);///NOW THAT WE HAVE PNG FILE. WE ADD SPRITE. NEW SPRITE NEEDS CONFIGURATIONS!!
		sprite_collision_mask(spr, true, 1, 0, 0, 0, 0, 0, 0);
		sprite_set_offset(spr, sprx, spry);
		sprite_set_speed(spr, sprfps, spritespeed_framespersecond)
		filez[_i][__i+1][1]=sprstr
		return spr
	}
	epicimport=function(_directory){
		var _animationtype=["attacking","falling","standing","jumping","moving","attack hitbox"]
		var _parametertype=["jumpframe","jumpspeed","walkstep2","jumpframe0","LandY","fllspd","myd"]
		var __header="other parameters"
		 var _i = 0;
		repeat (array_length(filez)){
			var _actorzz = filez[_i][0][0]
			ini_open(_directory + _actorzz +"/"+_actorzz +".ini");
			 var __i = 0;
			repeat (array_length(_animationtype)){
				var _epicspr=spradding(_actorzz ,_animationtype[__i],_directory,_i,__i)
				filez[_i][__i+1][0]=_epicspr
				filez[_i][__i+1][2]=array_create(5,false);
			    __i += 1;}
			var _p = 0;
			repeat (array_length(_parametertype)){
				filez[_i][7+_p]= ini_read_real(__header, _parametertype[_p], 1 );
				_p += 1
			}
			ini_close();
		    _i += 1;
		}
	}
	var _filesz=folder_finder(_directory)
	//filez=array_create(array_length(files))
	filez=[]
	var _i =0
	var __i=0
	repeat( array_length(_filesz) ){
		filez[_i]=array_create(7)
		__i=0
		repeat(7){
			filez[_i][__i]=array_create(1)
			__i+=1
		}
		filez[_i][0][0]=_filesz[_i]
		filez[_i][0][1]=false
		_i+=1
	}
	epicimport(_directory)
	return filez
}

#region file explorer function!
/// @description	this function returns an array with file/folder names
/// 
/// returns array_push(_files, _file_name)(runtime function)
///
/// ..
/// @function		folder_finder(_directory,_fle=fa_directory)
#endregion
folder_finder =function(_directory,_fle=fa_directory){
	var _files = [];var _file_name=file_find_first(_directory+"*",_fle)
	while (_file_name !=""){
		if(directory_exists(_directory+_file_name)||_fle=fa_none){
			array_push(_files, _file_name)}
		_file_name = file_find_next()}
	file_find_close();return _files}

/// @function	setup_character(_characters,_setup)
setup_character=function(_characters,_setup){
	var _i=array_length(_setup)-1
	repeat(array_length(_setup)){
		if _setup[_i]=true{
			array_delete(_characters, _i, 1);
		}
		_i-=1
	}
	return _characters
}

/// @function	global_characters(_char_setup1,_char_setup2)
global_characters=function(_char_setup1,_char_setup2){
	var _icharacters	= full_import(working_directory+"duude/file/")
	var _scharacters	= full_import(game_save_id+"characters/file/")
	_icharacters=setup_character(_icharacters,_char_setup1)
	_scharacters=setup_character(_scharacters,_char_setup2)
	global.characters=array_concat( _icharacters,_scharacters)
}

/// @function		addspr(_spr,_actor,_postn,_directory)
addspr=function(_spr,_actor,_postn,_directory){
	var _spi = ["file name","number of frames","centre point, x","centre point, y","frames per second"]
	ini_open				(_directory + _actor +"/"+_actor +".ini");
	var _sprstr=ini_read_string(_postn,_spi[0], "");
	var _sprf=	ini_read_real(_postn, _spi[1], 1 );
	var _sprx=	ini_read_real(_postn, _spi[2], 0);
	var _spry=	ini_read_real(_postn, _spi[3], 0);
	var _sprfps=ini_read_real(_postn, _spi[4], 5 );
	ini_close();
//var _spr= sprite_add (_directory +_actor +"/"+ _sprstr +".png" ,_sprf, true, true, 0, 0);
	sprite_replace(_spr,_directory +_actor +"/"+ _sprstr +".png" ,_sprf, false, false, 0, 0);
	sprite_collision_mask(_spr, true, 1, 0, 0, 0, 0, 0, 0);
	sprite_set_offset(_spr, _sprx, _spry);
	sprite_set_speed(_spr, _sprfps, spritespeed_framespersecond)
	return [_sprstr,_sprf,_sprx,_spry,_sprfps]
}

/// @function		parameter_import(_actor,_directory)
parameter_import=function(_actor,_directory){
	var _parametertype=["jumpframe","jumpspeed","walkstep2","jumpframe0","LandY","fllspd","myd"]
	var _prms=[]
	_prms[0]=_actor
	ini_open(_directory + _actor +"/"+_actor +".ini");
	var _p = 0;
	repeat (array_length(_parametertype)){
		_prms[_p+1]= ini_read_real("other parameters", _parametertype[_p], 1 );////////////
		_p += 1
	}
	ini_close();
	return _prms
}

//~~^_^~~//



/// @function	s_xport(_gnty,_directory,_zb=false,_zip=zip_create(),_zpd="")
/// @arg	_gnty
s_xport=function(_gnty,_directory,_zb=false,_zip=zip_create(),_zpd=""){
	var _postn=["","attacking","falling","standing","jumping","moving","attack hitbox"]
	var _ini = ["","file name","number of frames","centre point, x","centre point, y","frames per second"]
	var _i=0
	var _inidestination=_gnty[0][0] +"/"+_gnty[0][0]+".ini"
	ini_open(_directory+"/"+_inidestination);
	show_debug_message(_gnty)
	repeat (array_length(_postn)-1){//7-1=6
		_i+=1
		var _k=1
		var _pngdestination=_gnty[0][0]+"/"+_gnty[_i][_k]+".png"
		sprite_save_strip(_gnty[_i][0],_directory+"/"+_pngdestination)
		if _zb=true{
			zip_add_file(_zip, _zpd+"/"+_pngdestination,_directory+"/"+_pngdestination)}
		ini_write_string(_postn[_i], _ini[_k], _gnty[_i][_k]);
		repeat (array_length(_ini)-2){
			_k+=1
			ini_write_real(_postn[_i], _ini[_k], _gnty[_i][_k]);
			show_debug_message("_postn is {0}, _ini is {1}, _gnty is {2}, _i is {3}, _k is {4}", _postn[_i], _ini[_k], _gnty[_i][_k], _i, _k)
		}
	}
	var _parametertype=["","jumpframe","jumpspeed","walkstep2","jumpframe0","LandY","fllspd","myd"]
	_k=0
	repeat (array_length(_parametertype)-1){
		_k+=1
		ini_write_real("other parameters", _parametertype[_k], _gnty[0][_k]);
	}
	ini_close();
	if _zb=true{
		zip_add_file(_zip, _zpd+"/"+_inidestination,_directory+"/"+_inidestination)}
}

	_save_character_to_disk=function(_directory){
			var _i=1
			repeat(6){
				var _pop=array_pop(giant_array_for_character[_i])
				array_insert(giant_array_for_character[_i],0,_pop)
				_i+=1
			}
			s_xport(giant_array_for_character,_directory)
			_i=1
			repeat(6){
				var _shift=array_shift(giant_array_for_character[_i])
				array_push(giant_array_for_character[_i],_shift)
				_i+=1
			}
			var _scharacters	= full_import(game_save_id+"characters/file/")
			global.scharacter_setup[array_length(_scharacters)-1]=false
			scharacter_setup=array_concat(global.scharacter_setup,[])
			characters_saved=folder_finder(game_save_id+"characters/file/")
			preloaded=false
			characters=characters_saved
			character_setup=scharacter_setup
			character_setup=scharacter_setup
			character_array=[]
			position_array=[]
			parameter_check=false
			character_array[array_get_index(characters,giant_array_for_character[0][0])]=true
		}
		_naming_new=function(){
			var _quick_function=function(){
				var _str=giant_array_for_character[0][0]
				var _ltstr = string_letters(_str);
				if string_ends_with(_ltstr , "nEw"){
						var _nm = string_copy(_str,string_length(_str), 1)
						var _substr="nEw"+_nm
						var _newstr="nEw"+string((real(_nm)+1))
						_str=string_replace(_str, "nEw"+_nm, _newstr)
						giant_array_for_character[0][0]=_str
				}
				else {
					giant_array_for_character[0][0]=giant_array_for_character[0][0]+" nEw1"
				}
			}
			var _i=0
			repeat(array_length(characters_saved)){
				if characters_saved[_i]=giant_array_for_character[0][0]{
					_quick_function()
					break}
				_i+=1
			}
		}

			load_sprite=function(_selected_position){
				var position_names=["attacking","falling","standing","jumping","moving","attack hitbox"]
				var _actor		= characters[truth(character_array)]
				var _postn		= position_names[_selected_position]
				switch preloaded{
					case false:{var _directory = game_save_id+"characters/file/"}break
					case true:{ var _directory = working_directory+"duude/file/"}break
				}
				sprite_data=addspr(current_sprite,_actor,_postn,_directory)
			}
 epixexportt=function(){
	var _destination_yes=get_save_filename("zip file|*.zip", "");
	var _directory="temp/zippyzip/"
				
	if string_length(_directory)!=0 {
		//var _directory	= working_directory+"test/"
		var _i=1
		repeat(6){
			var _pop=array_pop(giant_array_for_character[_i])
			array_insert(giant_array_for_character[_i],0,_pop)
			_i+=1
		}					
					
		var _zip = zip_create();
		s_xport(giant_array_for_character,_directory,true,_zip, "lezip")
		zip_save(_zip, _destination_yes);
					
		_i=1
		repeat(6){
			var _shift=array_shift(giant_array_for_character[_i])
			array_push(giant_array_for_character[_i],_shift)
			_i+=1
		}
	}
	else {show_debug_message( "zippy.zip")}
}

		enable_edit=function(){
			if preloaded=false{var _directory = game_save_id+"characters/file/"}
			else if preloaded=true{var _directory	= working_directory+"duude/file/"}
			var _actor = characters[truth(character_array)]
			giant_array_for_character[0]=parameter_import(_actor,_directory)
			var _i=1
			var _temporary_array=[]
			var _object=false
			var position_names=["attacking","falling","standing","jumping","moving","attack hitbox"]
			repeat(array_length(position_names)){
				_temporary_array=addspr(current_sprite,_actor,position_names[_i-1],_directory)
				//show_debug_message(_temporary_array)
				_object=sprite_duplicate(current_sprite)
				//array_concat(giant_array_for_character[_i],_temporary_array)
				giant_array_for_character[_i]=_temporary_array
				//array_insert(giant_array_for_character[_i],0,_object)
				array_push(giant_array_for_character[_i],_object)
				_i+=1
				//show_debug_message(giant_array_for_character)
			}
		}

#endregion
ev_menu1=function(){
/// @description entering menu 1
			menu=[];menu[1]=true
			characters_internal=folder_finder(working_directory+"duude/file/")
			characters_saved=folder_finder(game_save_id+"characters/file/")
			switch preloaded{
				case false:{
					characters=characters_saved
					character_setup=scharacter_setup
				}break
					case true:{
					characters=characters_internal
					character_setup=icharacter_setup
				}break
			}
			lastpage = ceil((array_length(characters))/5);if lastpage = 0 lastpage =1
setup=false
current_sprite=sprite_duplicate(spr_joystick_stick0)
}
ev_menu2=function(){
/// @description goes to menu 2
				if instance_number(a_Player_GUI)<1{
					switch preloaded{
						case false:{global.characters= full_import(game_save_id+"characters/file/")}break
						case true:{global.characters= full_import(working_directory+"duude/file/")}break
					}
					instance_create_layer(333,300,"Instances",a_Player_GUI,{sprite_index: global.characters[truth(character_array)][3][0],bodyid:truth(character_array)+1});
					position_array=[]
				}
				menu=[];menu[2]=true;
				
}
ev_menu6=function(){
/// @description goes to menu 6
						menu = [];menu[6] = true;
						editing=false
						var _posit = truth(position_array)+1
								old=[]
								var _i=0;repeat(5){
									old[_i]=giant_array_for_character[_posit][_i]
									_i+=1
								}
						current_sprite=sprite_duplicate(giant_array_for_character[_posit][5])
						slastpage = ceil(sprite_get_number(current_sprite) / 5);
						if spage > slastpage{spage = slastpage}
}



name_check=function(){
		var _name_check=[];	_name_check[0]=false
		for (var i = 1; i <= 6; i++) {
			_name_check[i]=giant_array_for_character[i][0]
			if array_get_index(_name_check,_name_check[i])<i{
				return true
			}
		}
		return false
}


}  ///script 3