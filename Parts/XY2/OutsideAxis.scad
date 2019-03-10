use <../../config.scad>;
use <../../materials.scad>;

use <../../Libs/Bearings.scad>;
use <../../Libs/Rods.scad>;

module outer_axis() {

    module carriage() {

        carriage_depth = 10;
        carriage_length = LM8UU_Length() * 2 + 1;
        carriage_height = LM8UU_Diameter() + 15;
        carriage_radius = carriage_height / 2 + 0.5;

        module carriage_inner() {
            PETG() {

                //Translate back so that rest of carriage is correctly aligned around bearing midpoint
                translate([-LM8UU_Length() / 2 - 0.5, 0, -carriage_height / 2]) {

                    // Main body with hole for bearings
                    difference() {
                        union() {

                            //Main body
                            intersection() {
                                cube([carriage_length, carriage_depth, carriage_height]);
                                translate([0, 0, carriage_height / 2]) rotate([90, 0, 90])  cylinder(r = carriage_radius, h = 100, $fn = 55);
                            }

                            //cylinder around rod
                            translate([LM8UU_Length() + 0.5, 0, 15 + carriage_height / 2]) rotate([-90, 0, 0]) cylinder(d = 8 + 10, h = carriage_depth, $fn = 100);

                            //bolt fixtures
                            translate([10, 0, 0]) {
                                bolt_fixture_positive();
                                translate([0, 0, carriage_height]) bolt_fixture_positive();
                            }
                            translate([carriage_length - 10, 0, 0]) {
                                bolt_fixture_positive();
                                translate([0, 0, carriage_height]) bolt_fixture_positive();
                            }

                            registration_spheres();
                        }

                        union() {

                            //bolt fixtures
                            translate([10, 0, 0]) {
                                bolt_fixture_negative();
                                translate([0, 0, carriage_height]) bolt_fixture_negative();
                            }
                            translate([carriage_length - 10, 0, 0]) {
                                bolt_fixture_negative();
                                translate([0, 0, carriage_height]) bolt_fixture_negative();
                            }

                            bearing_cutout();

                            //Hole for rod
                            translate([LM8UU_Length() + 0.5, 4.5, 15 + carriage_height / 2]) rotate([-90, 0, 0]) cylinder(d = 8 + Rod_Pressure_Fit_Extra_Diameter(), h = carriage_depth * 2, $fn = 55);
                        }
                    }
                }
            }
        }

        module carriage_outer() {
            PETG() {

                //Translate back so that rest of carriage is correctly aligned around bearing midpoint
                translate([-LM8UU_Length() / 2 - 0.5, -carriage_depth - 0.1, -carriage_height / 2]) {

                    difference() {
                        union() {

                            //Main body
                            intersection() {
                                cube([carriage_length, carriage_depth, carriage_height]);
                                translate([0, carriage_depth, carriage_height / 2]) rotate([90, 0, 90])  cylinder(r = carriage_radius, h = 100, $fn = 55);
                            }

                            //bolt fixtures
                            translate([10, 0, 0]) {
                                bolt_fixture_positive();
                                translate([0, 0, carriage_height]) bolt_fixture_positive();
                            }
                            translate([carriage_length - 10, 0, 0]) {
                                bolt_fixture_positive();
                                translate([0, 0, carriage_height]) bolt_fixture_positive();
                            }
                        }

                        union() {
                            translate([0, carriage_depth, 0]) {
                                bearing_cutout();
                                registration_spheres(0.3);
                            }

                            //bolt fixtures
                            translate([10, 0, 0]) {
                                bolt_fixture_negative();
                                translate([0, 0, carriage_height]) bolt_fixture_negative();
                            }
                            translate([carriage_length - 10, 0, 0]) {
                                bolt_fixture_negative();
                                translate([0, 0, carriage_height]) bolt_fixture_negative();
                            }
                        }
                    }
                }
            }
        }

        translate([0, 0, -20]) {

            translate([-LM8UU_Length() / 2 - 0.25, 0, 0]) rotate([90, 0, 90]) LM8UU();
            translate([LM8UU_Length() / 2 + 0.25, 0, 0]) rotate([90, 0, 90]) LM8UU();

            carriage_inner();
            carriage_outer();
            
        }

        module bearing_cutout() {
            translate([-20, 0, carriage_height / 2])
                rotate([90, 0, 90])
                    cylinder(d = LM8UU_Diameter() + LM8UU_Pressure_Fit_Extra_Diameter(), LM8UU_Length() * 10, $fn = 75);
        }

        module bolt_fixture_positive() {
            rotate([-90, 0, 0]) cylinder(d = U_Axis_Carriage_Screw_Guide_Diameter(), h = carriage_depth);
        }

        module bolt_fixture_negative() {
            translate([0, -carriage_depth, 0]) rotate([-90, 0, 0]) cylinder(d = U_Axis_Carriage_Screw_Hole_Diameter(), h = carriage_depth * 3, $fn=20);
        }

        module registration_spheres(extra_radius = 0) {
            translate([0, 0, 3]) {
                translate([3, 0, 0])
                    sphere(r = 2.5 + extra_radius, $fn = 25);
                translate([carriage_length - 3, 0, 0])
                    sphere(r = 2.5 + extra_radius, $fn = 25);
            }

            translate([0, 0, carriage_height - 3]) {
                translate([3, 0, 0])
                    sphere(r = 2.5 + extra_radius, $fn = 25);
                translate([carriage_length - 3, 0, 0])
                    sphere(r = 2.5 + extra_radius, $fn = 25);
            }
        }
    }

    translate([0, -5, -20]) carriage();
    translate([0, 205, -20]) mirror([0, 1, 0]) carriage();

    translate([LM8UU_Length() / 2, 0, -25]) rotate([-90, 0, 0])
        RodD8xL200();
}

outer_axis();