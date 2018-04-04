use <config.scad>;

module printed(material) {

    module if_enabled_material(enabled_materials, query, index) {
        if (enabled_materials[index] == query) {
            children();
        } else {
            if (index < len(enabled_materials)) {
                if_enabled_material(enabled_materials, query, index + 1) children();
            }
        }
    }

    if_enabled_material(enabled_materials_filter(), material, 0)
        children();
}
module not_printed() {
    if (!only_show_printable())
        children();
}

module metal(color = "silver") {
    not_printed() color(color) children();
}

module jitter_color(c) {
    amount = 0.065;
    d = [
        min(1, max(0, c[0] + rands(-amount,amount,1)[0])),
        min(1, max(0, c[1] + rands(-amount,amount,1)[0])),
        min(1, max(0, c[2] + rands(-amount,amount,1)[0]))
    ];
    color(d) children();
}

function rc(mid) = max(0, min(255, rands(mid - 25, mid + 25, 1)[0])) / 255;

module brass() {
    not_printed() jitter_color([rc(181), rc(166), 66 / 255]) children();
}

module PLA() {
    printed("PLA") color([rc(100), rc(149), 237 / 255]) children();
}

module PETG() {
    printed("PETG") jitter_color([rc(57), rc(255), rc(11)]) children();
}

module nylon() {
    printed("Nylon") jitter_color(color("grey")) children();
}