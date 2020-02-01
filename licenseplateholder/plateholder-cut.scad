include <plateholder.scad>
use <../../openscad-cuts/cuts/puzzle.scad>

Puzzle( apart=20, y = [ 12, 140 ] ) {
    translate( [ -$width/2, 0, 0 ] ) {
        PlateHolder();
    }
}
