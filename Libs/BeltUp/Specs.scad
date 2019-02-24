/* Specify a new belt, this belt spec can be passed into other functions
   - width              - How wide is the belt
   - thickness          - How thick is the belt
   - tooth_length       - How far along the belt does a single tooth extend
   - tooth_separation   - How far between teeth
   - tooth_height       - How far from the belt does each tooth extend
*/
function beltup_specify_belt(width, thickness, tooth_length, tooth_separation, tooth_height, color) = [
    "belt",
    width,
    thickness,
    tooth_length,
    tooth_separation,
    tooth_height,
    color
];
function beltup_spec_belt_width(belt_spec) = belt_spec[1];
function beltup_spec_belt_thickness(belt_spec) = belt_spec[2];
function beltup_spec_belt_tooth_length(belt_spec) = belt_spec[3];
function beltup_spec_belt_tooth_separation(belt_spec) = belt_spec[4];
function beltup_spec_belt_tooth_height(belt_spec) = belt_spec[5];
function beltup_spec_belt_color(belt_spec) = belt_spec[6];
function beltup_num_teeth(belt_spec, length) = ceil(length / (beltup_spec_belt_tooth_length(belt_spec) + beltup_spec_belt_tooth_separation(belt_spec)));

/* Specify a new wheel, this wheel can be passed into other functions
   - inner_radius           - What is the radius of the part of the wheel the belt wraps around
   - outer_radius           - What is the radius of the guides either side of the belt
   - outer_height_top       - What is the height of the guide above the belt
   - outer_height_bot       - What is the height of the guide below the belt
*/
function beltup_specify_wheel(inner_radius, outer_radius = 2, outer_height_top = 1, outer_height_bot = 1, hole_radius = 0) = [
    "wheel",
    inner_radius,
    outer_radius,
    outer_height_top,
    outer_height_bot,
    hole_radius
];
function beltup_spec_wheel_inner_rad(wheel_spec) = wheel_spec[1];
function beltup_spec_wheel_outer_rad(wheel_spec) = wheel_spec[2];
function beltup_spec_wheel_outer_z_top(wheel_spec) = wheel_spec[3];
function beltup_spec_wheel_outer_z_bot(wheel_spec) = wheel_spec[4];
function beltup_spec_wheel_hole_radius(wheel_spec) = wheel_spec[5];

/* Specify a new instance of a wheel spec
*/
function beltup_create_wheel(belt_spec, wheel_spec, position, teeth_in) = [
  "wheel_instance",
  wheel_spec,
  belt_spec,
  position,
  teeth_in
];
function beltup_spec_wheel_instance_spec(wheel_instance) = wheel_instance[1];
function beltup_spec_wheel_instance_belt(wheel_instance) = wheel_instance[2];
function beltup_spec_wheel_instance_pos(wheel_instance) = wheel_instance[3];
function beltup_spec_wheel_instance_teethin(wheel_instance) = wheel_instance[4];
function beltup_spec_wheel_instance_as_circle(wheel_instance) = circ(
  wheel_instance[3],
  beltup_spec_wheel_inner_rad(wheel_instance[1]) + (wheel_instance[4] ? beltup_spec_belt_thickness(wheel_instance[2]) : 0)
);

function beltup_type(object) = object[0];