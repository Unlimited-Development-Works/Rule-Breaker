use <../Libs/Makerbeam.scad>;
use <Brackets.scad>;
use <Bearing-Mount.scad>;
use <Power-Supply.scad>;

module frame() {

    module brackets() {

        /* module side_brackets() {
            translate([10, 0, 10]) rotate([90, 0, 0]) l_bracket_inner();
            translate([10, 0, 290]) rotate([90, 90, 0]) l_bracket_inner();
            translate([210, 0, 290]) rotate([90, 180, 0]) l_bracket_inner();
            translate([210, 0, 10]) rotate([90, 270, 0]) l_bracket_inner();
        }

        side_brackets();
        translate([0, -220, 0]) rotate([0, 0, 90]) side_brackets();
        translate([220, -220, 0]) rotate([0, 0, 180]) side_brackets();
        translate([220, 0, 0]) rotate([0, 0, 270]) side_brackets(); */
    }

    module bars() {

        module horizontal_bars() {
        // rleft
        translate([0, -210, 0])
            makerbeam_200();
        // right
        translate([210, -210, 0])
            makerbeam_200();
        // back
        rotate([0, 0, 90])
            translate([-10, -210, 0])
                makerbeam_200();
        // front
        rotate([0, 0, 90])
            translate([-220, -210, 0])
                makerbeam_200();
        }

        //Columns
        rotate([90, 0, 0])
        union() {
            makerbeam_300();
            translate([210, 0, 0]) makerbeam_300();
            translate([0, 0, 210]) makerbeam_300();
            translate([210, 0, 210]) makerbeam_300();
        }
        
        //Top
        translate([0, 0, 290]) horizontal_bars();

        //Bottom
        horizontal_bars();
    }

    brackets();
    bars();
}

frame();