eps = 0.01;

module brick(width, height, depth, surface, bumpiness = 0.5, camph = 1.2) {
    translate([camph, camph, depth])
    scale([(width - 2*camph)/22, (height - 2*camph)/12, bumpiness])
    surface(surface);

    polyhedron(
        points = [
            [ 0,     0,     0 ],
            [ width, 0,     0 ],
            [ width, height, 0 ],
            [ 0,     height, 0 ],

            [ 0,     0,      depth - camph ],
            [ width, 0,      depth - camph ],
            [ width, height, depth - camph ],
            [ 0,     height, depth - camph ],

            [ camph,         camph,          depth + eps ],
            [ width - camph, camph,          depth + eps ],
            [ width - camph, height - camph, depth + eps ],
            [ camph,         height - camph, depth + eps ]
        ],
        faces = [
            [ 0, 1, 2, 3 ],

            [ 0, 4, 5, 1 ],
            [ 1, 5, 6, 2 ],

            [ 2, 6, 7, 3 ],
            [ 3, 7, 4, 0 ],

            [ 4, 8, 9, 5 ],
            [ 5, 9, 10, 6 ],
            [ 6, 10, 11, 7 ],
            [ 7, 11, 8, 4 ],

            [ 8, 11, 10, 9 ]
        ],
        convexity = 10
    );
}

brick(30, 10, 5, "surfaces/1.txt");
