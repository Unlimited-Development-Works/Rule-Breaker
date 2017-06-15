//Print helpers
function only_show_printable() = false;
module printed() {
    children();
}
module not_printed() {
    if (!only_show_printable())
        children();
}

//Bearings
function LM8UU_Pressure_Fit_Extra_Diameter() = 0.3;

//Smooth rods
function Rod_Pressure_Fit_Extra_Diameter() = 0.5;

//X Axis
function X_Axis_Rod_Separation() = 32;                          // Distance between rods
function X_Axis_Carriage_Rod_Vertical_Space() = 4;              // Distance between rods and the bearings they rest on
function X_Axis_Carriage_Mid_Bearing_Surround() = 3;            // Amount of plastic around the bearing (in the mid part of the carriage)
function X_Axis_Carriage_Rod_Surround_Extra_Diameter() = 12;    //Amount of plastic around the rods attaching them to the carriage
function X_Axis_Carriage_Screw_Guide_Diameter() = 10;
function X_Axis_Carriage_Screw_Hole_Diameter() = 3.7;
function X_Axis_Carriage_Screw_Hole_Z_Offset() = 2.5;
function X_Axis_Carriage_Bottom_Screw_Hole_Z_Offset() = -1;
function X_Axis_Carriage_Bottom_Screw_Hole_X_Offset() = 4;
function X_Axis_Carriage_Idler_Extra_Diameter() = 2;            //Extra space to put around the idlers
function X_Axis_Carriage_Idler_Extra_Height() = 1;              //Extra space to put above and below idlers
function X_Axis_Carriage_Idler_Vertical_Separation() = 0.5;     //Vertical space between the two idlers
function X_Axis_Carriage_Inner_Extra_Height() = 4;
function X_Axis_Belt_Hole_Thickness() = 3.5;

//Y Axis
