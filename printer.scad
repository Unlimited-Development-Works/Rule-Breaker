use <Parts/XY2/Assembly.scad>;
use <Parts/Z-Axis.scad>;
use <Parts/ElectronicsBay.scad>;
use <Parts/Frame.scad>;

frame();
z_axis();
xy_axis(
    (sin($t * 360 + $t) * 0.5 + 0.5) * 120,
    (cos($t * 360) * 0.5 + 0.5) * 120
);
//electronics_bay();