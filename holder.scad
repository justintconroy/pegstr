include <base_dimensions.scad>;
include <round_rect_ex.scad>;

module holder(
	negative,
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
	strength_factor =  0.66)
{
	holder_sides = max(50, min(20, holder_x_size*2));
	holder_total_x = wall_thickness + holder_x_count*(wall_thickness+holder_x_size);
	holder_total_y = wall_thickness + holder_y_count*(wall_thickness+holder_y_size);
	//holder_total_z = round(holder_height/hole_spacing)*hole_spacing;
	holder_roundness = min(corner_radius, holder_x_size/2, holder_y_size/2); 

	for(x=[1:holder_x_count]){
		for(y=[1:holder_y_count]) 
/*		render(convexity=2)*/ {
			translate([
				-holder_total_y /*- (holder_y_size+wall_thickness)/2*/ + y*(holder_y_size+wall_thickness) + wall_thickness,

				-holder_total_x/2 + (holder_x_size+wall_thickness)/2 + (x-1)*(holder_x_size+wall_thickness) + wall_thickness/2,
				 0])			
	{
		rotate([0, holder_angle, 0])
		translate([
			-wall_thickness*abs(sin(holder_angle))-0*abs((holder_y_size/2)*sin(holder_angle))-holder_offset-(holder_y_size + 2*wall_thickness)/2 - board_thickness/2,
			0,
			-(holder_height/2)*sin(holder_angle) - holder_height/2 + clip_height/2
		])
		difference() {
			if (!negative)

				round_rect_ex(
					(holder_y_size + 2*wall_thickness), 
					holder_x_size + 2*wall_thickness, 
					(holder_y_size + 2*wall_thickness)*taper_ratio, 
					(holder_x_size + 2*wall_thickness)*taper_ratio, 
					holder_height, 
					holder_roundness + epsilon, 
					holder_roundness*taper_ratio + epsilon);

				translate([0,0,closed_bottom*wall_thickness])

				if (negative>1) {
					round_rect_ex(
						holder_y_size*taper_ratio, 
						holder_x_size*taper_ratio, 
						holder_y_size*taper_ratio, 
						holder_x_size*taper_ratio, 
						3*max(holder_height, hole_spacing),
						holder_roundness*taper_ratio + epsilon, 
						holder_roundness*taper_ratio + epsilon);
				} else {
					round_rect_ex(
						holder_y_size, 
						holder_x_size, 
						holder_y_size*taper_ratio, 
						holder_x_size*taper_ratio, 
						holder_height+2*epsilon,
						holder_roundness + epsilon, 
						holder_roundness*taper_ratio + epsilon);
				}

			if (!negative)
				if (holder_cutout_side > 0) {

				if (negative>1) {
					hull() {
						scale([1.0, holder_cutout_side, 1.0])
		 					round_rect_ex(
							holder_y_size*taper_ratio, 
							holder_x_size*taper_ratio, 
							holder_y_size*taper_ratio, 
							holder_x_size*taper_ratio, 
							3*max(holder_height, hole_spacing),
							holder_roundness*taper_ratio + epsilon, 
							holder_roundness*taper_ratio + epsilon);
		
						translate([0-(holder_y_size + 2*wall_thickness), 0,0])
						scale([1.0, holder_cutout_side, 1.0])
		 					round_rect_ex(
							holder_y_size*taper_ratio, 
							holder_x_size*taper_ratio, 
							holder_y_size*taper_ratio, 
							holder_x_size*taper_ratio, 
							3*max(holder_height, hole_spacing),
							holder_roundness*taper_ratio + epsilon, 
							holder_roundness*taper_ratio + epsilon);
					}
				} else {
					hull() {
						scale([1.0, holder_cutout_side, 1.0])
		 					round_rect_ex(
							holder_y_size, 
							holder_x_size, 
							holder_y_size*taper_ratio, 
							holder_x_size*taper_ratio, 
							holder_height+2*epsilon,
							holder_roundness + epsilon, 
							holder_roundness*taper_ratio + epsilon);
		
						translate([0-(holder_y_size + 2*wall_thickness), 0,0])
						scale([1.0, holder_cutout_side, 1.0])
		 					round_rect_ex(
							holder_y_size, 
							holder_x_size, 
							holder_y_size*taper_ratio, 
							holder_x_size*taper_ratio, 
							holder_height+2*epsilon,
							holder_roundness + epsilon, 
							holder_roundness*taper_ratio + epsilon);
						}
					}

				}
			}
		} // positioning
	} // for y
	} // for X
}

// Examples
//holder(false,13,13);
