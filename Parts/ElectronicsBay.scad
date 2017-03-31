use <Power-Supply.scad>;
use <Control-Board.scad>;
use <Brackets.scad>;

module electronics_bay() {

    //todo: This is a placeholder part with brackets at the base of the frame. These need to be merged into one single piece which forms the bottom
    //      of the entire printer and has appropriate clips/screw holes/wire guides etc for all of the electronics bay parts.
    module frame_base() {
        translate([10, -210, 0]) l_bracket_inner();
        translate([210, -210, 0]) rotate([0, 0, 90]) l_bracket_inner();
        translate([210, -10, 0]) rotate([0, 0, 180]) l_bracket_inner();
        translate([10, -10, 0]) rotate([0, 0, 270]) l_bracket_inner();
    }
    frame_base();

    translate([10, -95 - 115, 0])
    union() {
        power_supply();
		translate([90, 85, 0])
			control_board();
    }
}