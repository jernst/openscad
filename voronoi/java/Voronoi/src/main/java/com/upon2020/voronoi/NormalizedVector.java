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
public class NormalizedVector
    extends
        Vector
{
    public static NormalizedVector create(
            double x,
            double y,
            double z )
    {
        double length = Math.sqrt( x*x + y*y + z*z );
        
        return new NormalizedVector( x / length, y / length, z/length );
    }
    
    protected NormalizedVector(
            double x,
            double y,
            double z )
    {
        super( x, y, z );
    }
}
