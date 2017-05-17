use <../../config.scad>;

use <../Makerbeam.scad>;
use <../Brackets.scad>;
use <../Couplings.scad>;
use <../Bearings.scad>;
use <../Color.scad>;
use <../Toolhead.scad>;

use <../../Libs/mistakes-were-made.scad>;

use <Y-Carriage.scad>;

module xy_axis(toolhead_x = 0, toolhead_y = 0) {

    module x_axis() {
        translate([200, 30, -8]) rotate([-90, 0, 90]) {
            translate([0, 0, 0]) cylinder(d = 8, 200, $fn = 15);
            translate([0, X_Axis_Rod_Vertical_Separation(), 0]) cylinder(d = 8, 200, $fn = 15);
        }

        translate([41 + toolhead_x, 0, 0])
            toolhead();
    }

    module y_axis() {

        //rods
        translate([-14, 0, -24]) rotate([-90, 0, 0]) cylinder(d = 8, 200, $fn = 15);
        translate([194, 0, -24]) rotate([-90, 0, 0]) cylinder(d = 8, 200, $fn = 15);

        //Bearings
        translate([0, toolhead_y, 0]) {
            translate([194, 10, -24]) rotate([-90, 0, 0]) LM8UU();
            translate([194, 35, -24]) rotate([-90, 0, 0]) LM8UU();
            translate([-14, 10, -24]) rotate([-90, 0, 0]) LM8UU();
            translate([-14, 35, -24]) rotate([-90, 0, 0]) LM8UU();
        }

        //Y carriage
        translate([0, toolhead_y + 10, -24]) {
            translate([194, 0, 0]) carriage_mid();
            translate([194.2, 0, 0]) carriage_clamp(false);
            translate([-14, 0, 0]) mirror([]) carriage_mid();
            translate([-14.2, 0, 0]) mirror([]) carriage_clamp(true);
        }

        //rod holders
        module rod_frame_holder() {
            difference() {
                union() {
                    linear_extrude(height = 10)
                        polygon([
                            [0, 0], [-2, 0], [-2, 12], [-10, 20], [-10, 42], [-15, 48], [-25, 48], [-25, 50], [0, 50]
                        ]);

                    translate([-10, 26, 4]) rotate([0, 90, 0])
                        cylinder(d = 15.5, h = 10, $fn = 125);
                }

                union() {
                    //Cube to remove half of the bigger cylinder
                    translate([-15, 15, 10.01])
                        cube([20, 20, 10]);

                    //Bottom screw hole
                    translate([-5, 6, 5]) rotate([0, 90, 0])
                        cylinder(h = 10, d = 3.2, $fn = 18);

                    //Top screw hole
                    translate([-20, 45, 5]) rotate([0, 90, 90])
                        cylinder(h = 10, d = 3.2, $fn = 18);

                    //Top screw hole into captive nut
                    translate([-5, 35, 5]) rotate([0, 90, 90])
                        cylinder(h = 20, d = 3.2, $fn = 18);

                    //Captive nut hole
                    translate([-7.9, 43, -10]) rotate([])
                        cube([5.8, 3, 30]);

                    //Main rod hole
                    translate([-15, 26, 4]) rotate([0, 90, 0])
                        cylinder(h = 20, r = 4.15, $fn = 28);
                }
            }
        }
        limey() {
            translate([-10, 0, -50]) rotate([90, 0, -90])
                rod_frame_holder();
            translate([190, 200, -50]) rotate([90, 0, 90])
                rod_frame_holder();
            translate([190, 0, -50]) rotate([90, 0, 90])
                mirror([1, 0, 0]) rod_frame_holder();
            translate([-10, 200, -50]) rotate([90, 0, -90])
                mirror([1, 0, 0]) rod_frame_holder();
        }
    }

    //Check toolhead position is in valid range
    arg_out_of_range(toolhead_x < 0, "xy_axis", "toolhead_x", "Toolhead position is out of range")
    arg_out_of_range(toolhead_x > 116, "xy_axis", "toolhead_x", "Toolhead position is out of range")
    arg_out_of_range(toolhead_y < 0, "xy_axis", "toolhead_y", "Toolhead position is out of range")
    arg_out_of_range(toolhead_y > 130, "xy_axis", "toolhead_y", "Toolhead position is out of range")
    {
        translate([0, 0, 290]) {
            union() {
                translate([10, -200 + toolhead_y, -4])
                    x_axis();
                translate([20, -210, 0])
                    y_axis();
            }
        }
    }
}

xy_axis(116, 0);