/* Create a grid of holes for screws to mount other components to the rack-mount plate. 
left side should be based on rackstack dimentison for default rack
X=width (left/right)
Z=Height (up/down)
Y=Depth (front/back)

ECHO: "Vertical distance between 2 main rail hole centers (screwDiff): ", 10
ECHO: "Horizontal distance between 2 opposing main rail holes (rackMountScrewWidth): ", 215
ECHO: "Distance between main rail screw, and main rail inner edge (railScrewHoleToInnerEdge):", 5
ECHO: "Distance between main rail screw, and main rail outer edge (railScrewHoleToOuterEdge):", 7
ECHO: "Max supported rack-mount width (maxUnitWidth): ", 205
ECHO: "Max recommended rack-mount depth (maxUnitDepth): ", 205
ECHO: "Z axis length between screws(rackMountScrewXDist): ", 4.5  // center of screw to edge
ECHO: "X axis length between screws(rackMountScrewZDist): ", 4.5   // center of screw to edge

// m4Diameter is 4 mm m4Radius is half that m4RadiusSlacked= m4Radius + m4HoleRadiusSlack; xySlack = 0.25; radiusXYSlack = xySlack/2;
*/
include <../../common.scad>

// ---------------- User Parameters ----------------
rackUnits=11;
width = 39;
thickness = 3;
rounding = 2;       //Corner radius
screwType  = "m4";  // Mounting screw type
screwSlack = 1.1;   // Multiplier for added screw size space. 1 = no slack; 1.1 = 10% larger hole

//Screw hole count 
boltsLeft = 11;
boltsRight = 2;
boltColumnsLeft=1;     // will be spaced evenly across X axis

//Distance between bolts from center to center in mm - using 0 will space them evenly
boltsDistanceRight = 0;  

// details of device
deviceLength = 107;       // must be less than or equal to rackUnits length
screwToBottomEdge = 3.5;    // screw hole edge to device bottom edge

// ---------------- End User Parameters ----------------
// standard hole spacing for rack side attachment (10 mm)
boltsDistanceLeft = screwDiff; 

//Distance between center of corner holes and the edge in mm
gapSides = 6; //rackMountScrewXDist;           // 4.5 mm
gapBottomLeft = rackMountScrewZDist;        // 4.5 mm

deviceSizeDiff = (rackUnits*screwDiff)-deviceLength;
gapBottomRight = (deviceSizeDiff+screwToBottomEdge)+(screwRadius(screwType)*screwSlack); 

if (((boltsLeft-1)*boltsDistanceLeft)+(gapBottomLeft*2)>rackUnits*screwDiff) {
    assert(false, str("Left spacing incorrect. Max: ",rackUnits*screwDiff));
    }
if (((boltsRight-1)*boltsDistanceRight)+(gapBottomRight*2)>rackUnits*screwDiff) {
    assert(false, str("Right spacing incorrect. Max: ",rackUnits*screwDiff));
    }

module slab(length){
    translate([rounding, rounding]) minkowski(){
        circle(rounding);
        square([width - 2*rounding, length - 2*rounding]);
    }
}
module bolts(iStart,iEnd, boltCount, gapSides, gapBottom, boltPitchLength, boltpitchHeight){
    for(i = [iStart:iEnd]) for(j = [0:boltCount-1])
    translate([gapSides + i*boltPitchLength, gapBottom + j*boltpitchHeight])
    circle(d = screwDiameter(screwType)*screwSlack);
}

module plate(){
    length = rackUnits*screwDiff; 
    boltspreadx = width - 2*gapSides;
    boltspreadLeft = length - 2*gapBottomLeft; 
    boltspreadRight = length - (2*gapBottomRight)+(deviceSizeDiff/2); // account for device
    // distance between hole centers along x axis
    boltpitchxLeft = boltspreadx / boltColumnsLeft;
    boltpitchxRight = boltspreadx;
    // distance between hole centers along y axis
    boltpitchHeightLeft = boltsDistanceLeft == 0 ? boltspreadLeft / (boltsLeft - 1): boltsDistanceLeft; //10
    boltpitchHeightRight = boltsDistanceRight == 0 ? boltspreadRight / (boltsRight - 1): boltsDistanceRight; 

    difference(){
        slab(length); 
        bolts(0,boltColumnsLeft-1,boltsLeft,gapSides,gapBottomLeft,boltpitchxLeft,boltpitchHeightLeft);
        bolts(boltColumnsLeft,1,boltsRight,gapSides,gapBottomRight,boltpitchxRight,boltpitchHeightRight);
    }
}

linear_extrude(height = thickness) plate();