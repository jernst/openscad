l = 40;
d = 8;
h = 60;

$fn = 64;

translate( [d, 0, 0] )
cube( [l-d, d, d]);

translate( [0, d, 0] )
cube( [d, l-d, d]);

translate([d, d, 0])
cylinder( r=d, h=h-d );

translate([d, d, h-d]) {
    sphere(r=d);
}