use <Hotend.scad>;
use <Bearings.scad>;

use <../config.scad>;

module toolhead()
{
    translate([12, -4, 2]) rotate([0, -90, 0]) {
        LM8UU();
        translate([0, X_Axis_Rod_Separation(), 0]) LM8UU();
    }

    translate([0, 12, -50]) rotate([0, 0, 0]) e3d_v6();
}