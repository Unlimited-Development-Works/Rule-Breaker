module bolt_hole_3m() {
    cylinder(h = 1.5, d = 3, $fn = 20);
}

module l_bracket() {
    difference() {
        cube([20, 30, 1.5]);
        cube([10, 20, 1.5]);
        translate([5, 25, 0])
            bolt_hole_3m();
        translate([15, 25, 0])
            bolt_hole_3m();
        translate([15, 15, 0])
            bolt_hole_3m();
        translate([15, 5, 0])
            bolt_hole_3m();
    }
}