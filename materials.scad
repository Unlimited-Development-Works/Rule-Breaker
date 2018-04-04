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

module brass() {
    not_printed() jitter_color([181 / 255, 166 / 255, 66 / 255]) children();
}

module PLA() {
    printed("PLA") color(color("cornflowerblue")) children();
}

module PETG() {
    printed("PETG") jitter_color([57 / 255, 255 / 255, 11 / 255, 1]) children();
}

module nylon() {
    printed("Nylon") jitter_color(color("grey")) children();
}