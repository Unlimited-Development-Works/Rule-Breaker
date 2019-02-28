//Size based on the anycubic GT2 idler

function idler_outer_diameter() = 17.89;
function idler_inner_diameter() = 12.20;
function idler_hole_diameter() = 4.95;
function idler_height() = 8.57;

use <BeltUp/Core.scad>;
function idler_beltup_spec(belt_spec) = beltup_specify_wheel(
    inner_radius = idler_inner_diameter() / 2,
    outer_radius = (idler_outer_diameter() - idler_inner_diameter()) / 2,
    outer_height_top = (idler_height() - beltup_spec_belt_width(belt_spec)) / 2,
    outer_height_bot = (idler_height() - beltup_spec_belt_width(belt_spec)) / 2,
    hole_radius = idler_hole_diameter() / 2
);

module idler() {

    difference() {
        union() {
            cylinder(d = idler_inner_diameter(), h = idler_height());
            cylinder(d = idler_outer_diameter(), h = 1);

            translate([0, 0, idler_height() - 1])
                cylinder(d = idler_outer_diameter(), h = 1);
        }

        translate([0, 0, -idler_height()])
            cylinder(d = idler_hole_diameter(), h = idler_height() * 3, $fn = 13);
    }
}

idler();

