//
//
//

$clipW = 42;
$clipH =  7;
$clipD = 10;
$wall  =  3;

$h = $clipH + 2 * $wall;
$w = $clipW + 2 * $wall;
$d = $clipD + $wall;

difference() {
    cube( [ $d, $w, $h ]);

    translate( [ $wall, $wall, $wall ] ) {
        cube( [ $clipD, $clipW, $clipH ]);
    };
};
