use <../../config.scad>;

use <../Color.scad>;
use <../Wheels.scad>;

module carriage_mid() {
    limey() difference() {
        union() {
            //Main body
            translate([-11, 1, -15 - Y_Axis_Carriage_Extra_Height() / 2])
                cube([11, 47, X_Axis_Rod_Vertical_Separation() + Y_Axis_Carriage_Extra_Height()]);

            //Rod containers
            translate([-11, 30, 12]) rotate([0, 90, 0])
                cylinder(d = 20, h = 11, $fn = 25);
            translate([-11, 30, -X_Axis_Rod_Vertical_Separation() / 2]) rotate([0, 90, 0])
                cylinder(d = 20, h = 11, $fn = 25);
        }

        union() {
            //Bearing hole
            translate([0, -5, 0]) rotate([-90, 0, 0])
                cylinder(d = 15.5, h = 60, $fn = 45);

            //Rod holes
            translate([-23.7, 30, 12]) rotate([0, 90, 0])
                cylinder(d = 8.3, h = 20, $fn = 25);
            translate([-23.7, 30, 12 - X_Axis_Rod_Vertical_Separation()]) rotate([0, 90, 0])
                cylinder(d = 8.3, h = 20, $fn = 25);

            //Screw holes for bearing clamp
            translate([-20, 6, 11]) rotate([0, 90, 0]) cylinder(d = 3, h = 40, $fn = 8);
            translate([-20, 6, -11]) rotate([0, 90, 0]) cylinder(d = 3, h = 40, $fn = 8);
            translate([-20, 43, 11]) rotate([0, 90, 0]) cylinder(d = 3, h = 40, $fn = 8);
            translate([-20, 43, -11]) rotate([0, 90, 0]) cylinder(d = 3, h = 40, $fn = 8);
        }
    }

    //idlers
    translate([-22, 30, 0]) {
        translate([0, 0, -4.25]) {
            translate([0, 10, 4]) idler();
            translate([0, -10, -4]) idler();
        }
    }
}

module carriage_clamp(mirrored) {

    //Angled cutouts
    module cutout_block() {
        translate([0, 12, 19]) rotate([0, 35, 0])
            cube([30, 25, 30]);
    }

    limey() difference() {
        union() {
            //Main body
            translate([0, 1, -15 - Y_Axis_Carriage_Extra_Height() / 2])
                cube([11, 47, X_Axis_Rod_Vertical_Separation() + Y_Axis_Carriage_Extra_Height()]);
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