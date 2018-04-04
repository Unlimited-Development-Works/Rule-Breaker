use <../../config.scad>;

use <../Brackets.scad>;

use <../../Libs/Makerbeam.scad>;
use <../../Libs/Bearings.scad>;
use <../../Libs/Couplings.scad>;
use <../../Libs/mistakes-were-made.scad>;

use <X-Axis.scad>;
use <Y-Axis.scad>;
use <Carriage.scad>;

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
        tx = toolhead_x + 58;
        ty = toolhead_y + 35;

        translate([0, -210, 290]) {

            translate([20, 0, 0])
                y_axis();

            translate([0, ty, 0]) {
                x_axis();
                
                translate([tx, 0, -39.5])
                    carriage();
            }
        }
    }
}

xy_axis(116, 0);