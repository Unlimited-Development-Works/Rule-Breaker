use <Specs.scad>;

/* Render a wheel according to the given specifications */
module beltup_render_wheel(wheel_instance) {

    mwm_assert(wheel_instance[0] != "wheel_instance", "Wrong type", "beltup_render_wheel", concat("Expected a `wheel_instance`, got a `", wheel_instance[0], "`"))
    {
        wheel_spec = beltup_spec_wheel_instance_spec(wheel_instance);
        belt_spec = beltup_spec_wheel_instance_belt(wheel_instance);

        mwm_assert(belt_spec[0] != "belt", "Wrong type", "beltup_render_wheel", concat("Expected a `belt`, got a `", belt_spec[0], "`"))
        {
            ztop = beltup_spec_wheel_outer_z_top(wheel_spec);
            zbot = beltup_spec_wheel_outer_z_bot(wheel_spec);

            position = beltup_spec_wheel_instance_pos(wheel_instance);

            bw = beltup_spec_belt_width(belt_spec);
            bt = beltup_spec_belt_thickness(belt_spec);

            ty = beltup_spec_belt_tooth_height(belt_spec);

            wir = beltup_spec_wheel_inner_rad(wheel_spec);
            wor = beltup_spec_wheel_outer_rad(wheel_spec);

            arg_out_of_range(wir < (bt + ty), "beltup_cmd_wheel_wheel", "belt_radius", "Must be &gt;= belt_thickness + tooth_height")
            {
                translate(position) difference() {
                    union()
                    {
                        //Center cylinder
                        translate([0, 0, 0]) cylinder(r = wir, h = bw, $fn = 100);

                        //bot belt guide
                        translate([0, 0, -zbot]) cylinder(r = wir + wor, h = zbot, $fn = 23);

                        //top belt guide
                        translate([0, 0, bw]) cylinder(r = wir + wor, h = ztop, $fn = 23);
                    }

                    translate([0, 0, -bw])
                        cylinder(r = beltup_spec_wheel_hole_radius(wheel_spec), h = bw * 3, $fs = 0.1);
                }
            }
        }
    }
}

/* Calculate the tangent point between a point and a wheel */
function beltup_wheel_tangent(point, wheel_instance, side) = let(

    wheel_spec = beltup_spec_wheel_instance_spec(wheel_instance),
    belt_spec = beltup_spec_wheel_instance_belt(wheel_instance),
    wheel_pos = beltup_spec_wheel_instance_pos(wheel_instance),
    teeth_in = beltup_spec_wheel_instance_teethin(wheel_instance),

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

/* Calculate the tangents between 2 circles, return one based on the wheel_side parameters */
function beltup_wheel_wheel_tangent(belt_spec, wheel_instance_1, wheel_side_1, wheel_instance_2, wheel_side_2) = let(

    flip = true,

    c1 = beltup_spec_wheel_instance_as_circle(wheel_instance_1),
    c2 = beltup_spec_wheel_instance_as_circle(wheel_instance_2),
    tangents = circle_circle_tangents(c1, c2, preserve_order = true),

    tangent_index = !wheel_side_1 && !wheel_side_2 ? 0
                  : !wheel_side_1 && wheel_side_2  ? 1
                  : wheel_side_1 && !wheel_side_2  ? 2
                  :                                  3,

    tangent = tangents[tangent_index],
    start = point_along_ray(tangent, 0),
    end = point_along_ray(tangent, 1)

    //true,false = 2

) [
    start,
    end,
    flip
];