/// @description functions, variable initialization, etc
// You can write your code in this editor
draw_set_font (fnt_button);		#region Set Font
draw_set_valign(fa_middle)		#endregion // Set Text Alignment
Script3()
send_to_debug=function(_varr){
var _lestringz =string("value of {0} is: ", _varr)
dbg_text(_lestringz ) ;
dbg_same_line();
dbg_text(ref_create(self, _varr)) ;
}
//send_to_debug(nameof(characters))
//send_to_debug(nameof(use_new))

//send_to_debug(nameof(character_setup))
//send_to_debug(nameof(position_array))
//send_to_debug(nameof(menu))
//send_to_debug(nameof(spage))
//send_to_debug(nameof(slastpage))
//send_to_debug(nameof(old))
//send_to_debug(nameof(select_x1))
//send_to_debug(nameof(select_y1))
//send_to_debug(nameof(select_x2))
//send_to_debug(nameof(select_y2))
//send_to_debug(nameof(_x))
//send_to_debug(nameof(_y))

if variable_global_exists("gamestart")=false{
	global.gamestart=true
	global.icharacter_setup=[]
	global.scharacter_setup=[]
	var _icharacters	= full_import(working_directory+"duude/file/")
	var _scharacters	= full_import(game_save_id+"characters/file/")
	var _lepicemptyarray=array_length(_scharacters)
	if _lepicemptyarray=0{_lepicemptyarray+=1}
	global.icharacter_setup[array_length(_icharacters)-1]=false
	global.scharacter_setup[_lepicemptyarray-1]=false
}
icharacter_setup=array_concat(global.icharacter_setup,[])
scharacter_setup=array_concat(global.scharacter_setup,[])

//preloaded=true
ini_open("settings.ini");
preloaded = ini_read_real("boot settings", "preloaded", true);
ini_close(); 



page=1
spage=1
drag_sprite=false
//menu_text_array=[]
button_click_array=[]
sub_button_array=[]
extra_button_array=[]
menu[0]=true
global.fakeclick=true
event_perform(ev_mouse,ev_global_left_press)
global.fakeclick=false

subframe=0


dude_x=x