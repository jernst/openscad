t      =  1;
h      = 10;
cellW  = 25;
cellD  = 10;
days   =  7;
perDay =  7;
eps    =  0.01;
tag    = 10;

cube( [ days * cellW + (days+1) * t, perDay * cellD + (perDay+1) * t, t ] );

translate( [ -tag, 0, 0 ] ) {
    cube( [ tag+eps, perDay * cellD + (perDay+1) * t, t+h ] );
}

translate( [ -tag, -tag, 0 ] ) {
    cube( [ tag+eps + days * cellW + (days+1) * t, tag+eps, t+h ] );
}

for( day = [ 0 : days ] ) {
    translate( [ day * ( cellW + t ), 0, t-eps ] ) {
        cube( [ t, perDay * (cellD+t) , h ] );
    }
}
for( when = [ 0 : perDay ] ) {
    translate( [ 0, when * ( cellD + t ), t-eps ] ) {
        cube( [ days * cellW + (days+1) * t, t, h ] );
    }
}