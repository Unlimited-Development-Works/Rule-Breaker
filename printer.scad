// Printer
use <Parts/Makerbeam.scad>;
use <Parts/L-Bracket.scad>;
use <Parts/Bearing-Mount.scad>;
use <Parts/Power-Supply.scad>;

module side_brackets() {
    // bottom right
    translate([30, 0, 20])
        rotate([0, 90 ,90])
            l_bracket();
    // bottom left
    translate([190, 1.5, 20])
        rotate([0, 90 ,-90])
            l_bracket();
    // top left
    translate([190, 0, 280])
        rotate([0, -90 ,-90])
            l_bracket();
    // top right
    translate([30, 1.5, 280])
        rotate([0, -90 ,90])
            l_bracket();
}

module frame_brackets() {
    // back brackets
    side_brackets();
    // left brackets
    rotate([0, 0, -90])
        translate([0, -1.5, 0])
            side_brackets();
    // right brackets
    rotate([0, 0, -90])
        translate([0, 220, 0])
            side_brackets();
    translate([0, -221.5, 0])
        side_brackets();
}

module printer() {
    // column 1 (C1)
    rotate([90, 0, 0])
        makerbeam_300();
    // column 2 (C2)
    rotate([90, 0 ,0])
        translate([210, 0, 0])
            makerbeam_300();
    // column 3 (C3)
    rotate([90, 0 ,0])
        translate([0, 0, 210])
            makerbeam_300();
    // column 4 (C4)
    rotate([90, 0 ,0])
        translate([210, 0, 210])
            makerbeam_300();
    // row 1 (R1)
    translate([0, -210, 0])
        makerbeam_200();
    // row 2 (R2)
    translate([210, -210, 0])
        makerbeam_200();
    // row 3 (R3)
    rotate([0, 0, 90])
        translate([-10, -210, 0])
            makerbeam_200();
    // row 4 (R4)
    rotate([0, 0, 90])
        translate([-220, -210, 0])
            makerbeam_200();
    // row 5 (R5)
    translate([0, -210, 290])
        makerbeam_200();
    // row 6 (R6)
    translate([210, -210, 290])
        makerbeam_200();
    // row 7 (R7)
    rotate([0, 0, 90])
        translate([-10, -210, 290])
            makerbeam_200();
    // row 8 (R8)
    rotate([0, 0, 90])
        translate([-220, -210, 290])
            makerbeam_200();
    frame_brackets();
	rotate([0, 180, 0])
		translate([-110, -35, -310])
			bearing_mount_with_bearing();
	translate([10, -95, 0])
		power_supply();
}
printer();
