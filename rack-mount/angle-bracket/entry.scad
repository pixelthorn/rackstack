include <../common.scad>

use <../boxes/enclosed-box/sideRail.scad>


/*
  Simple angle bracket mounting system. Mainly derived the enclosed box system. 
*/
module angleBrackets (  
    // begin config ///
    visualize = false,// Does not affect any part dimensions. Set this to true to visualize how a box would be mounted.
    thickness = 3,
    boxWidth = 195,
    boxDepth = 185,
    sideVent = false,
    u = 2
    // end config ///
) {    

    sideSupportRailBase(top=false, defaultThickness=thickness, railSideThickness=thickness, supportedZ=10*u-2*thickness, supportedY=boxDepth, supportedX=boxWidth, sideVent=sideVent);

    rightRailTrans = visualize
        ? translate(v=[boxWidth,0,0]) * mirror(v=[1,0,0])
        : translate(v=[30,0,0]) * mirror(v=[1,0,0]);
        
    multmatrix(rightRailTrans)
    sideSupportRailBase(top=false, defaultThickness=thickness, railSideThickness=thickness, supportedZ=10*u-2*thickness, supportedY=boxDepth, supportedX=boxWidth, sideVent=sideVent);
}


angleBrackets();