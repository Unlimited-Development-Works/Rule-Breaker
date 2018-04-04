use <../materials.scad>;

//https://www.aliexpress.com/store/product/1pcs-K547-Aluminum-Motor-Shaft-Connector-Elastic-Flexible-Coupling-Coupler-20-Styles-Shaft-to-Shaft-D19L25/1853599_32647323572.html
//Out diameter: 19mm
//Length: 25mm
module K547() {
    metal() difference() {
        cylinder(d = 19, 25, $fn = 50);
        
        union() {
            translate([0, 0, -10]) cylinder(d = 8, 50, $fn = 18);
            translate([0, 50, 3]) rotate([90, 0, 0]) cylinder(d=3, 100, $fn = 20);
            translate([-50, 0, 3]) rotate([90, 0, 90]) cylinder(d=3, 100, $fn = 20);
            translate([0, 50, 22]) rotate([90, 0, 0]) cylinder(d=3, 100, $fn = 20);
            translate([-50, 0, 22]) rotate([90, 0, 90]) cylinder(d=3, 100, $fn = 20);
        }
    }
}

//https://www.aliexpress.com/item/32620282507/32620282507.html?shortkey=umMvimQR&addresstype=600
//Lead Screw Diameter: 8mm
//Pitch: 2mm
//Lead: 8mm
module TTypeLeadScrew() {
    
    module hole() {
        cylinder(d = 3.5, 20, $fn = 13);
    }

    brass() difference() {
        union() {
            cylinder(d = 9, 15, $fn = 25);
            translate([0, 0, 10]) cylinder(d = 22, 3.5, $fn = 45);
        }
        union() {
            translate([0, 0, -50]) cylinder(d = 8, 100);
            translate([8, 0, 0]) hole();
            translate([-8, 0, 0]) hole();
            translate([0, 8, 0]) hole();
            translate([0, -8, 0]) hole();
        }
    }
}
