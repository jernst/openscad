/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.upon2020.voronoi;

import java.text.MessageFormat;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 
 */
public class Main
{
    /**
     * @param args the command line arguments
     */
    public static void main(
            String[] args )
    {
        BoundingCube bounds = BoundingCube.create( 0.0, 0.0, 0.0, 100.0, 100.0, 300.0 );

        Set<Point> seedPoints = obtainSeedPoints();
        
        Voronoi v = Voronoi.createFromSeedPoints( seedPoints );
        
        Set<Area> areas = v.areas();
        for( Area a : areas ) {
            List<Point> vertices = a.vertices( bounds );
            emit( "polygon( [\n");
            
            for( Point p : vertices ) {
                emit( "    [ %f, %f, %f ],\n", p.x(), p.y(), p.z() );
            }
            emit( "]);\n" );
                
        }
    }
    
    protected static void emit(
            String s,
            Object ... o )
    {
        System.out.print( MessageFormat.format( s, o ));
    }
    
    protected static Set<Point> obtainSeedPoints()
    {
        HashSet<Point> ret = new HashSet<>();
        
        ret.add( Point.create( 75 , 10, 30 ));
        ret.add( Point.create( 25 , 80, 250 ));
        return ret;
    }
}
