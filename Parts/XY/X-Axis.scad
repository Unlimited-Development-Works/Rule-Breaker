use <../../config.scad>;

use <../Bearings.scad>;
use <../Color.scad>;
use <../Wheels.scad>;

module x_axis() {

    rod_z = LM8UU_Diameter() / 2 + 4 + X_Axis_Carriage_Rod_Vertical_Space();

    //Rods
    translate([200, 0, rod_z]) rotate([0, -90, 0]) {
        translate([0, -X_Axis_Rod_Separation() / 2, 0]) cylinder(d = 8, 200, $fn = 15);
        translate([0, X_Axis_Rod_Separation() / 2, 0]) cylinder(d = 8, 200, $fn = 15);
    }

    //Bearings
    /* translate([0, -LM8UU_Length() - 0.25, 0]) {
        translate([200, 0, 0]) rotate([-90, 0, 0]) LM8UU();
        translate([0, 0, 0]) rotate([-90, 0, 0]) LM8UU();
    }
    translate([0, 0.25, 0]) {
        translate([200, 0, 0]) rotate([-90, 0, 0]) LM8UU();
        translate([0, 0, 0]) rotate([-90, 0, 0]) LM8UU();
    } */

    //Carriage parts (3 stacked parts: inner, mid and outer)
    module carriage_mid() {

        thickness = X_Axis_Carriage_Mid_Bearing_Surround();
        x = LM8UU_Diameter() / 2 + thickness;
        y = max(X_Axis_Rod_Separation(), LM8UU_Length() * 2);
        z = LM8UU_Diameter() + X_Axis_Carriage_Rod_Vertical_Space() + thickness + 8 / 2;

        limey() difference() {
            union() {
                //Main body
                translate([-x, -y / 2, -LM8UU_Diameter() / 2 - thickness]) cube([x, y, z]);

                //Rod containers
                translate([0, 0, LM8UU_Diameter() / 2 + 4 + X_Axis_Carriage_Rod_Vertical_Space()]) {
                    translate([0, -X_Axis_Rod_Separation() / 2, 0]) rotate([0, -90, 0])
                        cylinder(d = 8 + X_Axis_Carriage_Rod_Surround_Extra_Diameter(), h = x, $fn = 25);
                    translate([0, X_Axis_Rod_Separation() / 2, 0]) rotate([0, -90, 0])
                        cylinder(d = 8 + X_Axis_Carriage_Rod_Surround_Extra_Diameter(), h = x, $fn = 25);
                }
            }
            union() {
                //Bearing hole
                translate([0, -LM8UU_Length() * 2, 0]) rotate([-90, 0, 0])
                    cylinder(d = LM8UU_Diameter() + LM8UU_Pressure_Fit_Extra_Diameter(), h = LM8UU_Length() * 4, $fn = 45);

                //Rod holes
                translate([x, 0, rod_z]) rotate([0, -90, 0])
                {
                    translate([0, -X_Axis_Rod_Separation() / 2, 0]) cylinder(d = 8 + Rod_Pressure_Fit_Extra_Diameter(), h = x * 3, $fn = 25);
                    translate([0, X_Axis_Rod_Separation() / 2, 0]) cylinder(d = 8 + Rod_Pressure_Fit_Extra_Diameter(), h = x * 3, $fn = 25);
                }

                //Screw holes for bearing clamp
                //todo: translate([-20, 6, 11]) rotate([0, 90, 0]) cylinder(d = 3, h = 40, $fn = 8);
            }
        }
    }

    module carriage_outer() {

        //Angled cutouts
        module cutout_block() {
            translate([0, 12, 19]) rotate([0, 35, 0])
                cube([30, 25, 30]);
        }

        limey() difference() {
            union() {
                //Main body
                translate([0, 1, -15 - Y_Axis_Carriage_Extra_Height() / 2])
                    cube([11, 47, X_Axis_Rod_Separation() + Y_Axis_Carriage_Extra_Height()]);
            }

            union() {
                //Bearing hole
                translate([0, -5, 0]) rotate([-90, 0, 0])
                    cylinder(d = 15.5, h = 60, $fn = 45);

                //Screw holes for bearing clamp
                translate([-20, 6, 11]) rotate([0, 90, 0]) cylinder(d = 3, h = 40, $fn = 8);
                translate([-20, 6, -11]) rotate([0, 90, 0]) cylinder(d = 3, h = 40, $fn = 8);
                translate([-20, 43, 11]) rotate([0, 90, 0]) cylinder(d = 3, h = 40, $fn = 8);
                translate([-20, 43, -11]) rotate([0, 90, 0]) cylinder(d = 3, h = 40, $fn = 8);

                //Cutout some excess material
                translate([0, 0, -1]) {
                    cutout_block();
                    mirror([0, 0, 1]) cutout_block();
                }
            }
        }
    }

    module carriage_inner() {
        //idlers
        translate([-22, 30, 0]) {
            translate([0, 0, -4.25]) {
                translate([0, 0, 4.5]) idler();
                translate([0, 0, -4.5]) idler();
            }
        }
    }

    translate([200, 0, 0]) {
        carriage_mid();
        //carriage_outer();
        //carriage_inner();
    }

    translate([0, 0, 0]) mirror([]) {
        carriage_mid();
        //carriage_outer();
        //carriage_inner();
    }
}

x_axis();