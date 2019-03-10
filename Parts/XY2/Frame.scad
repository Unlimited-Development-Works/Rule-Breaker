use <../../config.scad>;
use <../../materials.scad>;

use <../../Libs/Rods.scad>;

module frame() {

    //Outer rods
    translate([5, 0, -20]) rotate([-90, 0, 0]) RodD8xL200();
    translate([215, 0, -20]) rotate([-90, 0, 0]) RodD8xL200();
    translate([210, -5, -40]) rotate([-90, 0, 90]) RodD8xL200();
    translate([210, 205, -40]) rotate([-90, 0, 90]) RodD8xL200();
}

frame();