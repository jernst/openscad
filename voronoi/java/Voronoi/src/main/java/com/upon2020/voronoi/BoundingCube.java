/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.upon2020.voronoi;

/**
 *
 * @author jernst
 */
public class BoundingCube {

    public static BoundingCube create(
            double minX,
            double minY,
            double minZ,
            double maxX,
            double maxY,
            double maxZ )
    {
        return new BoundingCube( minX, minY, minZ, maxX, maxY, maxZ );
    }
    
    private BoundingCube(
            double minX,
            double minY,
            double minZ,
            double maxX,
            double maxY,
            double maxZ )
    {
        theMinX = minX;
        theMinY = minY;
        theMinZ = minZ;
        theMaxX = maxX;
        theMaxY = maxY;
        theMaxZ = maxZ;
    }

    public double minX()
    {
        return theMinX;
    }
    public double minY()
    {
        return theMinY;
    }
    public double minZ()
    {
        return theMinZ;
    }

    public double maxX()
    {
        return theMaxX;
    }
    public double maxY()
    {
        return theMaxY;
    }
    public double maxZ()
    {
        return theMaxZ;
    }
    
    protected double theMinX;
    protected double theMinY;
    protected double theMinZ;
    protected double theMaxX;
    protected double theMaxY;
    protected double theMaxZ;
}
