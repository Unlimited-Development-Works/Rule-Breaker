use <../../Libs/e3d-scad/e3d-v6/e3d-v6.scad>;
use <../../Libs/Bearings.scad>;
use <../../Libs/Wheels.scad>;

use <../../config.scad>;
use <../../materials.scad>;

module carriage()
{
    not_printed() {
        rotate([0, -90, 0]) {
            //Bearings
            translate([0, -X_Axis_Rod_Separation() / 2, Carriage_Bearing_Separation() / 2]) LM8UU();
            translate([0, X_Axis_Rod_Separation() / 2, Carriage_Bearing_Separation() / 2]) LM8UU();
            translate([0, X_Axis_Rod_Separation() / 2, -LM8UU_Length() - Carriage_Bearing_Separation() / 2]) LM8UU();
            translate([0, -X_Axis_Rod_Separation() / 2, -LM8UU_Length() - Carriage_Bearing_Separation() / 2]) LM8UU();
        }

        //Hotend+Fan
        translate([0, 0, -56]) e3d_v6();
        rotate([0, 90, 0]) translate([25, 0, -LM8UU_Length() - 10]) fan30x30();
    }

    //Work out some helpful values
    carriage_length = LM8UU_Length() * 2 + Carriage_Bearing_Separation();
    mount_length = carriage_length - Carriage_Clamp_Reduce_Length();
    mount_height = LM8UU_Diameter() - 1;
    heatsink_mount_inner_dia = e3dv6_attachment_outer_diameter() + Hotend_Retainer_Extra_Diameter();

    module bearing_mount() {

        hole_length = Carriage_Bearing_Separation() + LM8UU_Length() * 2 + 10;
        bolt_head_hole_size = LM8UU_Diameter() + Carriage_Concealed_Nut_Head_Depth();

        module e3d_mounting_cutout() cylinder(d = e3dv6_attachment_outer_diameter() + Hotend_Retainer_Pressfit_Extra_Diameter(), h = 8, $fn=85);

        module bolt_hole() {
            rotate([90, 0, 0]) cylinder(d=3, h=X_Axis_Rod_Separation(), $fn=16, center=true);

            //bolt head/nut holes
            translate([0, LM8UU_Diameter() / 2 + X_Axis_Rod_Separation() / 2 - bolt_head_hole_size / 2, 0]) cube([5.5, bolt_head_hole_size, 5.5], center=true);
        }

        rounding_rad = Carriage_End_Rounded_Radius();
        module rounded_end(dir) {

            //Round parts
            translate([dir * (mount_length / 2 - rounding_rad), X_Axis_Rod_Separation() / 4 + Carriage_Half_Separation() / 2, 0])
            {
                rotate([90, 0, 0])
                {
                    translate([0, mount_height / 2 - rounding_rad, 0]) 
                        cylinder(h=X_Axis_Rod_Separation() / 2, r=rounding_rad, $fn=25, center=true);
                }

                //Flat end
                translate([0, 0, -rounding_rad / 2])
                    cube([rounding_rad * 2, X_Axis_Rod_Separation() / 2, mount_height - rounding_rad], center=true);
            }
        }

        module belt_attachment() {
            translate([10,10,mount_height/2+1.5]) {
                clip();

                translate([0, 0, idler_height() + X_Axis_Carriage_Idler_Vertical_Separation()])
                    clip();
            }

            module clip() {
                translate([0, 0, 2.5])
                cube([12, 2, idler_height()], center=true);
            }
        }

        union() {
            difference() {
                union() {
                    belt_attachment();

                    //main mount body
                    translate([0, X_Axis_Rod_Separation() / 4 + Carriage_Half_Separation() / 2, 0])
                        cube([mount_length - rounding_rad * 2, X_Axis_Rod_Separation() / 2, mount_height], center=true);

                    //Rounded ends
                    rounded_end(1);
                    rounded_end(-1);
                }
                union() {
                    //Shape to fit precisely around top of hotend
                    translate([0, 0, mount_height / 2 - 5.1]) e3d_mounting_cutout();
                    translate([0, 0, -mount_height / 2 -3.8]) e3d_mounting_cutout();
                    cylinder(d = e3dv6_attachment_inner_diameter() + Hotend_Retainer_Pressfit_Extra_Diameter(), h = 50, center=true, $fn=85);

                    //Hole to pressure fit bearings
                    rotate([0, 90, 0]) translate([0, X_Axis_Rod_Separation() / 2, 0])
                        cylinder(d = LM8UU_Diameter() + LM8UU_Pressure_Fit_Extra_Diameter(), h = hole_length, $fn = 50, center=true);

                    //bolt holes
                    translate([carriage_length / 2 - 4.5, 0, 0])  bolt_hole();
                    translate([-carriage_length / 2 + 4.5, 0, 0])  bolt_hole();
                }
            }
        }
    }

    PLA() bearing_mount();
    PLA() mirror([0, 1, 0]) bearing_mount();
}

carriage();