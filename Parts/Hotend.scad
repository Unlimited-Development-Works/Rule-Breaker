// e3d v6 hotend modelled from these specifications: https://wiki.e3d-online.com/wiki/E3D-v6_Documentation#Engineering_Drawings
module e3d_v6() {

    module heatsink() {

        difference() {
            union() {
                //Fins
                for (i = [0 : 1 : 10]) translate([0, 0, i * 2.5]) cylinder(d=22, h=1);
                translate([0, 0, 27.5]) cylinder(d=16, h=1);

                //Top assembly
                translate([0, 0, 30]) cylinder(d=16, h=3);
                translate([0, 0, 33]) cylinder(d=12, h=6);
                translate([0, 0, 39]) cylinder(d=16, h=3.7);

                //Inner cylinder
                cylinder(d1=16, d2=4.2, h=42);
            }

            //Cut out plastic channel
            translate([0, 0, -21]) cylinder(d=4.2, h=84, $fn=11);
        }
    }

    module nozzle() {
        cylinder(d1=0.63, d2=2.6, h=2, $fn=6);
        translate([0, 0, 2]) cylinder(d=10, h=3, $fn=7);
    }

    module block() {
        cube([23, 16, 11.5], center = true);
    }

    translate([3.5, 0, 0]) nozzle();
    translate([0, 0, 10.75]) block();
    translate([3.5, 0, 19.6]) heatsink();

    //Connect together top and bottom parts
    translate([3.5, 0, 15]) cylinder(d=4.2, h=5, $fn=11);
}

e3d_v6();