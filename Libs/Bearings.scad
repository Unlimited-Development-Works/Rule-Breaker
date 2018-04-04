use <../materials.scad>

//24mm long x 15mm outer diameter x 8mm inner diameter
//2 grooves with 14.5mm outer diameter
//Grooves vary in width between 1mm and 1.25mm

function LM8UU_Length() = 24;
function LM8UU_Diameter() = 15;

module LM8UU() {
    not_printed() difference() {
        cylinder(d = LM8UU_Diameter(), LM8UU_Length(), $fn = 75);
        union() {
            translate([0, 0, -12]) cylinder(d = 8, 48, $fn = 35);
            difference() {
                translate([0, 0, 3.25]) cylinder(d = 20, 17.5);
                union() {
                    cylinder(d = 14, 24, $fn = 45);
                    translate([0, 0, (17.5 - 15.1) / 2 + 3.25]) cylinder(d = 48, 15.1);
                }
            }
        }
    }
}
LM8UU();
