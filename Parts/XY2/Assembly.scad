use <../../Libs/mistakes-were-made.scad>;

use <Frame.scad>;
use <OutsideAxis.scad>;
use <ToolCarriage.scad>;

function Toolhead_Range() = [126, 110];

module xy_axis(toolhead_x = 0, toolhead_y = 0) {

    //Check toolhead position is in valid range
    arg_out_of_range(toolhead_x < 0, "xy_axis", "toolhead_x", "Toolhead position is out of range")
    arg_out_of_range(toolhead_x > Toolhead_Range()[0], "xy_axis", "toolhead_x", "Toolhead position is out of range")
    arg_out_of_range(toolhead_y < 0, "xy_axis", "toolhead_y", "Toolhead position is out of range")
    arg_out_of_range(toolhead_y > Toolhead_Range()[1], "xy_axis", "toolhead_y", "Toolhead position is out of range")
    {
        th_x = toolhead_x + 20;
        th_y = toolhead_y + 45;

        translate([0, -210, 285]) {

            frame();

            translate([10, th_y, 20])
                rotate([0, 0, -90]) outer_axis();

            translate([th_x, 0, 0]) {
                outer_axis();
            }

            translate([th_x + 20, th_y, 0])
                carriage();
        }
    }
}

translate([0, 0, 0])
    xy_axis(50, 50);