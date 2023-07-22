/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.upon2020.voronoi;

import java.util.List;

/**
 *
 */
public class Area
{
    public List<Point> vertices(
            BoundingCube bounding )
    {
        return theVertices;
    }
    
    protected Point theAnchor;
    protected NormalizedVector theNormalVector;
    protected List<Line> theLines;
}
