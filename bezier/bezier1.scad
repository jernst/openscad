//
//
//

use <lib/bezier.scad>

p = [
    [ 0,  0 ],
    [ 20, 10 ],
    [ 30, 0 ],
    [ 30, 30 ],
    [ 0,  30 ]
];

q = [
    [
        [ 30,   0 ],
        [ -10,  10 ]
    ],
    [
        [ 30,   10 ],
    ]
];

p2 = bezier_curve_seq_inclusive( p, q );

polygon( p2 );

