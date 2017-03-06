// This bed mounting assumes a certain setup of heated bed. Since we don't want a printed
// plastic part in direct contact with a heated bed there should be two metal bars mounted
// across the bottom of the bed - this part then clips onto that.

//main();

include <Makerbeam.scad>;
include <Bearings.scad>;
include <Couplings.scad>;

brass = [181 / 255, 166 / 255, 66 / 255];

main();
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
    translate([160, 0, -15]) LM8UU();
    translate([160, 0, -49]) LM8UU();
    
    //screw bearings on threaded rod
    color(brass) translate([-10, 0, -5]) TTypeLeadScrew();
    color(brass) translate([-10, 0, -45]) TTypeLeadScrew();
    
    //mounting part
    color([77 / 255, 255 / 255, 21 / 255, 1]) render() translate([0, -75, -3])
        mount();
}

module LM8UU_Clamp() {
    
    screw_diameter = 2;
    bolt_diameter = 4;
    bolt_depth = 1;
    
    module hole_half() {
        
        //Bolt holes
        translate([-10 + 3.5 + bolt_diameter / 2, LM8UU_Diameter / 2, 3.5 - bolt_diameter / 2])
            cube([10, bolt_depth + 0.5, bolt_diameter]);
        translate([-10 + 3.5 + bolt_diameter / 2, LM8UU_Diameter / 2, LM8UU_Height - 3.5 - bolt_diameter / 2])
            cube([10, bolt_depth + 0.5, bolt_diameter]);
        
        //Screw holes
        translate([3.5, 50, LM8UU_Height - 3.5]) rotate([90, 0, 0])
            cylinder(d = screw_diameter, 100, $fn = 13);
        translate([3.5, 50, 3.5]) rotate([90, 0, 0])
            cylinder(d = screw_diameter, 100, $fn = 13);
    }
    
    difference() {
        union() {
            cube([LM8UU_Diameter + 14, LM8UU_Diameter * 0.75, LM8UU_Height]);
            
            translate([LM8UU_Diameter + 10.5, 0, LM8UU_Height / 3]) sphere(d = screw_diameter, $fn = 20);
            translate([LM8UU_Diameter + 10.5, 0, LM8UU_Height / 3 * 2]) sphere(d = screw_diameter, $fn = 20);
        }
        union() {

            //Cut out the profile of an LM8UU bearing
            translate([LM8UU_Diameter / 2 + 7, 0, 0])
                cylinder(d = LM8UU_Diameter, LM8UU_Height * 2, $fn = 35);

            //Cut out the holes (screws + bolts)
            hole_half();
            translate([(LM8UU_Diameter + 14) / 2, 0, 0])
            mirror() {
                translate([-(LM8UU_Diameter + 14) / 2, 0, 0])
                    hole_half();
            }
            
            //Cut out the two guide sphere holes
            translate([3.5, 0, LM8UU_Height / 3]) sphere(d = screw_diameter, $fn = 20);
            translate([3.5, 0, LM8UU_Height / 3 * 2]) sphere(d = screw_diameter, $fn = 20);
        }
    }
}

module mount() {
    cube([150, 150, 3]);
    
    translate([150, 75 - (LM8UU_Diameter + 14) / 2, 30]) rotate([0, 0, 90]) render() LM8UU_Clamp();
}

main();
