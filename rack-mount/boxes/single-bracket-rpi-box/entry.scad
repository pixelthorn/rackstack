/*
  Simple angle bracket mounting system. Mainly derived the from enclosed box system. 
*/


include <../../common.scad>
use <../enclosed-box/sideRail.scad>
use <../../../misc/misc_boards.scad>
use <../../../misc/device_raspberrypi.scad>




    
// Does not affect any part dimensions. Set this to true to visualize how a box would be mounted.
visualize = false;

// ---------------- User Parameters ----------------
leftOrRight = "right";  //TBD
thickness = 3;
sideVent = false;
u =    2;
boxWidth = 195; // width from rail to rail


// 85.6mm (length) × 56.5mm (width) × 17mm (height)
// internal box plate measurements
plateWidth = 58; 
plateDepth = 88; 
yAdjustment = 10;   // Where to place box on rail. 0=even with front edge

// box side/lip configuration
lipWidth = 5;
lipHeight = 10;
// box plate vent configuration
ventSpacing = 5;
slotWidth = 5;

// calculated
Z=u*screwDiff-(2*thickness);    // mm height (vertical) above bracket base
railDepth = plateDepth+yAdjustment+(lipWidth*2); // front to back

// end config////////////////////////////////////////



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
    board_raspberrypi_4_model_b();
    raspberry_pi_zero(withHeader=true);
    
    
}


angleBracketBox();