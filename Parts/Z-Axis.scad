use <Bearing-Mount.scad>;
use <Couplings.scad>;
use <Bearings.scad>;
use <Makerbeam.scad>;
use <Color.scad>;
use <Motors.scad>;

module z_axis() {

    translate([100, -35, 0])
    union() {
        //Top threaded mounting point
        translate([-25, 0, 307]) rotate([0, 180, 0])
            bearing_mount_with_bearing();

        //vertical rods
        translate([-25, 0, 25]) cylinder(d = 8, 282, $fn = 25);
        translate([50, 0, 17]) cylinder(d = 8, 290, $fn = 25);

        //Motor on threaded rod
        translate([-90, 0, 0]) rotate([0, -90, 180])
        motor_42BYGHW811();

        //screw bearing on threaded rod
        brass() translate([-25, 0, 55]) TTypeLeadScrew();

        //linear bearings on smooth rod
        translate([50, 0, 50]) LM8UU();
        translate([50, 0, 25]) LM8UU();

        //mounting beams
        color("grey") translate([110, -40, 74]) rotate([0, 0, 90]) makerbeam_200();
        color("grey") translate([110, -120, 74]) rotate([0, 0, 90]) makerbeam_200();

        //Hot bed
        %translate([-75, -160, 84]) cube([150, 150, 3]);

        //mounting part
        limey() render() translate([-75, -160, 70])
            cube([150, 150, 3]);
    }
}

z_axis();
