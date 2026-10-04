/*
  Single bracket with attached box. Work in progress.
*/


include <../../common.scad>
use <../enclosed-box/sideRail.scad>


// ---------------- User Parameters ----------------
leftOrRight = "right";  
u = 2;
thickness = 3;
sideVent = false;

// internal box plate measurements
plateWidth = 58; 
plateDepth = 88; 
yAdjustment = 10;   // Where to place box on rail. 0=even with front edge

// box side/lip configuration
lipWidth = 10;
lipHeight = 10;
// box plate vent configuration
ventSpacing = 8; // distance between stripe centers - must be larger than slotWidth
slotWidth = 5;  //width of stripes
ventBorder=5; //space before stripes start

// calculated
boxWidth = plateWidth+lipWidth; //only one lip to account for since bracket is on the other side
Z=u*screwDiff-(2*thickness);    // place box at same level as bracket base
railDepth = plateDepth+yAdjustment+(lipWidth*3); // make rail depth end at the edge of the back lip

// end config////////////////////////////////////////

module box() {
   // Vent window (interior of plate, away from lips and bracket)
   ventW  = plateWidth - Z - 2*ventBorder;      // X extent
   ventL  = plateDepth + lipWidth - 2*ventBorder;   // Y extent between front lip and back lip

   // X start: bracket is at x=0 for "left", at x=boxWidth for "right"
   ventX0 = (leftOrRight == "right") ? lipWidth + ventBorder
                                     : Z + ventBorder;
   ventY0 = yAdjustment + lipWidth + ventBorder;

   // Stripe count now depends on depth, not width
   numStripes = floor((ventL - slotWidth) / ventSpacing) + 1;
   // Center the group of stripes in the window
   usedL = (numStripes - 1) * ventSpacing + slotWidth;
   yPad  = (ventL - usedL) / 2;

   echo(ventW=ventW, ventL=ventL, numStripes=numStripes);

   difference() {
       union() {
           // base plate
           translate([0, yAdjustment, -thickness])
               cube([boxWidth, plateDepth + lipWidth*2, thickness]);

           // front lip
           translate([0, yAdjustment, -thickness])
               cube([boxWidth, lipWidth, lipHeight]);

           // back lip
           translate([0, plateDepth + lipWidth*2 + yAdjustment, -thickness])
               cube([boxWidth, lipWidth, lipHeight]);

           // side lip (on the side opposite the bracket)
           sideLipX = (leftOrRight == "right") ? 0 : boxWidth - lipWidth;
           translate([sideLipX, yAdjustment, -thickness])
               cube([lipWidth, plateDepth + lipWidth*2, lipHeight]);
       }


       // vents: rounded-end slots across X, repeated along Y
        if (numStripes > 0 && ventW > slotWidth)
        for (i = [0 : numStripes - 1])
            translate([ventX0, ventY0 + yPad + i*ventSpacing, -thickness - 1])
                hull() {
                    translate([slotWidth/2, slotWidth/2, 0])
                        cylinder(d=slotWidth, h=thickness + 2, $fn=32);
                    translate([ventW - slotWidth/2, slotWidth/2, 0])
                        cylinder(d=slotWidth, h=thickness + 2, $fn=32);
        }
   }
}

module angleBracketBox () {    
    // Left Rail
    if (leftOrRight == "left") {
    sideSupportRailBase(top=false, defaultThickness=thickness, railSideThickness=thickness, supportedZ=Z, supportedY=railDepth, supportedX=boxWidth, sideVent=sideVent);
    }
    
    // Right Rail
    if (leftOrRight == "right") {
    rightRailTrans = true
        ? translate(v=[boxWidth,0,0]) * mirror(v=[1,0,0])
        : translate(v=[30,0,0]) * mirror(v=[1,0,0]);
    
    multmatrix(rightRailTrans)
    sideSupportRailBase(top=false, defaultThickness=thickness, railSideThickness=thickness, supportedZ=Z, supportedY=railDepth, supportedX=boxWidth, sideVent=sideVent);
    }    
    
    // build box on bracket   
    box();
    
    
}


angleBracketBox();