//Size based on the anycubic GT2 idler
module idler() {
    difference() {
        union() {
            cylinder(d = 12.2, h = 8.57);
            cylinder(d = 17.89, h = 1);

            translate([0, 0, 7.57])
                cylinder(d = 17.89, h = 1);
        }

        translate([0, 0, -5])
            cylinder(d = 4.95, h = 20, $fn = 13);
    }
}

idler();