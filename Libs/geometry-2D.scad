function vector_2d(x, y) = [ x, y ];
function x(v) = v[0];
function y(v) = v[1];
function extend2d_to_3d(xy, z) = [ xy[0], xy[1], z];

function perpendicular_left(v) = [ -y(v), x(v) ];
function perpendicular_right(v) = [ y(v), -x(v) ];

function magnitude(v) = sqrt(pow(x(v), 2) + pow(y(v), 2));
function normalize(v) = [ x(v) / magnitude(v), y(v) / magnitude(v) ];

function line_2d(point, direction) = [ point, direction ];
function line_segment_2d(start, end) = [ start, end ];

function dot2d(a, b) = a[0] * b[0] + a[1] * b[1];
function dot3d(a, b) = a[0] * b[0] + a[1] * b[1] + a[2] * b[2];