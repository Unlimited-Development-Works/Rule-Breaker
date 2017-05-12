use <Bearing-Mount.scad>;
use <Couplings.scad>;
use <Bearings.scad>;
use <Makerbeam.scad>;
use <Color.scad>;
use <Motors.scad>;
use <../Libs/Involute-Gear.scad>;

module z_axis() {
    translate([100, -20, 0])
    union() {
        //Top threaded mounting point
        translate([-10, 0, 307]) rotate([0, 180, 0]) bearing_mount_with_bearing();

        //vertical rods
        translate([-30, 0, 0]) cylinder(d = 8, 310, $fn = 25);
        translate([50, 0, 0]) cylinder(d = 8, 310, $fn = 25);

        //Motor on threaded rod
        translate([-90, 20, 0]) {
            translate([2, -54, 0]) rotate([0, 0, 0]) motor_42BYGHW811();
        }

        //screw bearing on threaded rod
        translate([-30, 0, 65]) TTypeLeadScrew();

        //linear bearings on smooth rod
        translate([50, 0, 50]) LM8UU();
        translate([50, 0, 25]) LM8UU();

        //mounting beams
        translate([110, -40, 74]) rotate([0, 0, 90]) makerbeam_200();
        translate([110, -120, 74]) rotate([0, 0, 90]) makerbeam_200();

        //Hot bed
        %translate([-75, -160, 84]) cube([150, 150, 3]);

        //mounting part
        limey() render() translate([-75, -160, 70])
            cube([150, 150, 3]);
    }
}

z_axis();
