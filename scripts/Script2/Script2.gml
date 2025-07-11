// Function to split a sprite into an array of subimage sprites
// Argument0: The sprite to split
// Returns: Array of sprite indices (one for each subimage)
function split_sprite_into_array(sprite) {
    var subimage_count = sprite_get_number(sprite);
    var _sprite_width = sprite_get_width(sprite);
    var _sprite_height = sprite_get_height(sprite);
    var sprite_array = array_create(subimage_count, -1);
    var _xoffset = sprite_get_xoffset(sprite);
    var _yoffset = sprite_get_yoffset(sprite);
    
    // Loop through each subimage
    for (var i = 0; i < subimage_count; i++) {
        // Create a surface for this subimage
        var surf = surface_create(_sprite_width, _sprite_height );
        surface_set_target(surf);
        draw_clear_alpha(c_black, 0); // Clear surface
        // Draw the specific subimage
        draw_sprite_part(sprite, i, 0, 0, _sprite_width, _sprite_height , 0, 0);
        surface_reset_target();
        
        // Create a new sprite from the surface
        sprite_array[i] = sprite_create_from_surface(surf, 0, 0, _sprite_width, _sprite_height , false, false, 0, 0);
		sprite_set_offset(sprite_array[i], _xoffset, _yoffset);
        
        // Free the surface to avoid memory leaks
        surface_free(surf);
    }
    
    return sprite_array;
}

// Example usage in an object (e.g., Step or Create event)
// Assuming current_sprite is the sprite you want to split
////var sprite_array = split_sprite_into_array(current_sprite);

// Now sprite_array[0] is the first subimage as a sprite, sprite_array[1] is the second, etc.
// You can use these like any sprite, e.g., draw_sprite(sprite_array[0], 0, x, y);


//////////////////////////////////////////

// Function to move a sprite's contents one pixel to the right
// Argument0: The sprite to modify
// Returns: A new sprite with contents shifted one pixel to the right
function sprite_shift(sprite,shift_h=0,shift_v=0) {
    var _sprite_width = sprite_get_width(sprite);
    var _sprite_height = sprite_get_height(sprite);
    
    // Create a surface with the same dimensions as the sprite
    var surf = surface_create(_sprite_width, _sprite_height);
    surface_set_target(surf);
    draw_clear_alpha(c_black, 0); // Clear surface with transparent background
    
    // Draw the sprite shifted one pixel to the right
    draw_sprite_part(sprite, 0, 0, 0, _sprite_width, _sprite_height, shift_h, shift_v);
    // Note: The leftmost column (x=0) will be transparent (cleared to alpha 0)
    
    surface_reset_target();
    
    // Create a new sprite from the surface
    var new_sprite = sprite_create_from_surface(surf, 0, 0, _sprite_width, _sprite_height, false, false, sprite_get_xoffset(sprite), sprite_get_yoffset(sprite));
    
    // Free the surface to avoid memory leaks
    surface_free(surf);
    
    return new_sprite;
}



///////////////////////////



// Function to merge an array of sprites into a single sprite with multiple subimages
// Argument0: Array of sprite indices
// Returns: A single sprite with all input sprites as subimages
function merge_sprite_array(sprite_array) {
    var _array_length = array_length(sprite_array);
    if (_array_length == 0) return -1; // Return -1 if array is empty
    
    // Get dimensions from the first sprite (assume all sprites have same dimensions)
    var _sprite_width = sprite_get_width(sprite_array[0]);
    var _sprite_height = sprite_get_height(sprite_array[0]);
    var _xoffset = sprite_get_xoffset(sprite_array[0]);
    var _yoffset = sprite_get_yoffset(sprite_array[0]);
    
    // Create a surface to hold all subimages in a horizontal strip
    var surf = surface_create(_sprite_width * _array_length, _sprite_height);
    surface_set_target(surf);
    draw_clear_alpha(c_black, 0); // Clear surface with transparent background
    
    // Draw each sprite onto the surface
    for (var i = 0; i < _array_length; i++) {
		draw_sprite(sprite_array[i], 0, i * _sprite_width + _xoffset, _yoffset);
    }
    surface_reset_target();
    
    // Create a new sprite with multiple subimages
    var new_sprite = sprite_create_from_surface(surf, 0, 0, _sprite_width, _sprite_height, false, false, 0, 0);
    
    // Set the number of subimages (GameMaker needs this to be explicit)
    for (var i = 1; i < _array_length; i++) {
        sprite_add_from_surface(new_sprite, surf, i * _sprite_width, 0, _sprite_width, _sprite_height,false,false);
    }
    sprite_set_offset(new_sprite, _xoffset, _yoffset);
	
    // Free the surface to avoid memory leaks
    surface_free(surf);
    
    return new_sprite;
}
	
	
	
	
function fix_clips(sprite, subframe, clipping) {
	var subimage_count = sprite_get_number(sprite);
	var _sprite_width = sprite_get_width(sprite);
	var _sprite_height = sprite_get_height(sprite);
	var _xoffset = sprite_get_xoffset(sprite);
	var _yoffset = sprite_get_yoffset(sprite);
	//sprite_save_strip(sprite, "temp/tempspritesheet01.png");
	//var temp_sprite=sprite_add("temp/tempspritesheet01.png", 1, false, false, 0, 0);
	
	var frame
if clipping > 0 {
    var skip1 = subframe; // Source subimage
    var skip2 = subframe - 1; // Target subimage
    if skip2 = -1 { skip2 = subimage_count - 1; } // Wrap to last subimage if subframe = 0
    
    var surf1 = surface_create(_sprite_width + clipping, _sprite_height);
    surface_set_target(surf1);
    draw_clear_alpha(c_black, 0);
    draw_sprite_part(sprite, skip2, 0, 0, _sprite_width, _sprite_height, 0, 0); // Draw original target
    draw_sprite_part(sprite, skip1, 0, 0, clipping, _sprite_height, _sprite_width, 0); // Add columns from source
    surface_reset_target();
    
    var surf2 = surface_create(_sprite_width + clipping, _sprite_height);
    surface_set_target(surf2);
    draw_clear_alpha(c_black, 0);
    draw_sprite_part(sprite, skip1, clipping, 0, _sprite_width - clipping, _sprite_height, 0, 0); // Source minus columns
    surface_reset_target();
}
if clipping < 0 {
    clipping = -clipping; // Convert to positive for calculations
    var skip1 = subframe; // Source subimage
    var skip2 = subframe + 1; // Target subimage
    if skip2 = subimage_count { skip2 = 0; } // Wrap to first subimage if subframe = last
    
    var surf2 = surface_create(_sprite_width + clipping, _sprite_height);
    surface_set_target(surf2);
    draw_clear_alpha(c_black, 0);
    draw_sprite_part(sprite, skip1, 0, 0, _sprite_width - clipping, _sprite_height, 0, 0); // Source minus columns
    surface_reset_target();
	//var temp_file = "temp/surf2.png";
	//surface_save(surf2, temp_file);
    
    var surf1 = surface_create(_sprite_width + clipping, _sprite_height);
    surface_set_target(surf1);
    draw_clear_alpha(c_black, 0);
    draw_sprite_part(sprite, skip1, _sprite_width - clipping, 0, clipping, _sprite_height, 0, 0); // Columns from source
	//var temp_file = "temp/surf1_0.png";
	//surface_save(surf1, temp_file);
    draw_sprite_part(sprite, skip2, 0, 0, _sprite_width, _sprite_height, clipping, 0); // Original target
    surface_reset_target();
	//var temp_file = "temp/surf1.png";
	//surface_save(surf1, temp_file);
}
	
	var sprite_array=split_sprite_into_array(sprite)
	var _array_length = array_length(sprite_array);
	
	
	var surf = surface_create((_sprite_width + clipping) * subimage_count, _sprite_height);
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	for (var i = 0; i < _array_length; i++) {
	    if i = skip2 {
	        draw_surface(surf1, i * (_sprite_width + clipping), 0);
	        surface_free(surf1);
	    } else if i = skip1 {
	        draw_surface(surf2, i * (_sprite_width + clipping), 0);
	        surface_free(surf2);
	    } else {
	        draw_sprite(sprite_array[i], 0, i * (_sprite_width + clipping) + _xoffset + (clipping * 1), _yoffset);
	    }
	}
	
	var temp_file = "temp/tempspritesheet02.png";
	surface_save(surf, temp_file);
	surface_reset_target();
	surface_free(surf);
	var epic_spirte = sprite_add("temp/tempspritesheet02.png", subimage_count, false, false, _xoffset, _yoffset);
	return epic_spirte 
}









//////////////////////////////
/////////////////////////////
///////////////////////
////////////////
	
	
	
	
function fix_clips_array_backup(sprite, clipping_array) {
    var subimage_count = sprite_get_number(sprite);
    var _array_length = array_length(clipping_array);
    if (_array_length != subimage_count) return sprite; // Validate input
    
    var _sprite_width = sprite_get_width(sprite);
    var _sprite_height = sprite_get_height(sprite);
    var _xoffset = sprite_get_xoffset(sprite);
    var _yoffset = sprite_get_yoffset(sprite);
	
	var modified_width=[]
    
    // Calculate total width increase
    var total_clipping = 0;
    for (var i = 0; i < _array_length; i++) {
        total_clipping += abs(clipping_array[i]);
    }
    var _new_width = _sprite_width + total_clipping;
    
    // Create array to store modified surfaces
    var modified_surfaces = array_create(subimage_count, -1);
    var modified_indices = array_create(subimage_count, -1); // Track which subimages are modified
    
    // Step 1: Process all clipping transfers
    for (var i = 0; i < subimage_count; i++) {
        var clipping = clipping_array[i];
        if (clipping == 0) continue;
        
        var _abs_clipping = abs(clipping);
        var skip1 = i; // Source subimage
        var skip2 = (clipping > 0) ? (i - 1 + subimage_count) % subimage_count : (i + 1) % subimage_count; // Target
        
        if (clipping > 0) {
            // Target surface: Original target + columns from left of source
            var surf1 = surface_create(_sprite_width + _abs_clipping, _sprite_height);
            surface_set_target(surf1);
            draw_clear_alpha(c_black, 0);
			
            if (modified_indices[skip2] == 1) {
                draw_surface_part(modified_surfaces[skip2], 0, 0, _sprite_width, _sprite_height, 0, 0);
            } else {
                draw_sprite_part(sprite, skip2, 0, 0, _sprite_width, _sprite_height, 0, 0);
            }
			
	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf1_0.png",i,skip2)
	//surface_save(surf1, temp_file);
	
            if (modified_indices[skip2] == 1) {
                draw_sprite_part(sprite, skip1, 0, 0, _abs_clipping, _sprite_height, _sprite_width-clipping_array[skip2], 0)
            } else {
                draw_sprite_part(sprite, skip1, 0, 0, _abs_clipping, _sprite_height, _sprite_width, 0)
            }
			
	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf1_1.png",i,skip1)
	//surface_save(surf1, temp_file);
            surface_reset_target();
            
            // Source surface: Source minus left columns
            var surf2 = surface_create(_new_width, _sprite_height);
            surface_set_target(surf2);
            draw_clear_alpha(c_black, 0);
            draw_sprite_part(sprite, skip1, _abs_clipping, 0, _sprite_width - _abs_clipping, _sprite_height, 0, 0);
	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf2.png",i,skip1)
	//surface_save(surf2, temp_file);
            surface_reset_target();
        }
		else {
            // Target surface: Columns from right of source + original target
            var surf1 = surface_create(_sprite_width + _abs_clipping, _sprite_height);
            surface_set_target(surf1);
            draw_clear_alpha(c_black, 0);
            draw_sprite_part(sprite, skip1, _sprite_width - _abs_clipping, 0, _abs_clipping, _sprite_height, 0, 0);
	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf1_0.png",i,skip1)
	//surface_save(surf1, temp_file);
            draw_sprite_part(sprite, skip2, 0, 0, _sprite_width, _sprite_height, _abs_clipping, 0);
	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf1_1.png",i,skip2)
	//surface_save(surf1, temp_file);
            surface_reset_target();
            
            // Source surface: Source minus right columns
            var surf2 = surface_create(_new_width, _sprite_height);
            surface_set_target(surf2);
            draw_clear_alpha(c_black, 0);
			
	        if (modified_indices[skip1] == 1) {
				draw_surface_part(modified_surfaces[skip1],0,0,abs(modified_width[skip1])-_abs_clipping,_sprite_height,0,0)
	        } else {
				draw_sprite_part(sprite, skip1, 0, 0, _sprite_width - _abs_clipping, _sprite_height, 0, 0);
	        }

	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf2.png",i,skip1)
	//surface_save(surf2, temp_file);
            surface_reset_target();
        }
        
        modified_surfaces[skip1] = surf2;
        modified_surfaces[skip2] = surf1;
        modified_indices[skip1] = 1;
        modified_indices[skip2] = 1;
		modified_width[skip2]=_sprite_width + _abs_clipping
    }
    
    // Step 2: Create final surface
    var sprite_array = split_sprite_into_array(sprite);
    var surf = surface_create(_new_width * subimage_count, _sprite_height);
    surface_set_target(surf);
    draw_clear_alpha(c_black, 0);
    for (var i = 0; i < subimage_count; i++) {
        if (modified_indices[i] == 1) {
            draw_surface(modified_surfaces[i], i * _new_width, 0);
            surface_free(modified_surfaces[i]);
        } else {
            draw_sprite(sprite_array[i], 0, i * _new_width + _xoffset, _yoffset);
        }
    }
    surface_reset_target();
    
    // Free sprite array
    for (var i = 0; i < array_length(sprite_array); i++) {
        sprite_delete(sprite_array[i]);
    }
    
    // Step 3: Save and create new sprite
    var temp_file = "temp/tempspritesheet02.png";
    surface_save(surf, temp_file);
    surface_free(surf);
    
    var epic_sprite = sprite_add("temp/tempspritesheet02.png", subimage_count, false, false, _xoffset, _yoffset);
    return epic_sprite;
}
	
function fix_clips_array(sprite, clipping_array_h,clipping_array_v) {
    var subimage_count = sprite_get_number(sprite);
    var _array_length = array_length(clipping_array_h);
    if (_array_length != subimage_count) return sprite; // Validate input
    
    var _sprite_width = sprite_get_width(sprite);
    var _sprite_height = sprite_get_height(sprite);
    var _xoffset = sprite_get_xoffset(sprite);
    var _yoffset = sprite_get_yoffset(sprite);
	
	var modified_width=[]
    
    // Calculate total width increase
    var total_clipping = 0;
    for (var i = 0; i < _array_length; i++) {
        total_clipping += abs(clipping_array_h[i]);
    }
    var _new_width = _sprite_width + total_clipping;
    
    // Create array to store modified surfaces
    var modified_surfaces = array_create(subimage_count, -1);
    var modified_indices = array_create(subimage_count, -1); // Track which subimages are modified
    
    // Step 1: Process all clipping transfers
    for (var i = 0; i < subimage_count; i++) {
        var clipping = clipping_array_h[i];
        if (clipping == 0) continue;
        
        var _abs_clipping = abs(clipping);
        var skip1 = i; // Source subimage
        var skip2 = (clipping > 0) ? (i - 1 + subimage_count) % subimage_count : (i + 1) % subimage_count; // Target
        
        if (clipping > 0) {
            // Target surface: Original target + clipping from left of source
            var surf1 = surface_create(_sprite_width + _abs_clipping, _sprite_height);
            surface_set_target(surf1);
            draw_clear_alpha(c_black, 0);

            //drawing all of previous subframe (skip2)
			if (modified_indices[skip2] == 1) {
                draw_surface_part(modified_surfaces[skip2], 0, 0, _sprite_width, _sprite_height, 0, 0);
            } else {
                           draw_sprite_part(sprite, skip2, 0, 0, _sprite_width, _sprite_height, 0, 0);
            }
			
	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf1_0.png",i,skip2)
	//surface_save(surf1, temp_file);
	
            //drawing clipping of focused subframe (skip1) to fix previous subframe
			if (modified_indices[skip2] == 1) && clipping_array_v[skip2]=0{
				//if clipping_array_v[skip2]>0{//or <0
				//draw_sprite_part(sprite, skip1, 0, 0, _abs_clipping, clipping_array_v[i], _sprite_width, 0)
				//  draw_sprite_part(sprite, skip1, 0, 0, _abs_clipping, _sprite_height, _sprite_width, 0)
				//}
				//else{//clipping_array_v[skip2]=0 AND clipping_array_v[i]=0
                draw_sprite_part(sprite, skip1, 0, 0, _abs_clipping, _sprite_height, _sprite_width-clipping_array_h[skip2], 0)
				//}
            } else {
				if clipping_array_v[i]>0{
				draw_sprite_part(sprite, skip1, 0, 0, _abs_clipping, clipping_array_v[i], _sprite_width, 0)
				}
                else {
				draw_sprite_part(sprite, skip1, 0, 0, _abs_clipping, _sprite_height, _sprite_width, 0)
				}
            }
			
	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf1_1.png",i,skip1)
	//surface_save(surf1, temp_file);
            surface_reset_target();
            
            // Source surface: Source minus left columns WTF ARE YOU TALKIGN ABOUG
			
            var surf2 = surface_create(_new_width, _sprite_height);
            surface_set_target(surf2);
            draw_clear_alpha(c_black, 0);
			
			//drawing rest of focused subframe... (skip1)
			if clipping_array_v[i]>0{
				draw_sprite_part(sprite, skip1, 0, clipping_array_v[i], _abs_clipping, _sprite_height-clipping_array_v[i], 0, clipping_array_v[i])
				draw_sprite_part(sprite, skip1, _abs_clipping, 0, _sprite_width - _abs_clipping, _sprite_height, _abs_clipping, 0);
			}

			else{
            draw_sprite_part(sprite, skip1, _abs_clipping, 0, _sprite_width - _abs_clipping, _sprite_height, 0, 0);
			}
	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf2.png",i,skip1)
	//surface_save(surf2, temp_file);
            surface_reset_target();
        }
		else {
            // Target surface: Columns from right of source + original target
            var surf1 = surface_create(_sprite_width + _abs_clipping, _sprite_height);
            surface_set_target(surf1);
            draw_clear_alpha(c_black, 0);
			var _yy=0
			if clipping_array_v[i]=0{}
			if clipping_array_v[i]>0{}
			if clipping_array_v[i]<0{}
            draw_sprite_part(sprite, skip1, _sprite_width - _abs_clipping, 0, _abs_clipping, _sprite_height, 0, 0);
	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf1_0.png",i,skip1)
	//surface_save(surf1, temp_file);
            draw_sprite_part(sprite, skip2, 0, 0, _sprite_width, _sprite_height, _abs_clipping, 0);
	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf1_1.png",i,skip2)
	//surface_save(surf1, temp_file);
            surface_reset_target();
            
            // Source surface: Source minus right columns
            var surf2 = surface_create(_new_width, _sprite_height);
            surface_set_target(surf2);
            draw_clear_alpha(c_black, 0);
			
	        if (modified_indices[skip1] == 1) {
				draw_surface_part(modified_surfaces[skip1],0,0,abs(modified_width[skip1])-_abs_clipping,_sprite_height,0,0)
	        } else {
				draw_sprite_part(sprite, skip1, 0, 0, _sprite_width - _abs_clipping, _sprite_height, 0, 0);
	        }

	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf2.png",i,skip1)
	//surface_save(surf2, temp_file);
            surface_reset_target();
        }
        
        modified_surfaces[skip1] = surf2;
        modified_surfaces[skip2] = surf1;
        modified_indices[skip1] = 1;
        modified_indices[skip2] = 1;
		modified_width[skip2]=_sprite_width + _abs_clipping
    }
    
    // Step 2: Create final surface
    var sprite_array = split_sprite_into_array(sprite);
    var surf = surface_create(_new_width * subimage_count, _sprite_height);
    surface_set_target(surf);
    draw_clear_alpha(c_black, 0);
    for (var i = 0; i < subimage_count; i++) {
        if (modified_indices[i] == 1) {
            draw_surface(modified_surfaces[i], i * _new_width, 0);
            surface_free(modified_surfaces[i]);
        } else {
            draw_sprite(sprite_array[i], 0, i * _new_width + _xoffset, _yoffset);
        }
    }
    surface_reset_target();
    
    // Free sprite array
    for (var i = 0; i < array_length(sprite_array); i++) {
        sprite_delete(sprite_array[i]);
    }
    
    // Step 3: Save and create new sprite
    var temp_file = "temp/tempspritesheet02.png";
    surface_save(surf, temp_file);
    surface_free(surf);
    
    var epic_sprite = sprite_add("temp/tempspritesheet02.png", subimage_count, false, false, _xoffset, _yoffset);
    return epic_sprite;
}




function flip_sprite(sprite) {
	//sprite_save_strip(sprite, "temp/debug/tempspritesheet00.png");
    var spr_width = sprite_get_width(sprite);
    var spr_height = sprite_get_height(sprite);
    var spr_frames = sprite_get_number(sprite);
	var _xoffset = sprite_get_xoffset(sprite);
    var _yoffset = sprite_get_yoffset(sprite);

    sprite_set_offset(sprite, spr_width, 0);
	var surf = surface_create(spr_width, spr_height);
	surface_set_target(surf);
    for (var i = 0; i < spr_frames; i++) {
        draw_clear_alpha(c_black, 0);
        draw_sprite_ext(sprite, i, 0, 0, -1, 1, 0, c_white, 1);
	//var temp_file = ("temp/debug/surf.png")
	//var temp_file = string("temp/debug/surf {0}.png",i)
	//surface_save(surf, temp_file);
        if (i = 0) {var new_sprite = sprite_create_from_surface(surf, 0, 0, spr_width, spr_height, false, false, _xoffset, _yoffset);}
		else{sprite_add_from_surface(new_sprite, surf, 0, 0, spr_width, spr_height, false, false);}
    }
    surface_reset_target();
    surface_free(surf);
	//sprite_set_offset(new_sprite, _xoffset, _yoffset);
	//sprite_save_strip(new_sprite, "temp/debug/tempspritesheet01.png");
    return new_sprite;
}