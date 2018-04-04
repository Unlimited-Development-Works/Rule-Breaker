use <../materials.scad>;

module bracket_bolt_hole_3m() {
        cylinder(h = 10, d = 3.2, $fn = 18);
    }

module l_bracket() {
    metal() difference() {
        cube([20, 30, 1.5]);
        
        union() {
            translate([-1, -1, -1]) cube([11, 21, 3.5]);
            translate([5, 25, -5]) bracket_bolt_hole_3m();
            translate([15, 25, -5]) bracket_bolt_hole_3m();
            translate([15, 15, -5]) bracket_bolt_hole_3m();
            translate([15, 5, -5]) bracket_bolt_hole_3m();
        }
    }
}

module l_bracket_inner() {
    metal() difference() {
        union() {
            cube([1.5, 30, 10]);
            cube([30, 1.5, 10]);
        }

        union() {
            translate([-5, 10, 5]) rotate([0, 90, 0]) bracket_bolt_hole_3m();
            translate([-5, 22, 5]) rotate([0, 90, 0]) bracket_bolt_hole_3m();

            translate([7, 5, 5]) rotate([90, 0 , 0]) bracket_bolt_hole_3m();
            translate([16, 5, 5]) rotate([90, 0, 0]) bracket_bolt_hole_3m();
            translate([25, 5, 5]) rotate([90, 0, 0]) bracket_bolt_hole_3m();
        }
    }
}

l_bracket();
translate([50, 0, 0]) l_bracket_inner();