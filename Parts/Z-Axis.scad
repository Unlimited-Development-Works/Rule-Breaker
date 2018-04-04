use <../config.scad>
use <../materials.scad>

use <Bearing-Mount.scad>;
use <../Libs/Couplings.scad>;
use <../Libs/Bearings.scad>;
use <../Libs/Makerbeam.scad>;
use <../Libs/Motors.scad>;
use <../Libs/Bevel-Gear.scad>;

module z_axis() {
    translate([100, -20, 0])
    union() {
        //vertical rods
        translate([-30, 0, 0]) cylinder(d = 8, 310, $fn = 25);
        translate([50, 0, 0]) cylinder(d = 8, 310, $fn = 25);

        //Motor on threaded rod
        translate([-90, 20, 0]) {

            translate([0, -10, 0]) rotate([0, -90, 180]) motor_42BYGHW811();
            translate([68, -31, 21]) rotate([0, 90, 0]) bevel_gear();
        }

        //Bevel Gear
        translate([-10, -1, 35]) rotate([0, 180, 0]) bevel_gear();

        //screw bearing on threaded rod
        translate([-10, 0, 55]) TTypeLeadScrew();

        //linear bearings on smooth rod
        translate([50, 0, 50]) LM8UU();
        translate([50, 0, 25]) LM8UU();

        //mounting beams
        translate([110, -40, 74]) rotate([0, 0, 90]) makerbeam_200();
        translate([110, -120, 74]) rotate([0, 0, 90]) makerbeam_200();

        //Hot bed
        %translate([-75, -160, 84]) cube([150, 150, 3]);

        //mounting part
        PETG() render() translate([-75, -160, 70])
            cube([150, 150, 3]);
    }
}

z_axis();
