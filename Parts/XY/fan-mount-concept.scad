module fan_mount() {
    module back() {
        difference() {
            union() {
                translate([0, 0, e3dv6_heatsink_height() / 2 - 2]) cylinder(d = e3dv6_heatsink_diameter() + 4, h = 4);

                //Bolt holders
                rotate([0, 90, 0]) {
                    translate([-e3dv6_heatsink_height() / 2, e3dv6_heatsink_diameter() / 2 + 3, 0])
                        cylinder(d=7, h=e3dv6_heatsink_diameter()/3, $fn=11);
                    translate([-e3dv6_heatsink_height() / 2, -e3dv6_heatsink_diameter() / 2 - 3, 0])
                        cylinder(d=7, h=e3dv6_heatsink_diameter()/3, $fn=11);
                }
            }
            union() {
                //Heatsink body
                translate([0, 0, -1]) cylinder(d = e3dv6_heatsink_diameter() + 0.1, h = e3dv6_heatsink_height() + 2);

                //Bolt holes
                rotate([0, 90, 0]) {
                    translate([-e3dv6_heatsink_height() / 2, e3dv6_heatsink_diameter() / 2 + 3, -50])
                        cylinder(d=3, h=100, $fn=11);
                    translate([-e3dv6_heatsink_height() / 2, -e3dv6_heatsink_diameter() / 2 - 3, -50])
                        cylinder(d=3, h=100, $fn=11);
                }

                //Half of the body
                translate([-e3dv6_heatsink_diameter(), -50, -50]) cube([e3dv6_heatsink_diameter(), 100, 100]);
            }
        }
    }

    module front() {

    }

    front();
    back();
}