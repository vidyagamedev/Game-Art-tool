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
	
/// @function fix_clips_array(sprite, clipping_array_h, clipping_array_v)
/// @description Modifies a sprite by adjusting subimages based on horizontal and vertical clipping arrays.
/// @param {sprite} sprite The input sprite to modify.
/// @param {array} clipping_array_h Array of horizontal clipping values for each subimage.
/// @param {array} clipping_array_v Array of vertical clipping values for each subimage.
/// @return {sprite} The modified sprite with adjusted subimages.
function fix_clips_array(sprite, clipping_array_h, clipping_array_v) {
    // Validate input
    var subimage_count = sprite_get_number(sprite);

    // Get sprite dimensions and offsets
    var _sprite_width = sprite_get_width(sprite);
    var _sprite_height = sprite_get_height(sprite);
    var xoffset = sprite_get_xoffset(sprite);
    var yoffset = sprite_get_yoffset(sprite);

    // Calculate total width increase
    var total_clipping = 0;
    for (var _i = 0; _i < subimage_count; _i++) {
        total_clipping += abs(clipping_array_h[_i]);
    }
    var new_width = _sprite_width + total_clipping;

    // Initialize arrays for tracking modified surfaces and widths
    var modified_surfaces = array_create(subimage_count, -1);
    var modified_indices = array_create(subimage_count, false);
    var modified_widths = array_create(subimage_count, 0);

    // Process all clipping transfers
    for (var _i = 0; _i < subimage_count; _i++) {
        if (clipping_array_h[_i] == 0) continue;

        var clip_width = abs(clipping_array_h[_i]);
        var clip_height = abs(clipping_array_v[_i]);
        //var source_index = _i; // Source subimage
		var target_index;


        if (clipping_array_h[_i] > 0) {
			target_index = (_i - 1 + subimage_count) % subimage_count;

			// Create surface for target subimage
			var surf_target = surface_create(new_width, _sprite_height);
            surface_set_target(surf_target);
            draw_clear_alpha(c_black, 0);

			// Draw target subimage (target_index)
            if (modified_indices[target_index] == true) {
                draw_surface(modified_surfaces[target_index], 0, 0);
            } else {
                draw_sprite(sprite, target_index, xoffset, yoffset);
            }

	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf_target_0.png",_i,target_index)
	//surface_save(surf_target, temp_file);

			// Draw clipped portion of source subimage
			if (modified_indices[target_index] == true) && clipping_array_v[target_index] = 0{
				var _adjustment=_sprite_width - abs(clipping_array_h[target_index]);}
			else { var _adjustment=_sprite_width;}
			if (clipping_array_v[_i] > 0) {
				draw_sprite_part(sprite, _i, 0, 0, clip_width, clip_height, _adjustment, 0);}
			else if (clipping_array_v[_i] < 0) {
			    draw_sprite_part(sprite, _i, 0, _sprite_height - clip_height, clip_width, clip_height, _adjustment, _sprite_height - clip_height);}
			else {
				draw_sprite_part(sprite, _i, 0, 0, clip_width, _sprite_height, _adjustment, 0);}
	
	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf_target_1.png",_i,_i)
	//surface_save(surf_target, temp_file);

			surface_reset_target();

            // Create surface for source subimage
            var surf_source = surface_create(new_width, _sprite_height);
            surface_set_target(surf_source);
            draw_clear_alpha(c_black, 0);

            // Draw remaining portion of source subimage
			if (clipping_array_v[_i] > 0) {
                draw_sprite_part(sprite, _i, 0, clip_height, clip_width, _sprite_height - clip_height, 0, clip_height);
                draw_sprite_part(sprite, _i, clip_width, 0, _sprite_width - clip_width, _sprite_height, clip_width, 0);
            }
			else if (clipping_array_v[_i] < 0) {
                draw_sprite_part(sprite, _i, 0, _sprite_height - clip_height, clip_width, clip_height, 0, _sprite_height - clip_height);
                draw_sprite_part(sprite, _i, clip_width, 0, _sprite_width - clip_width, _sprite_height, clip_width, 0);
            }
			else {
                draw_sprite_part(sprite, _i, clip_width, 0, _sprite_width - clip_width, _sprite_height, 0, 0);}
	
	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf_source.png",_i,_i)
	//surface_save(surf_source, temp_file);
	
            surface_reset_target();
        
		}
		else {
			target_index = (_i + 1) % subimage_count;
            
			// Create surface for source subimage
            var surf_source = surface_create(new_width, _sprite_height);
            surface_set_target(surf_source);
            draw_clear_alpha(c_black, 0);

			// Draw main portion of source subimage
            if (modified_indices[_i] == true) {
				var _adjustment=_sprite_width + abs(clipping_array_h[_i-1]);
				if (clipping_array_v[_i] > 0) {
	                draw_surface_part(modified_surfaces[_i], 0, 0, _adjustment - clip_width, _sprite_height, 0, 0);
	                draw_surface_part(modified_surfaces[_i], _adjustment - clip_width, clip_height, clip_width, _sprite_height - clip_height, _adjustment - clip_width, clip_height);
	            }
				else if (clipping_array_v[_i] < 0) {
	                draw_surface_part(modified_surfaces[_i], 0, 0, _adjustment - clip_width, _sprite_height, 0, 0);
	                draw_surface_part(modified_surfaces[_i], _adjustment - clip_width, 0, clip_width, _sprite_height - clip_height, _adjustment - clip_width,  0);
	            }
				else {
	                draw_surface_part(modified_surfaces[_i], 0, 0, _adjustment - clip_width, _sprite_height, 0, 0);}
			}
			else{			
				if (clipping_array_v[_i] > 0) {
	                draw_sprite_part(sprite, _i, 0, 0, _sprite_width - clip_width, _sprite_height, 0, 0);
	                draw_sprite_part(sprite, _i, _sprite_width - clip_width, clip_height, clip_width, _sprite_height - clip_height, _sprite_width - clip_width, clip_height);
	            }
				else if (clipping_array_v[_i] < 0) {
	                draw_sprite_part(sprite, _i, 0, 0, _sprite_width - clip_width, _sprite_height, 0, 0);
	                draw_sprite_part(sprite, _i, _sprite_width - clip_width, 0, clip_width, _sprite_height - clip_height, _sprite_width - clip_width,  0);
	            }
				else {
	                draw_sprite_part(sprite, _i, 0, 0, _sprite_width - clip_width, _sprite_height, 0, 0);}
			}
			
	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf_source.png",_i,_i)
	//surface_save(surf_source, temp_file);
	
			surface_reset_target();

            // Create surface for target subimage
            var surf_target = surface_create(new_width, _sprite_height);
            surface_set_target(surf_target);
            draw_clear_alpha(c_black, 0);

			// Draw clipped portion of source subimage
			if (modified_indices[_i] == true) {
				var _adjustment=_sprite_width + abs(clipping_array_h[_i-1]);
				if (clipping_array_v[_i] > 0) {
					draw_surface_part(modified_surfaces[_i], _adjustment - clip_width, 0, clip_width, clip_height, 0, 0);}
				else if (clipping_array_v[_i] < 0) {
					draw_surface_part(modified_surfaces[_i], _adjustment - clip_width, _sprite_height - clip_height, clip_width, clip_height, 0, _sprite_height - clip_height);}
				else{
					draw_surface_part(modified_surfaces[_i], _adjustment - clip_width, 0, clip_width, _sprite_height, 0, 0);}
			}
			else{
				if (clipping_array_v[_i] > 0) {
					draw_sprite_part(sprite, _i, _sprite_width - clip_width, 0, clip_width, clip_height, 0, 0);}
				else if (clipping_array_v[_i] < 0) {
					draw_sprite_part(sprite, _i, _sprite_width - clip_width, _sprite_height - clip_height, clip_width, clip_height, 0, _sprite_height - clip_height);}
				else{
					draw_sprite_part(sprite, _i, _sprite_width - clip_width, 0, clip_width, _sprite_height, 0, 0);}
			}

	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf_target_0.png",_i,target_index)
	//surface_save(surf_target, temp_file);
			
			// Draw next subimage (target_index)
			draw_sprite(sprite, target_index, xoffset + clip_width, yoffset);

	//var temp_file = string("temp/debug/{0}_ Pasting {1} surf_target_1.png",_i,_i)
	//surface_save(surf_target, temp_file);
            
			surface_reset_target();

        }
        modified_surfaces[_i] = surf_source;
        modified_surfaces[target_index] = surf_target;
        modified_indices[_i] = true;
        modified_indices[target_index] = true;
    }

    // Create final surface for sprite sheet
    var sprite_array = split_sprite_into_array(sprite);
    var final_surface = surface_create(new_width * subimage_count, _sprite_height);
    surface_set_target(final_surface);
    draw_clear_alpha(c_black, 0);

    // Draw all subimages onto final surface
    for (var _i = 0; _i < subimage_count; _i++) {
        if (modified_indices[_i]) {
            draw_surface(modified_surfaces[_i], _i * new_width, 0);
            surface_free(modified_surfaces[_i]);
        } else {
            draw_sprite(sprite_array[_i], 0, _i * new_width + xoffset, yoffset);
        }
    }
    surface_reset_target();

    // Clean up sprite array
    for (var _i = 0; _i < array_length(sprite_array); _i++) {
        sprite_delete(sprite_array[_i]);
    }

    // Save surface to file and create new sprite
    var temp_file = "temp/clipped spritesheet fixed.png";
    surface_save(final_surface, temp_file);
    surface_free(final_surface);

    var new_sprite = sprite_add(temp_file, subimage_count, false, false, xoffset, yoffset);
    return new_sprite;
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