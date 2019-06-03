//
//
//

p = [
    [ 0,  0 ],
    [ 20, 10 ],
    [ 30, 10 ],
    [ 30, 30 ],
    [ 0,  30 ]
];

q = [
    [
        [ 10,   0 ],
        [ 10,  10 ]
    ]
];
$bsteps = 10;

p2 = bezier_curve( p, q );
// echo( p );
//echo( p2 );

polygon( p2 );

// echo( bezier_curve_calc(0.5, p));
// echo( bezier_curve(p, q));


function bezier_curve( p, q ) = [
    for( i = [ 0 : len(p)-1 ] ) each
        ( i < len(q) && len(q[i]) > 0 )
            ? bezier_curve_points( concat( [ p[i] ], q[i], [ p[i+1] ] ))
            : [ p[i] ]
];



function bezier_curve_points( p ) = [
    for( i= [ 0 : $bsteps-1 ] ) bezier_curve_calc( i/$bsteps, p )
];

function bezier_curve_calc( t, p ) =
      len(p) == 2 ? bezier_curve_calc2( t, p ) 
    : len(p) == 3 ? bezier_curve_calc3( t, p )
    : len(p) == 4 ? bezier_curve_calc4( t, p )
    : error( "Unsupported length of points array", len(p))
;

function bezier_curve_calc2(t, p) = 
          p[0] * (1-t)
    +     p[1] * t
;

function bezier_curve_calc3(t, p) = 
          p[0] * (1-t) * (1-t)
    + 2 * p[1] * t     * (1-t)
    +     p[2] * t     * t
;

function bezier_curve_calc4(t, p) = 
          p[0] * (1-t) * (1-t) * (1-t)
    + 3 * p[1] * t     * (1-t) * (1-t)
    + 3 * p[2] * t     * t     * (1-t)
    +     p[3] * t     * t     * t
;
