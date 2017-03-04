module makerbeam_300() {
    makerbeam(300);
}

module makerbeam_200() {
    makerbeam(200);
}

module makerbeam_150() {
    makerbeam(150);
}

module makerbeam_100() {
    makerbeam(100);
}

module makerbeam_60() {
    makerbeam(60);
}

module makerbeam_40() {
    makerbeam(40);
}

module makerbeam(length) {
    x = 10;
    y = length;
    z = 10;
    gap = 3;
    corner = (x - gap) / 2;
    color("DimGray") {
        translate([0, 0, 0])
            cube([corner, y, corner]);

        translate([corner + gap, 0, 0])
            cube([corner, y, corner]);

        translate([0, 0, corner + gap])
            cube([corner, y, corner]);

        translate([corner + gap, 0, corner + gap])
            cube([corner, y, corner]);

        translate([3, 0, 3])
            cube([4, y, 4]);
    }
}

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

demo();