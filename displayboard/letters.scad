
use <pegs.scad>


module Letters( letters, size, height, pegHeight ) {
    intersection() {
        LettersInt( letters, size, height + pegHeight );
        Pegs( $length, $width, $gridX, $gridY, $pegsR, 20 );
    }
    LettersInt( letters, size, height );
}

module LettersInt( letters, size, height ) {
    mirror( [ 1, 0, 0 ] )
    scale( [ 0.7, 1, 1 ] )
    linear_extrude( height ) {
        text( letters, font = "Noto Serif", size=size, halign="right" );
    }
}
