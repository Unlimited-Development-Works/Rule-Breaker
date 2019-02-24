/*
 * Paramtric library for belts and pulleys
 * Martin Evans - 2016
 */

use <mistakes-were-made.scad>;
use <geometry-2D.scad>;

beltup_demo();
module beltup_demo() {

    //Specify all the parts of the assembly
    belt = beltup_specify_belt(width = 6, thickness = 1, tooth_length = 1, tooth_separation = 1, tooth_height = 1, color = "red");
    w07 = beltup_specify_wheel(inner_radius = 7, hole_radius = 6);
    w14 = beltup_specify_wheel(inner_radius = 14, hole_radius = 10);
    w21 = beltup_specify_wheel(inner_radius = 21, hole_radius = 15);

    //0 wheel system
    translate([3, 0, 0])
        beltup_render_straight_belt(belt, [-10, 10], [10, -20], flip = false);
    translate([-3, 0, 0])
        beltup_render_straight_belt(belt, [-10, 10], [10, -20], flip = true);

    //1 wheel system (no belt)
    translate([0, 50, 0])
        beltup_render_wheel(belt, w07);

    //1 wheel system
    translate([50, 0, 0])
    {
        a = [-10, 0];
        w = [20, 70];
        b = [45, 30];

        //Draw wheel
        translate(w) beltup_render_wheel(belt, w14);

        aw = beltup_wheel_tangent_in(belt, a, w14, w, false, true);
        wb = beltup_wheel_tangent_out(belt, w14, w, b, true, true);

        beltup_render_belt_tangent(belt, aw);
        beltup_render_curve_between_tangents(belt, a, false, w14, w, b, true, true);
        beltup_render_belt_tangent(belt, wb);
    }

    //1 wheel system
    translate([50, 40, 0])
    {
        a = [-10, 90];
        w = [20, 70];
        b = [45, 90];

        //Draw wheel
        translate(w) beltup_render_wheel(belt, w14);

        aw = beltup_wheel_tangent_in(belt, a, w14, w, true, false);
        wb = beltup_wheel_tangent_out(belt, w14, w, b, false, false);

        beltup_render_belt_tangent(belt, aw);
        beltup_render_curve_between_tangents(belt, a, true, w14, w, b, false, false);
        beltup_render_belt_tangent(belt, wb);
    }

    //3 wheel system
    translate([100, -50, 0])
    {
        a = [-10, 0];
        w1 = [20, 70];
        w2 = [40, 20];
        w3 = [40, 90];
        b = [75, 60];


        //Draw wheels
        translate(w1) beltup_render_wheel(belt, w14);
        translate(w2) beltup_render_wheel(belt, w21);
        translate(w3) beltup_render_wheel(belt, w07);

        //a -> w1
        beltup_render_point_to_wheel_belt(belt, a, w14, w1, false, teeth_in = true);

        //w1 -> w2
        beltup_render_wheel_to_wheel_belt(belt, [w14, w1, false], [w21, w2, true], true);

        //w2 -> w3
        beltup_render_wheel_to_wheel_belt(belt, [w21, w2, true], [w07, w3, false], false);

        //w3 -> b
        beltup_render_point_to_wheel_belt(belt, b, w07, w3, true, teeth_in = false);
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

/*
  Render a belt connecting a point on one wheel to a point on another wheel
   - belt_spec          - belt specification
   - wheel1             - Array of details about wheel 1 [wheel_spec, wheel_position, side]
   - wheel2             - Array of details about wheel 2 [wheel_spec, wheel_position, side]
*/
module beltup_render_wheel_to_wheel_belt(belt_spec, wheel1, wheel2, teeth_in_w1) {
    w1 = wheel1[0];
    p1 = wheel1[1];
    s1 = wheel1[2];
    c1 = circ(p1, beltup_spec_wheel_inner_rad(w1) + (teeth_in_w1 ? beltup_spec_belt_thickness(belt_spec) : 0));

    w2 = wheel2[0];
    p2 = wheel2[1];
    s2 = wheel2[2];
    c2 = circ(p2, beltup_spec_wheel_inner_rad(w2) + (!teeth_in_w1 ? beltup_spec_belt_thickness(belt_spec) : 0));

    //todo: check all these indices
    index = s1 && s2 ? 0
          : s1 && !s2 ? 3
          : !s1 && s2 ? 2
          : 1;

    tangents = circle_circle_tangents(c1, c2);
    t = tangents[index];
    start = point_along_ray(t, 0);
    end = point_along_ray(t, 1);

    beltup_render_straight_belt(belt_spec, start, end, !teeth_in_w1);
}

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
    rotate([0, -90, zangle]) color(beltup_spec_belt_color(belt_spec))
        beltup_straight_belt(belt_spec, magnitude(b - a));
}

//Calculate the tangent data from a point to a wheel
function beltup_wheel_tangent_in(belt_spec, point, wheel_spec, wheel_pos, side, teeth_in = true) = let(

    //Depending on which way the belt is oriented we may need to add one extra belt thickness to clear the wheel rim
    extra_radius = teeth_in ? beltup_spec_belt_thickness(belt_spec) : 0,

    //Generate both tangents from current point to next belt.
    tangents = circle_tangents_through_point(point, circ(wheel_pos, beltup_spec_wheel_inner_rad(wheel_spec) + extra_radius)),

    //Choose which side to go to
    tangent = side ? tangents[0] : tangents[1],

    //Determine if we need to flip the belt
    is_left = is_point_left_of_ray(tangent, wheel_pos),
    flip = (!is_left && teeth_in) || (is_left && !teeth_in),

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

    //Depending on which way the belt is oriented we may need to add one extra belt thickness to clear the wheel rim
    extra_radius = teeth_in ? beltup_spec_belt_thickness(belt_spec) : 0;

    //Generate both tangents from current point to next belt.
    tangents = circle_tangents_through_point(point, circ(wheel_pos, beltup_spec_wheel_inner_rad(wheel) + extra_radius));

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

    function calc_zangle(t, flip = false) = let(
        xpd = cross([0, 1, 0], extend2d_to_3d(normalize(t[1] - t[0]), 0)),
        dot = dot2d([0, 1], normalize(t[1] - t[0])),
        zangle = acos(dot) * sign(xpd[2]) + (flip ? 180 : 0)
    ) zangle;

    //Calculate normalized vector in
    t_in = beltup_wheel_tangent_in(belt_spec, start_point, wheel_spec, wheel_pos, start_side, teeth_in);
    z_in = calc_zangle(t_in);

    //Calculate normalized vector out
    t_out = beltup_wheel_tangent_out(belt_spec, wheel_spec, wheel_pos, end_point, end_side, teeth_in);
    z_out = calc_zangle(t_out);

    curve_radius = beltup_spec_wheel_inner_rad(wheel_spec);
    bt = beltup_spec_belt_thickness(belt_spec);
    tz = beltup_spec_belt_width(belt_spec);
    ty = beltup_spec_belt_tooth_height(belt_spec);
    tx = beltup_spec_belt_tooth_length(belt_spec);
    sx = beltup_spec_belt_tooth_separation(belt_spec);

    circumference = 2 * 3.14159 * curve_radius;
    num_teeth = beltup_num_teeth(belt_spec, circumference);

    color(beltup_spec_belt_color(belt_spec))
    difference() {

        //Add complete ring
        translate(wheel_pos) {
            union() {
                //Render a complete 360 circle of belt
                difference() {
                    cylinder(r = curve_radius + bt, h = tz);
                    translate([0, 0, -1]) cylinder(r = curve_radius, h = tz + 2);
                }

                //Add teeth to ring of belt
                if (!teeth_in)
                {
                    for (index = [0 : num_teeth - 1]) {
                        rotate([0, 0, ((sx + tx) * -(index + 0.5)) / (circumference / 360)]) translate([0, curve_radius + ty, 0])
                        cube([1, ty, tz]);
                    }
                }
            }
        }

        //Remove unnecessary parts of ring
        union() {
            translate(t_in[1]) rotate([0, 0, z_in]) translate([-curve_radius * 3, -curve_radius * 2, -tz / 2]) {
                cube([curve_radius * 6, curve_radius * 2, tz * 2]);  
            }
            translate(t_out[0]) rotate([0, 0, z_out + 180]) translate([-curve_radius * 3, -curve_radius * 2, -tz / 2]) {
                cube([curve_radius * 6, curve_radius * 2, tz * 2]);  
            }
        }
    }
}

