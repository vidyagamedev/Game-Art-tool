/// @description Insert description here
// You can write your code in this editor


#region debug
//show_debug_overlay(true)
send_to_debug=function(_varr){
var _lestringz =string("value of {0} is: ", _varr)
dbg_text(_lestringz ) ;
dbg_same_line();
dbg_text(ref_create(self, _varr)) ;
}
send_to_debug_epic=function(){
var _lestringz =string("{0} = ( {1} - {2} ) + {3}  ---->", "gspx","g_mx","g_mxi","gspxf")
if true=false{
dbg_text(_lestringz ) ;
dbg_same_line();dbg_text(ref_create(self, gspx)) ;
dbg_same_line();dbg_text(" = ( ") ;
dbg_same_line();dbg_text(ref_create(self, g_mx)) ;
dbg_same_line();dbg_text(" - ") ;
dbg_same_line();dbg_text(ref_create(self, g_mxi)) ;
dbg_same_line();dbg_text(" ) + ") ;
dbg_same_line();dbg_text(ref_create(self, gspxf)) ;
}
dbg_text(_lestringz )
send_to_debug(nameof(gspx))
send_to_debug(nameof(g_mx))
send_to_debug(nameof(g_mxi))
send_to_debug(nameof(gspxf))
send_to_debug(nameof(giant_array_for_character))
}
#endregion


spawnplayer = function()//create room code would make more sense for this.
					//but also, the function is only caleld, also only at the start. only once per game, per reset
{
//player selection
dudes = array_length(global.characters)	
		var rndmi =irandom_range(1, dudes);
	if rndmi >= 1 && rndmi <= dudes then {instance_create_layer(-5, 490,"Instances",a_Player,{sprite_index: global.characters[rndmi-1][3][0],bodyid:rndmi});}
	//else if rndmi = 4 {instance_create_layer(-5, 490,"Instances",a_Player,{sprite_index: MWIdle,bodyid:4});}
	//else if rndmi = 5 {instance_create_layer(-5, 490,"Instances",a_Player,{sprite_index: HKIdle,bodyid:5});}
	//else if rndmi = 6 {instance_create_layer(-5, 490,"Instances",a_Player,{sprite_index: FWIdle,bodyid:6});}
	//else if rndmi = 7 {rndmi=-1
	//	instance_create_layer(5, 490,"Instances",a_Player,{sprite_index: EWIdle,bodyid:-1});}
	//else if rndmi = 8 {rndmi=-2
	//	instance_create_layer(5, 490, "Instances",a_Player,{sprite_index: NBAttack15,bodyid:-2,_up : false,upp: false});}
	//else if rndmi = 9{//rndmi=0
	//	instance_create_layer(5, 490, "Instances",a_Player,{sprite_index: PIdle,bodyid:-3,_up : false,upp: false});}
	//else if rndmi = 10 {//rndmi=0
	//	instance_create_layer(5, 490, "Instances",a_Player,{sprite_index: BAIdle,bodyid:-4,_up : false,upp: false});}

	var _i =0
	repeat(dudes){
		_i +=1
		if rndmi !=_i {
			instance_create_layer
			(353-55*_i, 690,"Instances",NPCa,
			{
				sprite_index: global.characters[_i-1][3][0],
				bodyid:_i
			})
		}
	}
	//if rndmi !=4 {instance_create_layer(133, 690,"Instances",NPCa,{sprite_index: MWIdle,bodyid:4})}
	//if rndmi !=5 {instance_create_layer(92, 690,"Instances",NPCa,{sprite_index: HKIdle,bodyid:5})}
	//if rndmi !=6 {instance_create_layer(32, 690,"Instances",NPCa,{sprite_index: FWIdle,bodyid:6})}

global.mainplayer = rndmi
	//instance_create_layer(250,250,"Instances",NPCa,{sprite_index: RHJump2,bodyid:3});
}
global.idbody = 
{
	//radv : false,
	//wagl : false,
	//rh : false,
	//mw : false,
	//hk : false,
	//fw : false,
	ew : 0,
	nb : 0
};

alarm[0]=30
cally=2
enemycheck=-1
touched=false