use <Parts/XY2/Assembly.scad>;
use <Parts/Z-Axis.scad>;
use <Parts/ElectronicsBay.scad>;
use <Parts/Frame.scad>;

range = Toolhead_Range();

frame();
z_axis();
xy_axis(
    (sin($t * 360 + $t * 1.1) * 0.5 + 0.5) * range[0],
    (cos($t * 360) * 0.5 + 0.5) * range[1]
);
//electronics_bay();