use <Core.scad>;

//Specify some belts
belt = beltup_specify_belt(width = 6, thickness = 1, tooth_length = 1, tooth_separation = 1, tooth_height = 1, color = "red");

//Specify some wheels
w07 = beltup_specify_wheel(inner_radius = 7, hole_radius = 6);
w14 = beltup_specify_wheel(inner_radius = 14, hole_radius = 10);
w21 = beltup_specify_wheel(inner_radius = 21, hole_radius = 15);
w47 = beltup_specify_wheel(inner_radius = 47, hole_radius = 40);

//Instantiate wheels in position
w1 = beltup_create_wheel(belt, w47, [+00, +00], false);
w2 = beltup_create_wheel(belt, w07, [+70, +00], true);
w3 = beltup_create_wheel(belt, w14, [+70, +40], true);
w4 = beltup_create_wheel(belt, w21, [-60, +80], false);

//Draw wheels
beltup_render_wheel(w1);
beltup_render_wheel(w2);
beltup_render_wheel(w3);
beltup_render_wheel(w4);

//Render straight belt sections between wheels
beltup_render_straight_belt(belt, beltup_wheel_tangent([+00, -90], w1, false));
beltup_render_straight_belt(belt, beltup_wheel_wheel_tangent(belt, w1, true, w2, false));
beltup_render_straight_belt(belt, beltup_wheel_wheel_tangent(belt, w2, false, w3, false));
beltup_render_straight_belt(belt, beltup_wheel_wheel_tangent(belt, w3, true, w4, true));
beltup_render_straight_belt(belt, beltup_wheel_tangent([+00, 120], w4, true));