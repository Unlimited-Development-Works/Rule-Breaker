//Display helpers
function only_show_printable() = false;
function enabled_materials_filter() = [
    "PLA",
    "PETG",
    "Nylon"
];

//Bearings
function LM8UU_Pressure_Fit_Extra_Diameter() = 0.3;

//Smooth rods
function Rod_Pressure_Fit_Extra_Diameter() = 0.5;

//X Axis
function X_Axis_Rod_Separation() = 34;                          // Distance between rods
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
function X_Axis_Belt_Hole_Extra_Clearance() = 3;

//Y Axis
// -- No config

//Unified Axis
function U_Axis_Carriage_Screw_Guide_Diameter() = 10;
function U_Axis_Carriage_Screw_Hole_Diameter() = 3.7;

//Tool Carriage
function Carriage_Bearing_Separation() = 1;                     // Distance between bearings on the carriage (along rods)
function Carriage_Clamp_Reduce_Length() = 1;                    // How much shorter is the hotend clamp than the length of the carriage
function Carriage_Clamp_Hotend_Fix_Extra_Diameter() = 0.1;      // How much extra diameter to allow inside the hotend clamp
function Carriage_Concealed_Nut_Head_Depth() = 1.75;            // Depth of the hole for the bolt head/nut concealed beneath the carriage bearings
function Carriage_Half_Separation() = 0.35;
function Carriage_End_Rounded_Radius() = 2.5;

//Hotend retainer (part of carriage)
function Hotend_Retainer_Extra_Diameter() = 2.5;            // Diameter of the retaining ring around the hotend mounting point
function Hotend_Retainer_Pressfit_Extra_Diameter() = 0.15;  //Extra diameter to allow for the pressure fit of the hotend retainer