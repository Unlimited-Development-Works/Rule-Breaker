/*
 * Paramtric library for belts and pulleys
 * Martin Evans - 2016
 */

use <mistakes-were-made.scad>;
use <geometry-2D.scad>;

beltup_demo();
module beltup_demo() {

    //Specify all the parts of the assembly
    belt = beltup_specify_belt(6, 1, 1, 1, 1);
    w07 = beltup_specify_wheel(7, hole_radius = 6);
    w14 = beltup_specify_wheel(14, hole_radius = 10);
    w21 = beltup_specify_wheel(21, hole_radius = 15);

    //trivial 0 wheel system
    translate([3, 0, 0])
        beltup_render_straight_belt(belt, [-10, 10], [10, -20], flip = false);
    translate([-3, 0, 0])
        beltup_render_straight_belt(belt, [-10, 10], [10, -20], flip = true);

    //trivial 1 wheel system (no belt)
    translate([0, 50, 0])
        beltup_render_wheel(belt, w14);

    //trivial 1 wheel system
    translate([50, 0, 0])
    {
        a = [-10, 0];
        w = [20, 70];
        b = [5, 30];

        aw = beltup_wheel_tangent_in(belt, a, w14, w, false, true);
        wb = beltup_wheel_tangent_out(belt, w14, w, b, true, true);

        beltup_render_belt_tangent(belt, aw);
        translate(w) beltup_render_wheel(belt, w14);
        //beltup_render_curve_between_tangents(belt, a, false, w14, w, b, true, true);
        beltup_render_belt_tangent(belt, wb);
    }
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

function beltup_type(object) = object[0];

module beltup_render_wheel(belt_spec, wheel_spec) {

    bw = beltup_spec_belt_width(belt_spec);
    bt = beltup_spec_belt_thickness(belt_spec);

    ty = beltup_spec_belt_tooth_height(belt_spec);

    wir = beltup_spec_wheel_inner_rad(wheel_spec);
    wor = beltup_spec_wheel_outer_rad(wheel_spec);

    arg_out_of_range(wir < (bt + ty), "beltup_cmd_wheel_wheel", "belt_radius", "Must be &gt;= belt_thickness + tooth_height")
    {
        difference() {
            union()
            {
                translate([0, 0, -1]) cylinder(r = wir, h = bw + 2, $fn = 100);
                translate([0, 0, -2]) cylinder(r = wir + wor, h = 1, $fn = 23);
                translate([0, 0, bw + 1]) cylinder(r = wir + wor, h = 1, $fn = 23);
            }

            translate([0, 0, -bw])
                cylinder(r = beltup_spec_wheel_hole_radius(wheel_spec), h = bw * 3, $fs = 0.1);
        }
    }
}

module beltup_render_straight_belt(belt_spec, a, b, flip = false) {
    
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

    xpd = cross([0, 1, 0], extend2d_to_3d(normalize(b - a), 0));
    normalized = normalize(b - a);
    dot = dot2d([0, 1], normalize(b - a));
    zangle = acos(dot) * sign(xpd[2]) + (flip ? 180 : 0);

    translate(flip ? b : a)
    rotate([0, -90, zangle])
        beltup_straight_belt(belt_spec, magnitude(b - a));
}

//Calculate the tangent data from a point to a wheel
function beltup_wheel_tangent_in(belt_spec, point, wheel_spec, wheel_pos, side, teeth_in = true) = let(

    //Generate both tangents from current point to next belt.
    tangents = circle_tangents_through_point(point, circ(wheel_pos, beltup_spec_wheel_inner_rad(wheel_spec) + beltup_spec_belt_thickness(belt_spec))),

    //Choose which side to go to
    tangent = side ? tangents[0] : tangents[1],

    //Determine if we need to flip the belt
    is_left = is_point_left_of_ray(tangent, wheel_pos),
    flip = !is_left && teeth_in,

    end_pos = point_along_ray(tangent, 1)
) [
    point,
    end_pos,
    flip,
];

function beltup_wheel_tangent_out(belt_spec, wheel_spec, wheel_pos, point, side, teeth_in = true) = let(
    in = beltup_wheel_tangent_in(belt_spec, point, wheel_spec, wheel_pos, side, teeth_in)
) [in[1], in[0], !in[2]];

module beltup_render_belt_tangent(belt_spec, params) {
    beltup_render_straight_belt(belt_spec, params[0], params[1], flip = params[2]);
}

module beltup_render_point_to_wheel_belt(belt_spec, point, wheel, wheel_pos, side, teeth_in = true) {

    //Generate both tangents from current point to next belt.
    tangents = circle_tangents_through_point(point, circ(wheel_pos, beltup_spec_wheel_inner_rad(wheel) + beltup_spec_belt_thickness(belt_spec)));

    //Choose which side to go to
    tangent = side ? tangents[0] : tangents[1];

    //Determine if we need to flip the belt
    is_left = is_point_left_of_ray(tangent, wheel_pos);
    flip = !is_left && teeth_in;

    //Place straight belt from previous point to point on wheel
    next_pos = point_along_ray(tangent, 1);
    beltup_render_straight_belt(belt_spec, point, next_pos, flip = flip);

}

module beltup_render_curve_between_tangents(belt_spec, start_point, start_side, wheel_spec, wheel_pos, end_point, end_side, teeth_in) {

    //Render a curved section of belt < 180 degrees
    module beltup_curved_belt(belt_spec, curve_radius, angle, teeth = false) {

        bt = beltup_spec_belt_thickness(belt_spec);

        tz = beltup_spec_belt_width(belt_spec);
        ty = beltup_spec_belt_tooth_height(belt_spec);
        tx = beltup_spec_belt_tooth_length(belt_spec);

        sx = beltup_spec_belt_tooth_separation(belt_spec);

        arg_out_of_range(angle > 180, "beltup_curved_belt", "angle", "Must be &lt;= 180 degrees")
        arg_out_of_range(curve_radius < (bt + ty), "beltup_curved_belt", "curve_radius", "Must be &gt;= belt_thickness + tooth_height")
        {

            circumference = 2 * 3.14159 * curve_radius;
            num_teeth = beltup_num_teeth(belt_spec, circumference / 2);

            difference() {

                //Render a 180 degree piece of belt
                difference() {
                    union() {
                        difference() {
                            cylinder(r = curve_radius + bt, h = tz);
                            translate([0, 0, -1]) cylinder(r = curve_radius, h = tz + 2);
                        }

                        if (teeth)
                        {
                            for (index = [0 : num_teeth - 1]) {
                                rotate([0, 0, ((sx + tx) * -(index + 0.5)) / (circumference / 360)]) translate([0, -curve_radius, 0])
                                cube([1, ty, tz]);
                            }
                        }

                    }

                    translate([0, -(curve_radius + bt) - 1, -1])
                        cube([curve_radius + bt, (curve_radius + bt) * 2 + 2, beltup_spec_belt_width(belt_spec) + 2]);
                }

                //Place a block to cut off this belt at the right angle
                translate([0, 0, -1]) rotate([0, 0, angle + 90]) translate([-curve_radius * 2, 0, 0])
                cube([curve_radius * 4, curve_radius * 2, tz + 2]);
            }
        }
    }

    //todo: test of curved belt - calculate correct angle
    translate(wheel_pos)
    rotate([])
        beltup_curved_belt(belt_spec, beltup_spec_wheel_inner_rad(wheel_spec), 170);

    echo("todo: render belt curve");
}

