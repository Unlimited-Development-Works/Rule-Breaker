/*
Mercury Motor
SM-42BYG011-25
40/2011
*/
module screw_hole() {
    cylinder(h = 8, d = 2.5, $fn = 15);
}

module motor_shaft() {
    cylinder(h = 25, d = 5, $fn = 15);
}

module mercury_motor() {
    color("silver")
    difference() {
        union() {
            cube([42, 42, 33]);
            translate([21, 21, 33])
                cylinder(h = 2.3, d = 22, $fn = 15);
            translate([21, 21, 32])
                motor_shaft();
        }
        union() {
            translate([4, 4, 26]) screw_hole();
            translate([4, 38, 26]) screw_hole();
            translate([38, 4, 26]) screw_hole();
            translate([38, 38, 26]) screw_hole();
        }
    }
}
//mercury_motor();