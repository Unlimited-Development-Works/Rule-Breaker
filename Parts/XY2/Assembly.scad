use <../../Libs/mistakes-were-made.scad>;

use <Frame.scad>;
use <OutsideAxis.scad>;
use <ToolCarriage.scad>;

module xy_axis(toolhead_x = 0, toolhead_y = 0) {

    //Check toolhead position is in valid range
    //arg_out_of_range(toolhead_x < 0, "xy_axis", "toolhead_x", "Toolhead position is out of range")
    //arg_out_of_range(toolhead_x > 116, "xy_axis", "toolhead_x", "Toolhead position is out of range")
    //arg_out_of_range(toolhead_y < 0, "xy_axis", "toolhead_y", "Toolhead position is out of range")
    //arg_out_of_range(toolhead_y > 130, "xy_axis", "toolhead_y", "Toolhead position is out of range")
    {
        toolhead_x = toolhead_x + 30;
        toolhead_y = toolhead_y + 45;

        translate([0, -210, 285]) {

            frame();

            translate([10, toolhead_y, 20])
                rotate([0, 0, -90]) outer_axis();

            translate([toolhead_x, 0, 0]) {
                outer_axis();
            }

            translate([toolhead_x + 20, toolhead_y, 0])
                carriage();
        }
    }
}

translate([0, 0, 0])
    xy_axis(0, 0);