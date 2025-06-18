/// @description Insert description here
// You can write your code in this editor

var _cx = camera_get_view_x(view_camera[0]);
if instance_number(a_Player)>0 && instance_number(a_Player_GUI)=0{
	if global.mainplayer>=0 && instance_number(NPCa)<5{
		if cally >= 1 && cally <= dudes {
			var _i =0
			repeat(dudes){
				_i +=1
				if cally ==_i && global.characters[_i-1][0][1]=false {
					instance_create_layer
					(_cx -5, 690,"Instances",NPCa,
					{
						sprite_index: global.characters[_i-1][3][0],
						bodyid:_i
					})
				}
			}
		}
		if cally==dudes{
			cally=1}
		else {cally +=1}
	}
	else if global.mainplayer=-1{
		//timer-=100
		if global.idbody.ew <2{
			instance_create_layer(_cx -5, 690,"Instances",NPCa,{sprite_index: EWIdle,bodyid:-1});
			}
		else if global.idbody.nb <5{
			instance_create_layer(_cx -5, 690,"Instances",NPCa,{sprite_index: NBAttack15,bodyid:-2});
		}
	}
	else if global.mainplayer=-2{
		//timer-=150
		if global.idbody.ew <2{
			instance_create_layer(_cx -6, 690,"Instances",NPCa,{sprite_index: EWIdle,bodyid:-1});
		}
		else if global.idbody.nb <5{
			instance_create_layer(_cx -6, 690,"Instances",NPCa,{sprite_index: NBAttack15,bodyid:-2});
		}
	}
}
alarm[0]=30