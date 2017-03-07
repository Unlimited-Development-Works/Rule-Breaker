use <Power-Supply.scad>;
use <Control-Board.scad>;

module electronics_bay() {
    translate([10, -95 - 115, 0])
    union() {
        power_supply();
		translate([90, 85, 0])
			control_board();
    }
}