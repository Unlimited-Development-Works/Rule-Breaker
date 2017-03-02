module makerbeam_300() {
    makerbeam([10, 300, 10]);
}

module makerbeam_200() {
    makerbeam([10, 200, 10]);
}

module makerbeam(size) {
    
    x = size[0];
    y = size[1];
    z = size[2];
    
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

//render() demo();
module demo() {
    makerbeam_300();
    
    translate([30, 0, 0])
        makerbeam_200();
}