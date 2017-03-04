// This bed mounting assumes a certain setup of heated bed. Since we don't want a printed
// plastic part in direct contact with a heated bed there should be two metal bars mounted
// across the bottom of the bed - this part then clips onto that.

main();

include <Makerbeam.scad>;
include <Bearings.scad>;
include <Couplings.scad>;

brass = [181 / 255, 166 / 255, 66 / 255];

//color([77 / 255, 255 / 255, 21 / 255, 1])
//    cube([100, 100, 100]);

module main() {
    
    //Hot bed (arbitrary size)
    %translate([0, -75, 10]) cube([150, 150, 3]);
    
    //mounting beams
    color("grey") translate([30, -100, 0]) makerbeam_200();
    color("grey") translate([110, -100, 0]) makerbeam_200();
    
    //vertical rods (arbitrary length)
    translate([-10, 0, -200]) cylinder(d = 8, 400, $fn = 25);
    translate([160, 0, -200]) cylinder(d = 8, 400, $fn = 25);
    
    //linear bearings on rods
    translate([160, 0, -24]) LM8UU();
    translate([160, 0, -49]) LM8UU();
    
    //screw bearings on threaded rod
    color(brass) translate([-10, 0, 0]) TTypeLeadScrew();
    color(brass) translate([-10, 0, -45]) TTypeLeadScrew();
    
    //mounting part
    color([77 / 255, 255 / 255, 21 / 255, 1]) render() translate([0, -75, -3])
        mount();
}

module mount() {
    cube([150, 150, 3]);
}

main();
