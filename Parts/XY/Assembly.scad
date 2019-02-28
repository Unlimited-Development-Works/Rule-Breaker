use <../../config.scad>;

use <../Brackets.scad>;

use <../../Libs/Makerbeam.scad>;
use <../../Libs/Bearings.scad>;
use <../../Libs/Couplings.scad>;
use <../../Libs/mistakes-were-made.scad>;
use <../../Libs/BeltUp/Core.scad>;
use <../../Libs/Wheels.scad>;

use <X-Axis.scad>;
use <Y-Axis.scad>;
use <Carriage.scad>;

//Define the belt and idlers
belt_spec = beltup_specify_belt(width = 6, thickness = 1, tooth_length = 1, tooth_separation = 1, tooth_height = 1, color = "red");
idler_spec = idler_beltup_spec();

module xy_axis(toolhead_x = 0, toolhead_y = 0) {

    //Define the belt and idlers
    belt_spec = beltup_specify_belt(width = 6, thickness = 1, tooth_length = 1, tooth_separation = 1, tooth_height = 1, color = "red");
    idler_spec = idler_beltup_spec(belt_spec);

    //Check toolhead position is in valid range
    arg_out_of_range(toolhead_x < 0, "xy_axis", "toolhead_x", "Toolhead position is out of range")
    arg_out_of_range(toolhead_x > 116, "xy_axis", "toolhead_x", "Toolhead position is out of range")
    arg_out_of_range(toolhead_y < 0, "xy_axis", "toolhead_y", "Toolhead position is out of range")
    arg_out_of_range(toolhead_y > 130, "xy_axis", "toolhead_y", "Toolhead position is out of range")
    {
        //The toolhead positions are passed in a range of 0->max
        //However the toolhead can't go to zero, offset by the minimum position
        tx = toolhead_x + 58;
        ty = toolhead_y + 35;

        translate([0, -210, 290]) {

            translate([20, 0, 0])
                y_axis();

            translate([0, ty, 0]) {
                x_axis(belt_spec, idler_spec);
                
                translate([tx, 0, -39.5])
                    carriage();
            }
        }

        //Create belt path
        
    }
}

translate([-100, 100, -260])
    xy_axis(50, 50);