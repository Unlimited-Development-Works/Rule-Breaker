// Printer
include <Parts/Makerbeam.scad>;
include <Parts/L-Bracket.scad>

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
    // bracket 1 (L1)
    translate([30, 0, 20])
        rotate([0, 90 ,90])
            l_bracket();
    // bracket 2 (L2)
    translate([-1.5, -30, 20])
        rotate([0, 90 ,0])
            l_bracket();
}
printer();