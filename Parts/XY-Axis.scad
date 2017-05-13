use <Makerbeam.scad>;
use <Hotend.scad>;
use <Brackets.scad>;
use <Couplings.scad>;
use <Bearings.scad>;
use <Color.scad>;

module xy_axis() {

    module x_axis() {
        translate([200, 10, -10]) rotate([-90, 0, 90]) cylinder(d = 8, 200, $fn = 25);
        translate([100, 10, -10]) rotate([-90, 0, 90]) LM8UU();

        translate([200, 10, -30]) rotate([-90, 0, 90]) cylinder(d = 8, 200, $fn = 25);
        translate([112, 10, -30]) rotate([-90, 0, 90]) LM8UU();

        translate([100, 30, -50]) rotate([0, 0, 90]) e3d_v6();
    }

    module y_axis() {

        //rods
        /* translate([-15, 0, -24]) rotate([-90, 0, 0]) cylinder(d = 8, 200, $fn = 25);
        translate([-15, 10, -24]) rotate([-90, 0, 0]) LM8UU();

        translate([195, 0, -24]) rotate([-90, 0, 0]) cylinder(d = 8, 200, $fn = 25);
        translate([195, 10, -24]) rotate([-90, 0, 0]) LM8UU(); */

        //rod holders
        module holder() {
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
                    translate([-20, 10, 10.01])
                        cube([30, 30, 30]);

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

        //rod holders
        translate([0, 0, 50])
            limey() holder();
    }

    translate([0, 0, 290]) {
        union() {
            /* translate([10, -200, -4])
                x_axis(); */
            translate([20, -210, 0])
                y_axis();
        }
    }
}

render() xy_axis();