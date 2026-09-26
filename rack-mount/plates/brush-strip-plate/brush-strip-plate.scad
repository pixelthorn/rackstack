include <../../common.scad>
use <../../plateBase.scad>


/*
A 4U (50mm tall) panel for nylon brush stripping to hide cable shame.

Brush Weather Stripping (0.35" Wide x 0.35" Thick): https://amzn.to/3CLpWMp

*/




plateU=2;
plateThickness=3;
brushstripWidth=8.9; // mm depth of rails
brushstripLength=9;  // mm of opening
brushstripOffset=22; //How far from the edge of the plate the Brush Strip Hole will begin
brushstripHoleOverlap=10; //How far the ledges that the brush strip affixes to

/* Reckless copying and pasting begins here */
screwToXEdge=rackMountScrewXDist; 
screwToYEdge=rackMountScrewZDist;  
uDiff = screwDiff;
filletR=2;
screwDx = rackMountScrewWidth;
screwDy = uDiff * plateU;
plateLength = screwDx + 2*screwToXEdge; 
plateHeight = screwDy + 2*screwToYEdge;
railDefaultThickness = 1.5;         //unused
/* End of Reckless copying and pasting? */


if (brushstripOffset - brushstripHoleOverlap < screwToXEdge+railScrewHoleToInnerEdge) {
    assert(false, str("The rails will run into the rack sides! brushstripOffset - brushstripHoleOverlap needs to be >= ", screwToXEdge+railScrewHoleToInnerEdge));
    }
    
brushstripLedgeX=plateLength - ((brushstripOffset-brushstripHoleOverlap)*2);
brushstripLedgeY=5;
brushstripLedgeZ=brushstripWidth*1.2;

brushstripHoleX=plateLength - (brushstripOffset*2); 
brushstripHoleY=brushstripLength*2;
brushstripHoleZ=plateThickness*2;
midPlateY=(plateHeight)/2;

difference(){
    plateBase(U=plateU, plateThickness=plateThickness, screwToXEdge=screwToXEdge, screwToYEdge=screwToYEdge+.5, screwType="m4", filletR=2);
    translate([brushstripOffset,midPlateY-(brushstripHoleY/2),0]) brushstripHole();
}
translate([-screwToXEdge+(brushstripOffset-brushstripHoleOverlap),midPlateY-screwToYEdge+(brushstripHoleY/2),0]) cube([brushstripLedgeX, brushstripLedgeY, brushstripLedgeZ]);
translate([-screwToXEdge+(brushstripOffset-brushstripHoleOverlap),midPlateY-screwToYEdge-(brushstripHoleY/2)- brushstripLedgeY,0]) cube([brushstripLedgeX, brushstripLedgeY, brushstripLedgeZ]);

module brushstripHole(){
translate([-screwToXEdge,-screwToYEdge,-(plateThickness+1)]) cube([brushstripHoleX, brushstripHoleY, brushstripHoleZ]);    
}