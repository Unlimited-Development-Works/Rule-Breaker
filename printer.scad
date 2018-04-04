use <Parts/XY/Assembly.scad>;
use <Parts/Z-Axis.scad>;
use <Parts/ElectronicsBay.scad>;
use <Parts/Frame.scad>;

frame();
z_axis();
xy_axis(
    104, //(sin($t * 360 + $t) * 0.5 + 0.5) * 104,
    130 //(cos($t * 360) * 0.5 + 0.5) * 130
);
//electronics_bay();