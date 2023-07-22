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
public class Point {
    public static Point create(
            double x,
            double y,
            double z )
    {
        return new Point( x, y, z );
    }
    
    private Point(
            double x,
            double y,
            double z )
    {
        theX = x;
        theY = y;
        theY = z;
    }
    
    public double x()
    {
        return theX;
    }
    public double y()
    {
        return theY;
    }
    public double z()
    {
        return theZ;
    }
    
    protected double theX;
    protected double theY;
    protected double theZ;
}
