/// @description Insert description here
// You can write your code in this editor
if instance_number(a_Player)>=1{


rndmi = global.mainplayer
var ax = a_Player.x
var ay = a_Player.y

if rndmi >= 1 && rndmi <= dudes {
	var _i =0
	repeat(dudes){
		_i +=1
		if rndmi ==_i {
			instance_create_layer
			(ax,ay,"Instances",NPCa,
			{
				sprite_index: global.characters[_i-1][3][0],
				bodyid:_i
			})
		}
	}
}
else if rndmi =-1 {instance_create_layer(ax,ay,"Instances",NPCa,{sprite_index: EWIdle,bodyid:-1});}
else if rndmi=-2{instance_create_layer(ax,ay,"Instances",NPCa,{sprite_index: NBAttack15,bodyid:-2,_up: false,upp: false});}
instance_destroy(a_Player);


rndmi = bodyid
if rndmi >= 1 && rndmi <= dudes {
	var _i =0
	repeat(dudes){
		_i +=1
		if rndmi ==_i {
			instance_create_layer
			(x,y,"Instances",a_Player,
			{
				sprite_index: global.characters[_i-1][3][0],
				bodyid:_i
			})
		}
	}
}
else if rndmi = -1{instance_create_layer(x,y,"Instances",a_Player,{sprite_index: EWIdle,bodyid:-1});}
else if rndmi =-2{instance_create_layer(x,y, "Instances",a_Player,{sprite_index: NBAttack15,bodyid:-2,_up : false,upp: false});}
global.mainplayer = rndmi
instance_destroy();


}