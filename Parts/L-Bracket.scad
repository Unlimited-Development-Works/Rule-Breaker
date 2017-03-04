module bolt_hole_3m() {
    cylinder(h = 10, d = 3, $fn = 15);
}

module l_bracket() {
    color("silver")
    difference() {
        cube([20, 30, 1.5]);
        
        union() {
            translate([-1, -1, -1]) cube([11, 21, 3.5]);
            translate([5, 25, -5]) bolt_hole_3m();
            translate([15, 25, -5]) bolt_hole_3m();
            translate([15, 15, -5]) bolt_hole_3m();
            translate([15, 5, -5]) bolt_hole_3m();
        }
    }
}
l_bracket();