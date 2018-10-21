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

// width of the orifice
holder_x_size = 10;

// depth of the orifice
holder_y_size = 10;

// hight of the holder
holder_height = 15;

// how thick are the walls. Hint: 6*extrusion width produces the best results.
wall_thickness = 1.85;

// how many times to repeat the holder on X axis
holder_x_count = 1;

// how many times to repeat the holder on Y axis
holder_y_count = 2;

// orifice corner radius (roundness). Needs to be less than min(x,y)/2.
corner_radius = 30;

// Use values less than 1.0 to make the bottom of the holder narrow
taper_ratio = 1.0;


/* [Advanced] */

// offset from the peg board, typically 0 unless you have an object that needs clearance
holder_offset = 0.0;

// what ratio of the holders bottom is reinforced to the plate [0.0-1.0]
strength_factor = 0.66;

// for bins: what ratio of wall thickness to use for closing the bottom
closed_bottom = 0.0;

// what percentage cu cut in the front (example to slip in a cable or make the tool snap from the side)
holder_cutout_side = 0.0;

// set an angle for the holder to prevent object from sliding or to view it better from the top
holder_angle = 0.0;


/* [Hidden] */

// what is the $fn parameter
holder_sides = max(50, min(20, holder_x_size*2));

// dimensions the same outside US?
hole_spacing = 25.4;
hole_size = 6;//6.0035;
board_thickness = 5;


holder_total_x = wall_thickness + holder_x_count*(wall_thickness+holder_x_size);
holder_total_y = wall_thickness + holder_y_count*(wall_thickness+holder_y_size);
holder_total_z = round(holder_height/hole_spacing)*hole_spacing;
holder_roundness = min(corner_radius, holder_x_size/2, holder_y_size/2); 


// what is the $fn parameter for holders
$fn = 32;

epsilon = 0.1;

clip_height = 2*hole_size + 2;

module pegstr() 
{
	difference() {
		union() {

			pinboard();

			difference() {
				hull() {
					pinboard();
	
					intersection() {
						translate([-holder_offset - (strength_factor-0.5)*holder_total_y - wall_thickness/4,0,0])
						cube([
							holder_total_y + 2*wall_thickness, 
							holder_total_x + wall_thickness, 
							2*holder_height
						], center=true);
	
						holder(0);
	
					}	
				}

				if (closed_bottom*wall_thickness < epsilon) {
						holder(2);
				}

			}

			//color([0.2,0.5,0])
			difference() {
				holder(0);
				holder(2);
			}

			color([0,0,0])
			pinboard_clips();
		}
	
		holder(1);

		translate([-board_thickness/2,-1,-clip_height+5]) 
		rotate([-90,0,90]) {
			intersection() {
				union() {
					difference() {
						round_rect_ex(3, 10, 3, 10, 2, 1, 1);
						round_rect_ex(2, 9, 2, 9, 3, 1, 1);
					}
			
					translate([2.5, 0, 0]) 
						difference() {
							round_rect_ex(3, 10, 3, 10, 2, 1, 1);
							round_rect_ex(2, 9, 2, 9, 3, 1, 1);
						}
				}
			
				translate([0, -3.5, 0]) 
					cube([20,4,10], center=true);
			}
		
			translate([1.25, -2.5, 0]) 
				difference() {
					round_rect_ex(8, 7, 8, 7, 2, 1, 1);
					round_rect_ex(7, 6, 7, 6, 3, 1, 1);
		
					translate([3,0,0])
						cube([4,2.5,3], center=true);
				}
		
		
			translate([2.0, -1.0, 0]) 
				cube([8, 0.5, 2], center=true);
		
			translate([0,-2,0])
				cylinder(r=0.25, h=2, center=true, $fn=12);
		
			translate([2.5,-2,0])
				cylinder(r=0.25, h=2, center=true, $fn=12);
		}

	}
}


rotate([180,0,0]) pegstr();

