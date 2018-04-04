module fan40x40() {
    translate([-20, -20, 0])
    union() {
        difference() {
            union() {
                translate([4, 4, 0])   cylinder(r = 4, h = 10);
                translate([36, 4, 0])  cylinder(r = 4, h = 10);
                translate([4, 36, 0])  cylinder(r = 4, h = 10);
                translate([36, 36, 0]) cylinder(r = 4, h = 10);
                translate([4, 0, 0]) cube([32, 40, 10]);
                translate([0, 4, 0]) cube([40, 32, 10]);
            };
            union() {
                translate([4, 4, -2])   cylinder(d = 4.2, h = 20, $fn=10);
                translate([36, 4, -2])  cylinder(d = 4.2, h = 20, $fn=10);
                translate([4, 36, -2])  cylinder(d = 4.2, h = 20, $fn=10);
                translate([36, 36, -2]) cylinder(d = 4.2, h = 20, $fn=10);
                translate([20, 20, -2]) cylinder(d = 39, h = 20, $fn=20);
            };
        }
        translate([20, 20, 0]) cylinder(d=15, h=10, $fn=15);

        translate([20, 20, 9.5]) cube([2, 40, 1], center=true);
        translate([20, 20, 9.5]) cube([40, 2, 1], center=true);
    }
}

fan40x40();