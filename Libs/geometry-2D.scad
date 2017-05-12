function vector_2d(x, y) = [ x, y ];
function x(v) = v[0];
function y(v) = v[1];
function extend2d_to_3d(xy, z) = [ xy[0], xy[1], z];

function perpendicular_left(v) = [ -y(v), x(v) ];
function perpendicular_right(v) = [ y(v), -x(v) ];

function magnitude(v) = sqrt(pow(x(v), 2) + pow(y(v), 2));
function normalize(v) = [ x(v) / magnitude(v), y(v) / magnitude(v) ];

function ray_2d(point, direction) = [ point, direction ];
function invert_ray_along(ray, along) = [ ray[0] + ray[1] * along, -ray[1] ];
function point_along_ray(ray, distance) = ray[0] + ray[1] * distance;
function is_point_left_of_ray(ray, point) = distance_from_ray_to_point(ray, point) > 0;
function distance_from_ray_to_point(ray, point) = cross_2d(ray[1], (point - ray[0])) / magnitude(ray[1]);

function line_segment_2d(start, end) = [ start, end ];

function cross_2d(a, b) = x(a) * y(b) - y(a) * x(b);

function dot2d(a, b) = a[0] * b[0] + a[1] * b[1];
function dot3d(a, b) = a[0] * b[0] + a[1] * b[1] + a[2] * b[2];

function circ(center, radius) = [ center, radius ];

// module demo_geom()
// {
//     c1 = circ(vector_2d(0, 0), 20);
//     c2 = circ(vector_2d(-50, 0), 25);

//     tangents = circle_circle_tangents(c1, c2);

//     translate(c1[0]) circle(r = c1[1]);
//     translate(c2[0]) circle(r = c2[1]);

//     for (t = tangents) {
//         for (i = [0 : 100]) {
//             color("red") translate(point_along_ray(t, i / 100)) circle(r = 1);
//         }
//     }
// }

/*
 * Calculates the intersection points of 2 circles.
 * Returns a list of all intersection points (an empty list, if the circles are disjoint)
 */
function circle_circle_intersection(a, b) =
    //https://stackoverflow.com/a/3349134/108234
    let(
        r0 = a[1],
        r1 = b[1],
        p0 = a[0],
        p1 = b[0],
        d = magnitude(a[0] - b[0])
    )
    //Check for the cases where an intersection is impossible and return an empty list
    (d > r0 + r1 || d < abs(r0 - r1))
    ? []
    //Intersection is possible, calculate where it is
    : let(
        aa = (pow(r0, 2) - pow(r1, 2) + pow(d, 2)) / (2 * d),
        p2 = p0 + aa * (p1 - p0) / d,
        h = sqrt(pow(r0, 2) - pow(aa, 2)),
        p0p1 = normalize(p1 - p0)
    ) [
        p2 + perpendicular_left(p0p1) * h,
        p2 + perpendicular_right(p0p1) * h,
    ];

function circle_circle_tangents(c1, c2) =
    let(
        //rearrange circles so r1 is the larger
        swap = c1[1] < c2[1],
        r1 = swap ? c2 : c1,
        r2 = swap ? c1 : c2,

        dist = magnitude(c2[0] - c1[0])
    )
    
    //Check if the larger circle completely contains the smaller, in which case return an empty list
    r1[1] > dist + r2[1] ? []

    //Ok we can generate some tangents at least
    : let(
        //Construct tangents through center of r2, to r1 (shrunk by r2 radius)
        otans = circle_tangents_through_point(r2[0], circ(r1[0], r1[1] - r2[1])),
        outer = [
            ray_2d(otans[0][0] + perpendicular_right(normalize(otans[0][1])) * r2[1], otans[0][1]),
            ray_2d(otans[1][0] + perpendicular_left(normalize(otans[1][1])) * r2[1], otans[1][1]),
        ],

        outer_swapped = [
            swap ? invert_ray_along(outer[0], 1) : outer[0],
            swap ? invert_ray_along(outer[1], 1) : outer[1],
        ],

        //Construct tangents through center of r2, to r1  (inflated by r2 radius)
        itans = circle_tangents_through_point(r2[0], circ(r1[0], r1[1] + r2[1])),
        inner = [
            ray_2d(itans[0][0] + perpendicular_left(normalize(itans[0][1])) * r2[1], itans[0][1]),
            ray_2d(itans[1][0] + perpendicular_right(normalize(itans[1][1])) * r2[1], itans[1][1])
        ],
        
        inner_swapped = [
            swap ? invert_ray_along(inner[0], 1) : inner[0],
            swap ? invert_ray_along(inner[1], 1) : inner[1],
        ]
    )
    
    //Check if the circles intersect, in which case only return the outer tangents
    dist < (r1[1] + r2[1])
    ? [ outer_swapped[0], outer_swapped[1] ]
    : [ outer_swapped[0], outer_swapped[1], inner_swapped[0], inner_swapped[1] ];

/*
 * Calculate the 2 circle tangents through a point.
 * Returns a list of 2 intersections through the given point, or an empty list if the point is inside the circle
 */
function circle_tangents_through_point(point, circl) =
    //http://intermath.coe.uga.edu/tweb/CPTM1/jwilson/wilson/tancir/tanconstr.htm
    let(
        dist = magnitude(point - circl[0])
    ) dist <= circl[1]
    ? []
    : let(
        c = point,
        a = circl[0],
        radius = circl[1],
        m = a * 0.5 + c * 0.5,
        am_mag = magnitude(m - a),
        circ_m = circ(m, am_mag),
        f_g = circle_circle_intersection(circl, circ_m),
        cg = ray_2d(c, f_g[0] - c),
        cf = ray_2d(c, f_g[1] - c)
    ) [ cg, cf ];