use <../../Libs/e3d-scad/e3d-v6/e3d-v6.scad>;
use <../../Libs/Bearings.scad>;
use <../../materials.scad>;
use <../../config.scad>;

module carriage() {

    bearing_holder_x = LM8UU_Length() * 2;
    bearing_holder_y = LM8UU_Diameter() + 4;
    bearing_holder_z = LM8UU_Diameter() + 3.5;

    module screw_holder_offsets_root() {
        translate([0, 0, -bearing_holder_z/2]) {
            children();
        }
    }

    module screw_holder_offsets_inner(do = [1, 2, 3]) {
        screw_holder_offsets_root() {
            translate([0, bearing_holder_y/2+1, 0]) {

                if (search(1, do)) translate([+bearing_holder_x/2-10, 0, 0]) children();
                if (search(3, do)) translate([-bearing_holder_x/2+5, 0, 0]) children();
                if (search(2, do)) translate([-bearing_holder_x/2 + bearing_holder_y - 0.5 + 7.5, 0, 0]) children();
            }
        }
    }

    module screw_holder_offsets_outer() {
        screw_holder_offsets_root() {
            translate([0, -bearing_holder_y/2-1, 0]) {
                translate([+bearing_holder_x/2-10, 0, 0]) children();
                translate([-bearing_holder_x/2+5, 0, 0]) children();
            }
        }
    }

    module screw_holder_offsets() {
        screw_holder_offsets_inner() children();
        screw_holder_offsets_outer() children();
    }

    module basic_bearing_surround_positive() {

        intersection() {
            //Main block around bearings
            translate([0.25, 0, 0]) cube([bearing_holder_x, bearing_holder_y, bearing_holder_z], center = true);

            //Round it off
            translate([-LM8UU_Length() * 2, 0, 0]) rotate([0, 90, 0]) cylinder(d=LM8UU_Diameter() + 6, h=LM8UU_Length() * 4, $fn=75);    
        }

        //holders for screws
        screw_holder_offsets_outer() cylinder(d=6, h=bearing_holder_z, $fn=35);
        screw_holder_offsets_inner() cylinder(d=6, h=bearing_holder_z, $fn=35);
    }

    module basic_bearing_surround_negative(side_mount_holes) {
        //Hole through center for bearings
        translate([-LM8UU_Length() * 2, 0, 0]) rotate([0, 90, 0]) cylinder(d=LM8UU_Diameter() + LM8UU_Pressure_Fit_Extra_Diameter(), h=LM8UU_Length() * 4, $fn=55);

        //Holes for screws
        screw_holder_offsets()
            translate([0, 0, -bearing_holder_z]) cylinder(d=3, h=bearing_holder_z * 3, $fn=25);

        //Slice in half
        cube([100, 100, 0.25], center=true);

        if (side_mount_holes) {
            screw_holder_offsets_inner([2, 3])
                translate([0, 0, bearing_holder_z / 2]) cube([10, 10, 3], center=true);
        };
    }

    module top_carriage() {

        //Bearings
        translate([LM8UU_Length() + 0.5, 0, 0]) rotate([90, 0, 90]) LM8UU();
        rotate([90, 0, 90]) LM8UU();

        PETG() translate() {
            difference() {
                union() {
                    translate([LM8UU_Length(), 0, 0]) basic_bearing_surround_positive();
                }
                union() {
                    translate([LM8UU_Length(), 0, 0]) basic_bearing_surround_negative(side_mount_holes=false);
                }
            }
        }
    }

    module bot_carriage() {

        //Bearings
        translate([0, LM8UU_Length(), 0]) rotate([90, 0, 0]) LM8UU();
        translate([0, -0.5, 0]) rotate([90, 0, 0]) LM8UU();

        PETG() translate() {
            difference() {
                union() {
                    rotate([0, 0, -90]) basic_bearing_surround_positive();
                }
                union() {
                    rotate([0, 0, -90]) basic_bearing_surround_negative(side_mount_holes=true);
                }
            }
        }
    }

    translate([-4.5 - bearing_holder_y, -12, -5]) top_carriage();
    translate([-8, 12.5, -25]) bot_carriage();
    translate([20, 20, -80]) e3d_v6();
}

carriage();