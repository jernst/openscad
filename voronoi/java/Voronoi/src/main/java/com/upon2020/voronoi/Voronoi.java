/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.upon2020.voronoi;

import java.util.Set;

/**
 *
 * @author jernst
 */
public class Voronoi {
    public static Voronoi createFromSeedPoints(
            Set<Point> seedPoints )
    {
        return new Voronoi( seedPoints );
    }
    
    protected Voronoi(
            Set<Point> seedPoints )
    {
        theSeedPoints = seedPoints;
    }
    
    public Set<Area> areas()
    {
        compute();
        
        return theAreas;
    }
    
    protected void compute()
    {
        
    }

    protected Set<Point> theSeedPoints;
    protected Set<Area>  theAreas;
}
