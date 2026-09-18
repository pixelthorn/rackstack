//Width
sizex = 39;
//Length
sizey = 106.6;
thickness = 3;
//Distance between center of corner holes and the edge 
gapx = 6;
gapy = 6;
//Bolt hole diameter
boltsize = 5;
//Bolt count in X axis
boltsx = 2;
//Bolt count in Y axis
boltsy = 11;
//Corner radius
rounding = 5;

boltspreadx = sizex - 2*gapx;
boltspready = sizey - 2*gapy; //94.5
boltpitchx = boltspreadx / (boltsx - 1);
boltpitchy = boltspready / (boltsy - 1);

module slab(){
    translate([rounding, rounding]) minkowski(){
        circle(rounding);
        square([sizex - 2*rounding, sizey - 2*rounding]);
    }
}
module bolts(){
    for(i = [0:boltsx-1]) for(j = [0:boltsy-1])
    translate([gapx + i*boltpitchx, gapy + j*boltpitchy])
    circle(d = boltsize);
}
module plate(){
    difference(){
        slab(); bolts();
    }
}

linear_extrude(height = thickness) plate();