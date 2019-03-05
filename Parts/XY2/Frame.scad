use <../../config.scad>;
use <../../materials.scad>;

module frame() {

    //rods (0.2mm shorter than reality, to prevent artifacts in rendering)
    metal() {
        translate([5, 0, -20]) rotate([-90, 0, 0]) cylinder(d = 8, 199.9, $fn = 15);
        translate([215, 0, -20]) rotate([-90, 0, 0]) cylinder(d = 8, 199.9, $fn = 15);

        translate([210, -5, -40]) rotate([-90, 0, 90]) cylinder(d = 8, 199.9, $fn = 15);
        translate([210, 205, -40]) rotate([-90, 0, 90]) cylinder(d = 8, 199.9, $fn = 15);
    }
}

frame();