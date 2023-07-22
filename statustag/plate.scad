
include <constants.inc>

indent = 10;

union() {
    cube( [ plateX, plateY, t ] );

    for( x = [ indent, plateX - indent ] ) {
        translate( [ x - pegL / 2 + play / 2, ( plateY - pegD - pegL + play ) / 2, t - eps ] ) {
            cube( [ pegL-play, pegW-play, pegH ] );
        }
        translate( [ x - pegL / 2 + play / 2, ( plateY + pegD - pegL + play ) / 2, t - eps ] ) {
            cube( [ pegL-play, pegW-play, pegH ] );
        }
    }
}
