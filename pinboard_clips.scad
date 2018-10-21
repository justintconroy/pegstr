include <pin.scad>;
include <base_dimensions.scad>;

module pinboard_clips(
	holder_total_x,
	holder_height = 15,
	strength_factor =  0.66)
{
	rotate([0,90,0])
	for(i=[0:round(holder_total_x/hole_spacing)]) {
		for(j=[0:max(strength_factor, round(holder_height/hole_spacing))]) {

			translate([
				j*hole_spacing, 
				-hole_spacing*(round(holder_total_x/hole_spacing)/2) + i*hole_spacing, 
				0])
					pin(j==0);
		}
	}
}

/*
// examples
pinboard_clips(13);

translate([15,0,0])
	pinboard_clips(30,50);

translate([-15,0,0])
	pinboard_clips(30,15,3);
*/