module makerbeam_300() {
    makerbeam([10, 300, 10]);
}

module makerbeam_200() {
    makerbeam([10, 200, 10]);
}

module makerbeam_150() {
    makerbeam([10, 150, 10]);
}

module makerbeam_100() {
    makerbeam([10, 100, 10]);
}

module makerbeam_60() {
    makerbeam([10, 60, 10]);
}

module makerbeam_40() {
    makerbeam([10, 40, 10]);
}

module makerbeam(size) {
    
    x = size[0];
    y = size[1];
    z = size[2];
    color("DimGray") {
        translate([0, 0, 0])
            cube([x / 3, y, z / 3]);

        translate([x * 2/3, 0, 0])
            cube([x / 3, y, z / 3]);

        translate([x * 2/3, 0, z * 2/3])
            cube([x / 3, y, z / 3]);

        translate([0, 0, z * 2/3])
            cube([x / 3, y, z / 3]);

        translate([x / 4, 0, z / 4])
            cube([x / 2, y, z / 2]);
    }
}

// demo();
module demo() {
    makerbeam_300();

    translate([30, 0, 0])
        makerbeam_200();

    translate([60, 0, 0])
        makerbeam_150();

    translate([90, 0, 0])
        makerbeam_100();

    translate([120, 0, 0])
        makerbeam_60();

    translate([150, 0, 0])
        makerbeam_40();
}