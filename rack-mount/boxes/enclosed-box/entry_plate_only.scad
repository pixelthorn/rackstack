include <../../../rack/sharedVariables.scad>
include <../../common.scad>
include <./helper.scad>
use <./frontBoxHolder.scad>

/*
  !!! Please also make sure that the correct rack frame preset is set in rackFrame.scad !!!
*/
module build_plate (

// begin config 
visualize = false,
zOrientation = "middle", // ["middle" | "bottom"]
recessSideRail = false,

boxWidth = 200,
boxHeight = 106.5,

railDefaultThickness = 0,
railSideThickness = 0,

frontPlateThickness = 3,
frontPlateCutoutXSpace = 0,  
frontPlateCutoutYSpace = 0,   

// end config 

) {

  u = findU(boxHeight, railDefaultThickness);
  railBottomThickness = railBottomThickness(u, boxHeight, railDefaultThickness, zOrientation);
  frontBoxHolderTrans = visualize
    ? translate(v = [railSideThickness-(railSupportsDx-boxWidth)/2, 0, sideRailLowerMountPointToBottom-
      railBottomThickness])*mirror(v = [0, 1, 0])*rotate(a = [90, 0, 0])
    : mirror(v = [0, 1, 0])*translate(v = [0, uDiff, frontPlateThickness-railBottomThickness]);

  multmatrix(frontBoxHolderTrans)
    frontBoxHolder(
    cutoutOffsetX = (rackMountScrewWidth-(boxWidth-2*frontPlateCutoutXSpace))/2, cutoutOffsetY = railBottomThickness+
      frontPlateCutoutYSpace,
    cutoutX = boxWidth-2*frontPlateCutoutXSpace, cutoutY = boxHeight-2*frontPlateCutoutYSpace,
    zOrientation = zOrientation, supportedZ = boxHeight, supportWidth = max(10, boxWidth-(sideRailBaseWidth+10)),
    supportRailDefaultThickness = railDefaultThickness, plateThickness = frontPlateThickness
    );
}

build_plate();