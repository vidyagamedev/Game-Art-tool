/// @description Insert description here
// You can write your code in this editor
guicheck=false

Bsndwalk=false;
Intimgindx=0;

_move_x = 0
_move_y = 0

//"people who change variable name suffixes and have logic explicitly dependent on that"
//"should use maps instead."
//	var _animationtype=["attacking","falling","standing","jumping","moving","attack hitbox"]
//	var _parametertype=["jumpframe","jumpspeed","walkstep2","jumpframe0","LandY","fllspd","myd"]
//all into arrays
//repeat(array_length(global.characters)){}
dudes = array_length(global.characters)
var _varynames=["spAttack","spJump2","sprIdle","spJump","sprWalk","HspAttack",
"jumpframe","jumpspeed","walkstep2","jumpframe0","LandY","fllspd","myd"]

if bodyid >= 1 && bodyid <= dudes then {
	var _i =0
	repeat(6){
		variable_instance_set(id, _varynames[_i], global.characters[bodyid-1][_i+1][0]);
		_i +=1
	}
	repeat(7){
		variable_instance_set(id, _varynames[_i], global.characters[bodyid-1][_i+1]);
		_i +=1
	}
	global.characters[bodyid-1][0][1]=true
}

else if bodyid == -1 then {ewCr();
	global.idbody.ew += 1}
else if bodyid == -2 then {nbCr();
	global.idbody.nb += 1}
else if bodyid == -3 then {pCr()}
else if bodyid == -4 then {BACr()};

gethit = function()
{
	if object_get_name(object_index)== "NPCa" ||object_get_name(object_index)==  "a_Player" {
		hp += -1;
		if(hp == 0){
			instance_destroy();
			effect_create_above(0, x + 0, y + 0, 0, $FFFFFF & $ffffff);
			global.characters[bodyid-1][0][1]=false
			if bodyid == -1 then {global.idbody.ew -= 1}
			else if bodyid == -2 then {global.idbody.nb -= 1};
		}
	}// if enemy
}//elseif hp =0
