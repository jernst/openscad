use <threadlib/threadlib.scad>
include <consts.inc>
include <modules.inc>


intersection() {
    nut("G1", turns=19, Douter = 2 * in );

    disk();
}
