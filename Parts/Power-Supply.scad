POWER_SUPPLY_LENGTH=150;
POWER_SUPPLY_WIDTH=85;
POWER_SUPPLY_HEIGHT=40;
POWER_SUPPLY_CABLE_SLACK=50;
module power_supply() {
    color("blue"){
		cube([POWER_SUPPLY_LENGTH, POWER_SUPPLY_WIDTH, POWER_SUPPLY_HEIGHT]);
	}
	power_supply_cable_slack();
}

module power_supply_cable_slack() {
	color("red"){
		translate([POWER_SUPPLY_LENGTH, 0, 0])
			cube([POWER_SUPPLY_CABLE_SLACK, POWER_SUPPLY_WIDTH, POWER_SUPPLY_HEIGHT]);
	}
}
power_supply();