// Printer
use <Makerbeam.scad>;
use <L-Bracket.scad>;
use <Bearing-Mount.scad>;
use <Power-Supply.scad>;

module frame() {

    module brackets() {

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

        // front brackets
        translate([0, -221.5, 0])
            side_brackets();
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
