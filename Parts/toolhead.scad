use <Hotend.scad>;
use <Bearings.scad>;

use <../config.scad>;

module toolhead()
{
    translate([12, 30, -8]) rotate([-90, 0, 90]) LM8UU();
    translate([12, 30, -8 - X_Axis_Rod_Vertical_Separation()]) rotate([-90, 0, 90]) LM8UU();
    translate([0, 10, -50]) rotate([0, 0, 0]) e3d_v6();
}