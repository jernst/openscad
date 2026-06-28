t = 1;

pitch = 2;
turns = 4;
radius_outside = 62/2;
radius_inside = 28;
height = 20;

thread_depth = 1;

steps_per_turn = 50;
steps = turns * steps_per_turn;

points = concat(
    [
        // outside circle at the bottom
        for(i = [0:steps_per_turn-1])
            let( angle = i / steps_per_turn * 360 )
            [
                (radius_outside-thread_depth) * cos(angle),
                (radius_outside-thread_depth) * sin(angle),
                0
            ]
    ],
    [
        // inside circle at the bottom
        for(i = [0:steps_per_turn-1])
            let( angle = i / steps_per_turn * 360 )
            [
                radius_inside * cos(angle),
                radius_inside * sin(angle),
                0
            ]
    ],
    [
        // inside circle at the top
        for(i = [0:steps_per_turn-1])
            let( angle = i / steps_per_turn * 360 )
            [
                radius_inside * cos(angle),
                radius_inside * sin(angle),
                height
            ]
    ],
    [
        // outside circle at the top
        for(i = [0:steps_per_turn-1])
            let( angle = i / steps_per_turn * 360 )
            [
                (radius_outside-thread_depth) * cos(angle),
                (radius_outside-thread_depth) * sin(angle),
                height
            ]
//    ],
//    [
//        // thread 
//        for(i = [0:steps-1])
//            let( angle = i / steps_per_turn * 360 )
//            [
//                (radius_outside-thread_depth) * cos(angle),
//                (radius_outside-thread_depth) * sin(angle),
//                i * pitch / steps_per_turn
//            ]
    ]
);

faces = concat(
    [
        // fill in the bottom (x-y plane)
        for(i = [0:steps_per_turn-1])
            each [
                [
                    i,
                    (i+1) % steps_per_turn,
                    i + steps_per_turn
                ],
                [
                    (i+1) % steps_per_turn,
                    (i+1) % steps_per_turn + steps_per_turn,
                    i + steps_per_turn
                ]
            ]
    ],
    [
        // fill in the inside surface of the cylinder
        for(i = [0:steps_per_turn-1])
            each [
                [
                    i + steps_per_turn,
                    (i+1) % steps_per_turn + steps_per_turn,
                    i + steps_per_turn + steps_per_turn
                ],
                [
                    (i+1) % steps_per_turn + steps_per_turn,
                    (i+1) % steps_per_turn + steps_per_turn + steps_per_turn,
                    i + steps_per_turn + steps_per_turn
                ]
            ]
    ],
    [
        // fill in the top (x-y plane)
        for(i = [0:steps_per_turn-1])
            each [
                [
                    i + 2*steps_per_turn,
                    (i+1) % steps_per_turn + 2*steps_per_turn,
                    i + steps_per_turn + 2*steps_per_turn
                ],
                [
                    (i+1) % steps_per_turn + 2*steps_per_turn,
                    (i+1) % steps_per_turn + steps_per_turn + 2*steps_per_turn,
                    i + steps_per_turn + 2*steps_per_turn
                ]
            ]
    ],
    [
        // temporarily, fill in the outside of the cylinder
        for(i = [0:steps_per_turn-1])
            each [
                [
                    i + 3*steps_per_turn,
                    (i+1) % steps_per_turn + 3*steps_per_turn,
                    i
                ],
                [
                    (i+1) % steps_per_turn + 3*steps_per_turn,
                    (i+1) % steps_per_turn,
                    i
                ]
            ]
    ]
);

polyhedron(points = points, faces = faces );