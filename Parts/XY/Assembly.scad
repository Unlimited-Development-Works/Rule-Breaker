use <../../config.scad>;

use <../Makerbeam.scad>;
use <../Brackets.scad>;
use <../Couplings.scad>;
use <../Bearings.scad>;
use <../Color.scad>;
use <../Toolhead.scad>;

use <../../Libs/mistakes-were-made.scad>;

use <X-Axis.scad>;
use <Y-Axis.scad>;

module xy_axis(toolhead_x = 0, toolhead_y = 0) {

    //Check toolhead position is in valid range
    arg_out_of_range(toolhead_x < 0, "xy_axis", "toolhead_x", "Toolhead position is out of range")
    arg_out_of_range(toolhead_x > 116, "xy_axis", "toolhead_x", "Toolhead position is out of range")
    arg_out_of_range(toolhead_y < 0, "xy_axis", "toolhead_y", "Toolhead position is out of range")
    arg_out_of_range(toolhead_y > 130, "xy_axis", "toolhead_y", "Toolhead position is out of range")
    {
        //The toolhead positions are passed in a range of 0->max
        //However the toolhead can't go to zero in reality, offset by the
        //minimum position
        tx = toolhead_x + 0;
        ty = toolhead_y + 0;

        translate([0, -210, 290]) {

            translate([20, 0, 0])
                y_axis();

            translate([0, ty, 0]) {

                x_axis();
                
                translate([tx, 0, 0])
                    toolhead();
            }
        }
    }
}

xy_axis(116, 0);