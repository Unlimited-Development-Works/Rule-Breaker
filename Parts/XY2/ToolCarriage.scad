use <../../Libs/e3d-scad/e3d-v6/e3d-v6.scad>;
use <../../Libs/Bearings.scad>;

module carriage() {
    translate([10, 10, -76]) e3d_v6();

    translate([-5, -5, -15]) color("green") cube([30, 30, 20]);

    translate([-15, -12, -5]) {
        translate([0, 0, 0]) rotate([90, 0, 90]) LM8UU();
        translate([LM8UU_Length() + 0.5, 0, 0]) rotate([90, 0, 90]) LM8UU();
    }

    translate([-8, 5, -25]) {
        translate([0, 0, 0]) rotate([90, 0, 0]) LM8UU();
        translate([0, LM8UU_Length() + 0.5, 0]) rotate([90, 0, 0]) LM8UU();
    }
}