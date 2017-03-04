MOTOR_SCREW_HOLE_DEPTH=8;
module screw_hole() {
    cylinder(h = MOTOR_SCREW_HOLE_DEPTH, d = 2.5, $fn = 15);
}

module motor_shaft() {
    cylinder(h = 25, d = 5, $fn = 15);
}

/*
Mercury Motor
SM-42BYG011-25
40/2011
Small
*/
module motor_SM42BYG01125() {
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

/*
Mercury Motor
42BYGHW811
Medium
*/
MEDIUM_MOTOR_WIDTH=42;
MEDIUM_MOTOR_HEIGHT=47;
MEDIUM_MOTOR_SCREW_OFFSET=4;
MEDIUM_MOTOR_SCREW_HEIGHT_OFFSET=MEDIUM_MOTOR_HEIGHT - MOTOR_SCREW_HOLE_DEPTH + 1;
module motor_42BYGHW811() {
    WIDTH=MEDIUM_MOTOR_WIDTH;
    HEIGHT=MEDIUM_MOTOR_HEIGHT;
    SCREW_OFFSET=MEDIUM_MOTOR_SCREW_OFFSET;
    SCREW_HEIGHT_OFFSET=MEDIUM_MOTOR_SCREW_HEIGHT_OFFSET;
    color("silver")
    difference() {
        union() {
            cube([WIDTH, WIDTH, HEIGHT]);
            translate([WIDTH / 2, WIDTH / 2, HEIGHT])
                cylinder(h = 2.3, d = 22, $fn = 15);
            translate([WIDTH / 2, WIDTH / 2, HEIGHT])
                motor_shaft();
        }
        union() {
            translate([SCREW_OFFSET, SCREW_OFFSET, SCREW_HEIGHT_OFFSET]) screw_hole();
            translate([SCREW_OFFSET, WIDTH - SCREW_OFFSET, SCREW_HEIGHT_OFFSET]) screw_hole();
            translate([WIDTH - SCREW_OFFSET, SCREW_OFFSET, SCREW_HEIGHT_OFFSET]) screw_hole();
            translate([WIDTH - SCREW_OFFSET, WIDTH - SCREW_OFFSET, SCREW_HEIGHT_OFFSET]) screw_hole();
        }
    }
}
//motor_SM42BYG01125();
//motor_42BYGHW811();