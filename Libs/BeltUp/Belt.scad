/*
  Render a straight piece of belt from A -> B. Use `flip` to change which side the teeth are on.
  - Specification of the belt to draw
  - Array of [start_pos, end_pos, flip_tooth_side]
*/
module beltup_render_straight_belt(belt_spec, position) {
    a = position[0];
    b = position[1];
    flip = position[2];

    echo(position);

    ab = b - a;
    length = magnitude(ab);
    norm = ab / length;
    xpd = cross([0, 1, 0], extend2d_to_3d(norm, 0));
    dot = dot2d([0, 1], norm);
    zangle = acos(dot) * sign(xpd[2]) + (flip ? 180 : 0);

    ty = beltup_spec_belt_tooth_length(belt_spec);
    tz = beltup_spec_belt_tooth_height(belt_spec);
    sy = beltup_spec_belt_tooth_separation(belt_spec);
    num_teeth = beltup_num_teeth(belt_spec, length);

    x = beltup_spec_belt_width(belt_spec);
    y = length;
    z = beltup_spec_belt_thickness(belt_spec);

    translate(flip ? b : a) rotate([0, -90, zangle]) color(beltup_spec_belt_color(belt_spec))
        intersection() {

            //Intersect with this volume to only show valid teeth
            cube([x, y, z + tz + 1]);

            union() {
                //Base of belt
                cube([x, y, z]);

                //Teeth
                for(offset = [0 : num_teeth])
                    translate([0, offset * (sy + ty), z])
                        cube([x, ty, tz]);
            }
        }
}