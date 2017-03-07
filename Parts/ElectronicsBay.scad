use <Power-Supply.scad>;

module electronics_bay() {
    translate([10, -95 - 115, 0])
    union() {
        power_supply();
    }
}