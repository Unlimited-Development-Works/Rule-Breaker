use <../../config.scad>;

use <../Bearings.scad>;
use <../Color.scad>;
use <../Wheels.scad>;

module x_axis() {

    rod_z = -LM8UU_Diameter() / 2 - 4 - X_Axis_Carriage_Rod_Vertical_Space();
    rod_radius = 8 / 2;
    x = LM8UU_Diameter() / 2 + X_Axis_Carriage_Mid_Bearing_Surround();
    y = max(X_Axis_Rod_Separation(), LM8UU_Length() * 2);
    z = LM8UU_Diameter() + X_Axis_Carriage_Rod_Vertical_Space() + X_Axis_Carriage_Mid_Bearing_Surround() + rod_radius;

    module x_rods() {
        translate([204, 0, rod_z]) rotate([0, -90, 0]) {
            translate([0, -X_Axis_Rod_Separation() / 2, 0]) cylinder(d = 8, 200, $fn = 15);
            translate([0, X_Axis_Rod_Separation() / 2, 0]) cylinder(d = 8, 200, $fn = 15);
        }
    }

    module carriage_bearing_hole() {
        translate([0, -LM8UU_Length() * 2, 0]) rotate([-90, 0, 0])
            cylinder(d = LM8UU_Diameter() + LM8UU_Pressure_Fit_Extra_Diameter(), h = LM8UU_Length() * 4, $fn = 45);
    }

    module carriage_rod_containers(tdmul = 1, bdmul = 1) {

        d = 8 + X_Axis_Carriage_Rod_Surround_Extra_Diameter();

        translate([0, 0, -LM8UU_Diameter() / 2 - rod_radius - X_Axis_Carriage_Rod_Vertical_Space()]) {
            translate([0, -X_Axis_Rod_Separation() / 2, 0]) rotate([0, -90, 0])
                cylinder(d1 = tdmul * d, d2 = bdmul * d, h = x, $fn = 25);
            translate([0, X_Axis_Rod_Separation() / 2, 0]) rotate([0, -90, 0])
                cylinder(d1 = tdmul * d, d2 = bdmul * d, h = x, $fn = 25);
        }
    }

    module carriage_top_screw_containers() {
        difference() {
            translate([0, 0, -X_Axis_Carriage_Mid_Bearing_Surround() + z / 2]) rotate([0, -90, 0]) {
                translate([0, -y / 2 + X_Axis_Carriage_Screw_Guide_Diameter() / 2, 0])
                    cylinder(d = X_Axis_Carriage_Screw_Guide_Diameter(), h = x, $fn = 25);
                translate([0, y / 2 - X_Axis_Carriage_Screw_Guide_Diameter() / 2, 0])
                    cylinder(d = X_Axis_Carriage_Screw_Guide_Diameter(), h = x, $fn = 25);
            }
            translate([x, 0, LM8UU_Diameter() / 2 + X_Axis_Carriage_Screw_Hole_Diameter() / 2 + X_Axis_Carriage_Screw_Hole_Z_Offset()]) {
                translate([0, -y / 2 + X_Axis_Carriage_Screw_Guide_Diameter() / 2, 0]) rotate([0, -90, 0])
                    cylinder(d = X_Axis_Carriage_Screw_Hole_Diameter(), h = x * 3, $fn = 25);
                translate([0, y / 2 - X_Axis_Carriage_Screw_Guide_Diameter() / 2, 0]) rotate([0, -90, 0])
                    cylinder(d = X_Axis_Carriage_Screw_Hole_Diameter(), h = x * 3, $fn = 25);
            }
        }
    }

    module carriage_bottom_screw_holes() {
        translate([x * 3, 0, rod_z]) {
            translate([0, -X_Axis_Rod_Separation() / 2 + 4 + X_Axis_Carriage_Bottom_Screw_Hole_X_Offset(), 4]) rotate([0, -90, 0])
                cylinder(d = X_Axis_Carriage_Screw_Hole_Diameter(), h = x * 10, $fn = 25);
            translate([0, X_Axis_Rod_Separation() / 2 - 4 - X_Axis_Carriage_Bottom_Screw_Hole_X_Offset(), 4]) rotate([0, -90, 0])
                cylinder(d = X_Axis_Carriage_Screw_Hole_Diameter(), h = x * 10, $fn = 25);
        }
    }

    //Carriage parts (3 stacked parts: inner, mid and outer)
    module carriage_mid() {

        limey() printed() difference() {
            union() {
                //Main body
                translate([-x, -y / 2, -z / 2 - X_Axis_Carriage_Mid_Bearing_Surround()])
                    cube([x, y, z]);

                carriage_rod_containers();

                //Screw container
                translate([0, 0, 0])
                    carriage_top_screw_containers();
            }
            union() {
                carriage_bearing_hole();

                //Rod holes
                translate([-5.95, 0, rod_z]) rotate([0, -90, 0])
                {
                    translate([0, -X_Axis_Rod_Separation() / 2, 0]) cylinder(d = 8 + Rod_Pressure_Fit_Extra_Diameter(), h = x * 2, $fn = 25);
                    translate([0, X_Axis_Rod_Separation() / 2, 0]) cylinder(d = 8 + Rod_Pressure_Fit_Extra_Diameter(), h = x * 2, $fn = 25);
                }

                carriage_bottom_screw_holes();
            }
        }
    }

    module carriage_outer() {

        limey() printed() difference() {
            union() {
                //Main body
                translate([0, -y / 2, -z / 2 - X_Axis_Carriage_Mid_Bearing_Surround()])
                    cube([x, y, z]);

                translate([x, 0, 0])
                    carriage_top_screw_containers();

                translate([x, 0, 0])
                    carriage_rod_containers(tdmul = 0.2, bdmul = 0.2);
            }
            union() {
                carriage_bearing_hole();
                carriage_bottom_screw_holes();
            }
        }
    }

    module carriage_inner() {
        //idlers
        translate([-22, 30, 0]) {
            translate([0, 0, -4.25]) {
                not_printed() translate([0, 0, 4.5]) idler();
                not_printed() translate([0, 0, -4.5]) idler();
            }
        }
    }

    translate([6, 0, -24]) {
        //Rods
        not_printed() translate([204, 0, rod_z]) rotate([0, -90, 0]) {
            translate([0, -X_Axis_Rod_Separation() / 2, 0]) cylinder(d = 8, 200, $fn = 15);
            translate([0, X_Axis_Rod_Separation() / 2, 0]) cylinder(d = 8, 200, $fn = 15);
        }

        //Bearings
        not_printed() translate([0, -LM8UU_Length() - 0.25, 0]) {
            translate([210, 0, 0]) rotate([-90, 0, 0]) LM8UU();
            translate([-2, 0, 0]) rotate([-90, 0, 0]) LM8UU();
        }
        not_printed() translate([0, 0.25, 0]) {
            translate([210, 0, 0]) rotate([-90, 0, 0]) LM8UU();
            translate([-2, 0, 0]) rotate([-90, 0, 0]) LM8UU();
        }

        translate([210, 0, 0]) {
            carriage_mid();

            translate([0.15, 0, 0])
                carriage_outer();

            //carriage_inner();
        }

        translate([-2, 0, 0]) mirror([]) {
            carriage_mid();

            translate([0.15, 0, 0])
                carriage_outer();

            //carriage_inner();
        }
    }
}

x_axis();