BEARING_DIAMETER = 22;
BEARING_DEPTH = 7;
BEARING_INNER_HOLE = 8;
module bearing_mount() {
    beam_width = 10;
	padding = 10;
	wall_thickness = 5;
    color("Green") {
		difference() {
			union() {
				cylinder(d = BEARING_DIAMETER + padding, h = BEARING_DEPTH);
				translate([-((BEARING_DIAMETER + padding) / 2), 0, 0])
					cube([BEARING_DIAMETER + padding, BEARING_DIAMETER + (padding * 2) - 2, BEARING_DEPTH]);
					translate([-(BEARING_DIAMETER + padding) / 2, (wall_thickness * 2) + padding, BEARING_DEPTH])
						makerbeam_wall_sling(wall_thickness, BEARING_DIAMETER + padding, beam_width, 2);
			}
			translate([0, 0, -(BEARING_DEPTH / 2)])
				cylinder(d = BEARING_DIAMETER, h = BEARING_DEPTH * 2);
		}
    }
}

module bearing_mount_base() {
}

module makerbeam_wall_sling(wall_thickness, width, gap, multiplier =1) {
	cube([width, wall_thickness, gap * multiplier]);
	translate([0, gap + wall_thickness, 0])
		cube([width, wall_thickness, gap * multiplier]);
}

module bearing_mount_with_bearing() {
	tollerance = 0.1;
	bearing_mount();
	color("Red") {
		difference() {
			translate([0, 0, -tollerance])
				cylinder(d = BEARING_DIAMETER, h = BEARING_DEPTH + (tollerance * 2));
			translate([0, 0, -(BEARING_DEPTH / 2)])
				cylinder(d = BEARING_INNER_HOLE, h = BEARING_DEPTH * 2);
		}
	}
}

bearing_mount_with_bearing();

bearing_mount();