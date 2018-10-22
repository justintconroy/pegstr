// PEGSTR - Pegboard Wizard
// Design by Marius Gheorghescu, November 2014
// Update log:
// November 9th 2014
//		- first coomplete version. Angled holders are often odd/incorrect.
// November 15th 2014
//		- minor tweaks to increase rendering speed. added logo. 
// November 28th 2014
//		- bug fixes

// preview[view:north, tilt:bottom diagonal]

include <base_dimensions.scad>;
include <pinboard.scad>;
include <holder.scad>;
include <pinboard_clips.scad>;
include <logo.scad>;

module pegstr(
	holder_x_size = 10,
	holder_y_size = 10,
	holder_height = 15,
	wall_thickness = 1.85,
	holder_x_count = 1,
	holder_y_count = 2,
	corner_radius = 30,
	taper_ratio = 1.0,
	holder_offset = 0.0,
	closed_bottom = 0.0,
	holder_cutout_side = 0.0,
	holder_angle = 0.0,
	strength_factor =  0.66,
	epsilon = 0.1) 
{
	holder_total_x = wall_thickness + holder_x_count*(wall_thickness+holder_x_size);
	holder_total_y = wall_thickness + holder_y_count*(wall_thickness+holder_y_size);
	holder_total_z = round(holder_height/hole_spacing)*hole_spacing;

	holder_sides = max(50, min(20, holder_x_size*2));
	clip_height = 2*hole_size + 2;

	
	difference() {
		union() {

			pinboard(
				false, holder_total_x, holder_height,
				wall_thickness, strength_factor);

			difference() {
				hull() {
					pinboard(
						false, holder_total_x, holder_height,
						wall_thickness, strength_factor);
	
					intersection() {
						translate([-holder_offset - (strength_factor-0.5)*holder_total_y - wall_thickness/4,0,0])
						cube([
							holder_total_y + 2*wall_thickness, 
							holder_total_x + wall_thickness, 
							2*holder_height
						], center=true);
	
						holder(0,
							holder_x_size, holder_y_size,
							holder_height, wall_thickness,
							holder_x_count, holder_y_count,
							corner_radius, taper_ratio,
							holder_offset, closed_bottom,
							holder_cutout_side, holder_angle,
							strength_factor);
	
					}	
				}

				if (closed_bottom*wall_thickness < epsilon) {
						holder(2,
							holder_x_size, holder_y_size,
							holder_height, wall_thickness,
							holder_x_count, holder_y_count,
							corner_radius, taper_ratio,
							holder_offset, closed_bottom,
							holder_cutout_side, holder_angle,
							strength_factor);
				}

			}

			//color([0.2,0.5,0])
			difference() {
				holder(0,
					holder_x_size, holder_y_size,
					holder_height, wall_thickness,
					holder_x_count, holder_y_count,
					corner_radius, taper_ratio,
					holder_offset, closed_bottom,
					holder_cutout_side, holder_angle,
					strength_factor);
				holder(2,
					holder_x_size, holder_y_size,
					holder_height, wall_thickness,
					holder_x_count, holder_y_count,
					corner_radius, taper_ratio,
					holder_offset, closed_bottom,
					holder_cutout_side, holder_angle,
					strength_factor);
			}

			color([0,0,0])
			pinboard_clips(
				holder_total_x, holder_height, strength_factor);
		}
	
		holder(1,
			holder_x_size, holder_y_size,
			holder_height, wall_thickness,
			holder_x_count, holder_y_count,
			corner_radius, taper_ratio,
			holder_offset, closed_bottom,
			holder_cutout_side, holder_angle,
			strength_factor);

		logo(holder_x_size, hole_size);
	}
}

// Examples



$fn = 32;
rotate([180,0,0]) pegstr(
	// width of the orifice
	holder_x_size = 10,
	
	// depth of the orifice
	holder_y_size = 10,
	
	// hight of the holder
	holder_height = 15,
	
	// how thick are the walls. Hint: 6*extrusion width produces the best results.
	wall_thickness = 1.85,
	
	// how many times to repeat the holder on X axis
	holder_x_count = 1,
	
	// how many times to repeat the holder on Y axis
	holder_y_count = 2,
	
	// orifice corner radius (roundness). Needs to be less than min(x,y)/2.
	corner_radius = 30,
	
	// Use values less than 1.0 to make the bottom of the holder narrow
	taper_ratio = 1.0,
	
	
	/* [Advanced] */
	
	// offset from the peg board, typically 0 unless you have an object that needs clearance
	holder_offset = 0.0,
	
	// what ratio of the holders bottom is reinforced to the plate [0.0-1.0]
	strength_factor = 0.66,
	
	// for bins: what ratio of wall thickness to use for closing the bottom
	closed_bottom = 0.0,
	
	// what percentage cu cut in the front (example to slip in a cable or make the tool snap from the side)
	holder_cutout_side = 0.0,
	
	// set an angle for the holder to prevent object from sliding or to view it better from the top
	holder_angle = 0.0);
