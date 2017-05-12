use <Makerbeam.scad>;
use <Hotend.scad>;
use <Brackets.scad>;
use <Couplings.scad>;
use <Bearings.scad>;
use <Color.scad>;

module xy_axis() {

    //todo: This is a placeholder part with brackets at the top of the frame. These need to be merged into one single piece which forms the primary
    //      connection of the XY axis to the frame and includes parts for attaching the rods/motors/wire guides etc
    module top_brackets() {
        translate([10, -210, 0]) l_bracket_inner();
        translate([210, -210, 0]) rotate([0, 0, 90]) l_bracket_inner();
        translate([210, -10, 0]) rotate([0, 0, 180]) l_bracket_inner();
        translate([10, -10, 0]) rotate([0, 0, 270]) l_bracket_inner();
    }
    translate([0, 0, 290]) top_brackets();

    module x_axis() {
        translate([180, 10, -10]) rotate([-90, 0, 90]) cylinder(d = 8, 160, $fn = 25);
        translate([100, 10, -10]) rotate([-90, 0, 90]) TTypeLeadScrew();

        translate([180, 10, -30]) rotate([-90, 0, 90]) cylinder(d = 8, 160, $fn = 25);
        translate([112, 10, -30]) rotate([-90, 0, 90]) LM8UU();

        translate([100, 30, -50]) rotate([0, 0, 90]) e3d_v6();
    }

    module y_axis() {
        translate([0, 0, -10]) rotate([-90, 0, 0]) cylinder(d = 8, 200, $fn = 25);
        translate([0, 5, -10]) rotate([-90, 0, 0]) TTypeLeadScrew();

        translate([0, 0, -30]) rotate([-90, 0, 0]) cylinder(d = 8, 200, $fn = 25);
        translate([0, 0, -30]) rotate([-90, 0, 0]) LM8UU();

        translate([180, 0, -10]) rotate([-90, 0, 0]) cylinder(d = 8, 200, $fn = 25);
        translate([180, 0, -10]) rotate([-90, 0, 0]) LM8UU();

        translate([180, 0, -30]) rotate([-90, 0, 0]) cylinder(d = 8, 200, $fn = 25);
        translate([180, 0, -30]) rotate([-90, 0, 0]) LM8UU();
    }

    translate([0, 0, 290]) {
        union() {
            translate([10, -210, 0])
                x_axis();
            translate([20, -210, 0])
                y_axis();
        }
    }
}

render() xy_axis();