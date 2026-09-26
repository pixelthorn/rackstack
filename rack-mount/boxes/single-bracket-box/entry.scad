include <../../common.scad>

use <../enclosed-box/sideRail.scad>


/*
  Simple angle bracket mounting system. Mainly derived the enclosed box system. 
*/


    
// Does not affect any part dimensions. Set this to true to visualize how a box would be mounted.
visualize = false;

// ---------------- User Parameters ----------------
leftOrRight = "right";  //TBD
thickness = 3;

boxWidth = 195; // width from rail to rail
railDepth = 185; // front to back

// 85.6mm (length) × 56.5mm (width) × 17mm (height)
plateWidth = 58; 
plateDepth = 88; 
yAdjustment = 10;   // Where to place plate on rail. 0=even with front edge
sideVent = false;
u =    2;

lipWidth = 5;
lipHeight = 10;
ventSpacing = 5;
slotWidth = 5;
Z=10*u-2*thickness;

// end config////////////////////////////////////////

module rPi3b() {
   // Everything inside this window gets vented; nothing outside it does.
   ventW = plateWidth-lipWidth-Z ; // disregard lip and bracket widths
   ventL = plateDepth-2*lipWidth;
    //echo(ventW, ventL); //ECHO: 39, 78
   spacing = ventSpacing / sqrt(2); // center-to-center measured across the stripes
   numStripes = ceil((ventW + ventL) / (2*ventSpacing)) + 1; 
   // echo(numStripes);  //13
   
    n = ceil((ventW + ventL) / (2*spacing)) + 1;             // stripes each side of center
    stripeLen = sqrt(ventW*ventW + ventL*ventL) + 2*spacing; // over-long, gets clipped
    
    
    difference() {
        // create plate with edges
        union() {
            // base plate
            translate([0, yAdjustment, -thickness])
            cube([plateWidth+lipWidth, plateDepth+lipWidth*2, thickness], center=false); 

            // front lip
            translate(v = [0, yAdjustment, -thickness])
            cube(size = [plateWidth+lipWidth, lipWidth, lipHeight]);

            // back lip
            translate(v = [0, plateDepth+lipWidth*2+yAdjustment, -thickness])
            cube(size = [plateWidth+lipWidth, lipWidth, lipHeight]);
            
            // side lip
            rotate([0,0,90])
            translate(v = [yAdjustment,-(plateWidth-lipWidth+yAdjustment), -thickness])
            cube(size = [plateDepth+lipWidth*2, lipWidth, lipHeight]);
            } // end union
            
            
            
           // add ventilation

           
            
      /*
      // Clip the stripe field to the centered window
       intersection() {
            translate([lipWidth*2, lipWidth-2, -thickness])
                cube([ventW, ventL, thickness*3], center=false);
            //add the stripes to the plate frame
            union() {
                for (k = [-n : 1 : n]) {
                    translate([plateWidth/2+Z, plateDepth/2+yAdjustment, -thickness])
                    translate([k*spacing - slotWidth/2, -stripeLen/2, 0])
                    cube([slotWidth, stripeLen, thickness*3], center=false);
                }
            }// end union
        } // end intersection
        */
        
           union() {
            for (i=[1 : numStripes]) {
              translate(v=[(ventW/2.0)+Z, i*6+lipWidth+Z,0])
                minkowski() {
                cube(size=[ventW,1,Z], center=true);
                cylinder(h=1,r=1);
              } // end minkowski
           } // end for
        }  // end union 
        
    } // end difference
 }

module angleBracketBox () {    
    // Left Rail
    
    sideSupportRailBase(top=false, defaultThickness=thickness, railSideThickness=thickness, supportedZ=Z, supportedY=railDepth, supportedX=boxWidth, sideVent=sideVent);
    
    // Right Rail
    /*
    rightRailTrans = visualize
        ? translate(v=[boxWidth,0,0]) * mirror(v=[1,0,0])
        : translate(v=[30,0,0]) * mirror(v=[1,0,0]);
    
    multmatrix(rightRailTrans)
    sideSupportRailBase(top=false, defaultThickness=thickness, railSideThickness=thickness, supportedZ=Z, supportedY=railDepth, supportedX=boxWidth, sideVent=sideVent);
    */
    
    // build box on bracket   
    color([0,0,1])     //Colors work only in Preview mode (F5)
    rPi3b();
    
    
}


angleBracketBox();