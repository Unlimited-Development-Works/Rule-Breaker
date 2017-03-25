/*
 * Paramtric library for belts and pulleys
 * Martin Evans - 2016
 */

use <mistakes-were-made.scad>;
use <geometry-2D.scad>;

beltup_demo();
module beltup_demo() {

    //Specify all the parts of the assembly
    belt = beltup_specify_belt(10, 2, 1, 1, 1);
    w07 = beltup_specify_wheel(7);
    w14 = beltup_specify_wheel(14);
    w21 = beltup_specify_wheel(21);

    //trivial 0 wheel system
    translate([0, 0, 0])
    beltup(belt, [
        beltup_cmd_goto([0, 0]),
        beltup_cmd_goto([30, 30]),
    ]);

    /* //trivial 1 wheel system
    translate([0, 0, 0])
    beltup(belt, [
        beltup_cmd_goto([0, 0]),
        beltup_cmd_wheel([30, 0], w07, teeth_in = true),
        beltup_cmd_goto([30, 30]),
    ]); */

    /* translate([100, 0, 0])
    //Complex 5 wheel concave system
    beltup(belt, [
        beltup_cmd_start_near([-100, -100]),
        beltup_cmd_wheel([0, 0], w07, teeth_in = true),
        beltup_cmd_wheel([70, 0], w07, teeth_in = true),
        beltup_cmd_wheel([90, 90], w14, teeth_in = true),
        beltup_cmd_wheel([40, 70], w07, teeth_in = false),
        beltup_cmd_wheel([0, 110], w21, teeth_in = true),
        beltup_cmd_close()
    ]);

    //Simple 2 wheel system (closed belt)
    translate([300, 0, 0])
    beltup(belt, [
        beltup_cmd_start_near([-100, -100]),
        beltup_cmd_wheel([0, 0], w07),
        beltup_cmd_wheel([70, 0], w14),
        beltup_cmd_close()
    ]);

    //Simple 2 wheel system (open belt)
    translate([300, 100, 0])
    beltup(belt, [
        beltup_cmd_goto([10, 50]),
        beltup_cmd_wheel([0, 0], w07),
        beltup_cmd_wheel([70, 0], w14),
        beltup_cmd_goto([70, 50])
    ]); */
}

/*
  Specify a new belt, this belt spec can be passed into other functions
   - width              - How wide is the belt
   - thickness          - How thick is the belt
   - tooth_length       - How far along the belt does a single tooth extend
   - tooth_separation   - How far between teeth
   - tooth_height       - How far from the belt does each tooth extend
*/
function beltup_specify_belt(width, thickness, tooth_length, tooth_separation, tooth_height) = [
    "belt",
    width,
    thickness,
    tooth_length,
    tooth_separation,
    tooth_height
];
function beltup_spec_belt_width(belt_spec) = belt_spec[1];
function beltup_spec_belt_thickness(belt_spec) = belt_spec[2];
function beltup_spec_belt_tooth_length(belt_spec) = belt_spec[3];
function beltup_spec_belt_tooth_separation(belt_spec) = belt_spec[4];
function beltup_spec_belt_tooth_height(belt_spec) = belt_spec[5];
function beltup_num_teeth(belt_spec, length) = ceil(length / (beltup_spec_belt_tooth_length(belt_spec) + beltup_spec_belt_tooth_separation(belt_spec)));

/*
  Specify a new wheel, this wheel can be passed into other functions
   - inner_radius           - What is the radius of the part of the wheel the belt wraps around
   - outer_radius           - What is the radius of the guides either side of the belt
   - outer_height_top       - What is the height of the guide above the belt
   - outer_height_bot       - What is the height of the guide below the belt
*/
function beltup_specify_wheel(inner_radius, outer_radius = 2, outer_height_top = 1, outer_height_bot = 1) = [
    "wheel",
    inner_radius,
    outer_radius,
    outer_height_top,
    outer_height_bot
];
function beltup_spec_wheel_inner_rad(wheel_spec) = wheel_spec[1];
function beltup_spec_wheel_outer_rad(wheel_spec) = wheel_spec[2];
function beltup_spec_wheel_outer_z_top(wheel_spec) = wheel_spec[3];
function beltup_spec_wheel_outer_z_bot(wheel_spec) = wheel_spec[4];

/*
  Specify a new position to put a wheel at
   - pos        - 2D location of the wheel
   - wheel      - A wheel specificication (see beltup_specify_wheel)
*/
function beltup_cmd_wheel(pos, wheel, teeth_in = true) = [
    "cmd_wheel_at",
    pos,
    wheel,
    teeth_in
];
function beltup_cmd_wheel_pos(at) = at[1];
function beltup_cmd_wheel_wheel(at) = at[2];
function beltup_cmd_wheel_teethin(at) = at[3];

function beltup_cmd_goto(pos) = [
    "cmd_goto",
    pos
];
function beltup_cmd_goto_pos(cmd) = cmd[1];

function beltup_cmd_start_near(pos) = [
    "cmd_start_near",
    pos
];
function beltup_cmd_start_near_pos(cmd) = cmd[1];

function beltup_cmd_close() = [
    "cmd_close"
];

function beltup_type(object) = object[0];

module beltup_straight_belt(belt_spec, length) {

    ty = beltup_spec_belt_tooth_length(belt_spec);
    tz = beltup_spec_belt_tooth_height(belt_spec);

    sy = beltup_spec_belt_tooth_separation(belt_spec);

    num_teeth = beltup_num_teeth(belt_spec, length);

    x = beltup_spec_belt_width(belt_spec);
    y = length;
    z = beltup_spec_belt_thickness(belt_spec);

    intersection() {

        cube([x, y, z + tz + 1]);

        union() {
            cube([x, y, z]);

            for(offset = [0 : num_teeth])
            translate([0, offset * (sy + ty), z])
                cube([x, ty, tz]);
        }
    }
}

module beltup(belt, commands, closed) {

    module beltup_curved_belt(belt_spec, curve_radius, angle, teeth = true) {

        bt = beltup_spec_belt_thickness(belt_spec);

        tz = beltup_spec_belt_width(belt_spec);
        ty = beltup_spec_belt_tooth_height(belt_spec);
        tx = beltup_spec_belt_tooth_length(belt_spec);

        sx = beltup_spec_belt_tooth_separation(belt_spec);

        arg_out_of_range(angle > 180, "beltup_curved_belt", "angle", "Must be &lt;= 180 degrees")
        arg_out_of_range(curve_radius < (bt + ty), "beltup_curved_belt", "curve_radius", "Must be &gt;= belt_thickness + tooth_height")
        {

            circumference = 2 * 3.14159 * curve_radius;
            num_teeth = beltup_num_teeth(belt_spec, (angle / 360) * circumference);

            difference() {

                //Render a 180 degree piece of belt
                union() {
                    difference() {
                        difference() {
                            cylinder(r = curve_radius + bt, h = tz);
                            translate([0, 0, -1]) cylinder(r = curve_radius, h = tz + 2);
                        }

                        translate([0, -(curve_radius + bt) - 1, -1])
                            cube([curve_radius + bt, (curve_radius + bt) * 2 + 2, beltup_spec_belt_width(belt_spec) + 2]);
                    }

                    if (teeth)
                    {
                        for (index = [0 : num_teeth - 1]) {
                            rotate([0, 0, ((sx + tx) * -(index + 0.5)) / (circumference / 360)]) translate([0, -curve_radius, 0])
                            cube([1, ty, tz]);
                        }
                    }
                }

                //Place a block to cut off this belt at the right angle
                translate([0, 0, -1]) rotate([0, 0, 180 - angle])
                cube([curve_radius * 2, curve_radius * 2, tz + 2]);
            }
        }
    }

    module beltup_cmd_wheel_wheel(belt_spec, wheel_spec) {

        bw = beltup_spec_belt_width(belt_spec);
        bt = beltup_spec_belt_thickness(belt_spec);

        ty = beltup_spec_belt_tooth_height(belt_spec);

        wir = beltup_spec_wheel_inner_rad(wheel_spec);
        wor = beltup_spec_wheel_outer_rad(wheel_spec);

        arg_out_of_range(wir < (bt + ty), "beltup_cmd_wheel_wheel", "belt_radius", "Must be &gt;= belt_thickness + tooth_height")
        {
            union()
            {
                cylinder(r = wir, h = bw, $fs = 0.1);
                translate([0, 0, -1]) cylinder(r = wir + wor, h = 1, $fs = 0.1);
                translate([0, 0, bw]) cylinder(r = wir + wor, h = 1, $fs = 0.1);
            }
        }
    }

    function wrap_index(i, count) = i % count;
    function wheel_triple(i, wheels) = [
        wheels[wrap_index(i + 0, len(wheels))],
        wheels[wrap_index(i + 1, len(wheels))],
        wheels[wrap_index(i + 2, len(wheels))]
    ];

    function normalize2d(v) = v / norm(v);

    module loop_iter(i, commands, current_position)
    {
        if (i < len(commands))
        {
            //Define the variables which hold the changed state to pass on to the next iteration
            //Initialize them with the current state
            new_position = current_position;
            
            cmd = commands[i];

            if (beltup_type(cmd) == "cmd_wheel_at")
            {
                pos2d = beltup_cmd_wheel_pos(cmd);
                translate([pos2d[0], pos2d[1], 0])
                    beltup_cmd_wheel_wheel(belt, beltup_cmd_wheel_wheel(cmd));

                loop_iter(i + 1, commands, beltup_cmd_goto_pos(cmd));
            }
            else if (beltup_type(cmd) == "cmd_goto")
            {
                if (current_position != "none")
                {
                    a = current_position;
                    b = beltup_cmd_goto_pos(cmd);

                    color("red") translate([a[0], a[1], 0]) cube([1, 1, 100], center = true);
                    color("red") translate([b[0], b[1], 0]) cube([1, 1, 100], center = true);

                    xpd = cross([0, 1, 0], extend2d_to_3d(normalize(b - a), 0));
                    normalized = normalize(b - a);
                    dot = dot2d([0, 1], normalize(b - a));

                    rotate([0, -90, acos(dot) * sign(xpd[2])])
                    beltup_straight_belt(belt, magnitude(b - a));
                    
                }

                loop_iter(i + 1, commands, beltup_cmd_goto_pos(cmd));
            }
            else if (beltup_type(cmd) == "cmd_start_near")
            {
                invalid_arg(i != 0, "beltup", "commands", "cmd_start_near may only appear as the first command");
            }
            else if (beltup_type(cmd) == "cmd_close")
            {
                invalid_arg(i != len(commands) - 1, "beltup", "commands", "cmd_close may only appear as the last command");
            }
        }
    }

    //Enter the "loop" using recursion to get actual scope/state
    loop_iter(0, commands, "none");
}

