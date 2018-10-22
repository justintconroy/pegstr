include <base_dimensions.scad>;
include <round_rect_ex.scad>;


module logo(
	holder_x_size = 10,
	hole_size = 6.0035,
)
{
	
	clip_height = 2*hole_size + 2;
	translate([-board_thickness/2,-1,-clip_height+5]) 
	rotate([-90,0,90]) {
		intersection() {
			union() {
				difference() {
					round_rect_ex(
						3, 10,
						3, 10,
						2,
						1, 1,
						holder_x_size);
					round_rect_ex(
						2, 9,
						2, 9,
						3,
						1, 1,
						holder_x_size);
				}
		
				translate([2.5, 0, 0]) 
					difference() {
						round_rect_ex(
							3, 10,
							3, 10,
							2,
							1, 1,
							holder_x_size);
						round_rect_ex(
							2, 9,
							2, 9,
							3,
							1, 1,
							holder_x_size);
					}
			}
		
			translate([0, -3.5, 0]) 
				cube([20,4,10], center=true);
		}
	
		translate([1.25, -2.5, 0]) 
			difference() {
				round_rect_ex(
					8, 7,
					8, 7,
					2,
					1, 1,
					holder_x_size);
				round_rect_ex(
					7, 6,
					7, 6,
					3,
					1, 1,
					holder_x_size);
	
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

//logo();