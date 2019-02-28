use <../../config.scad>;
use <../../materials.scad>;

module y_axis() {

    //rods (0.2mm shorter than reality, to prevent artifacts in rendering)
    metal() {
        translate([-16, -0.1, -24]) rotate([-90, 0, 0]) cylinder(d = 8, 199.9, $fn = 15);
        translate([196, -0.1, -24]) rotate([-90, 0, 0]) cylinder(d = 8, 199.9, $fn = 15);
    }

    //rod holders
    module rod_frame_holder() {
        difference() {
            union() {

                //body of holder
                linear_extrude(height = 10)
                    polygon([
                        [0, 0], [-2, 0], [-2, 12], [-10, 20], [-10, 42], [-15, 48], [-25, 48], [-25, 50], [0, 50]
                    ]);

                //Cylinder sticking out the side to encompass rods
                translate([-10, 26, 4]) rotate([0, 90, 0])
                    cylinder(d = 15.5, h = 10, $fn = 125);
            }

            union() {
                //Cube to remove half of the bigger cylinder
                translate([-15, 15, 10.01])
                    cube([20, 20, 10]);

                //Bottom screw hole
                translate([-5, 6, 5]) rotate([0, 90, 0])
                    cylinder(h = 10, d = 3.2, $fn = 18);

                //Top screw hole
                translate([-20, 45, 5]) rotate([0, 90, 90])
                    cylinder(h = 10, d = 3.2, $fn = 18);

                //Top screw hole into captive nut
                translate([-5, 35, 5]) rotate([0, 90, 90])
                    cylinder(h = 20, d = 3.2, $fn = 18);

                //Captive nut hole
                translate([-7.9, 43, -10]) rotate([])
                    cube([5.8, 3, 30]);

                //Main rod hole
                translate([-15, 26, 4]) rotate([0, 90, 0])
                    cylinder(h = 20, r = 4.15, $fn = 28);
            }
        }
    }
    PETG() {
        translate([200, 0, -50]) rotate([90, 0, -90])
            rod_frame_holder();

        translate([-20, 200, -50]) rotate([90, 0, 90])
            rod_frame_holder();

        translate([-20, 0, -50]) rotate([90, 0, 90])
            mirror([1, 0, 0]) rod_frame_holder();

        translate([200, 200, -50]) rotate([90, 0, -90])
            mirror([1, 0, 0]) rod_frame_holder();
    }
}

y_axis();