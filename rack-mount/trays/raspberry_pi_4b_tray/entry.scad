use <../tray/tray.scad>
include <../../common.scad>

/*
  Simple tray with front plate. 
  
  Please make sure to configure the correct rack frame dimensions in rackFrame.scad.
"Vertical distance between 2 main rail holes: ", 10
"Horizontal distance between 2 opposing main rail holes: ", 215
"Distance between main rail screw, and main rail inner edge:", 5
"Max supported rack-mount width: ", 205
"Max recommended rack-mount depth: ", 205

The dimensions of the Raspberry Pi 4 Model B are 85d x 56w x 17h mm.

*/
rackunits=4;
trayWidth = 60;
trayDepth = 90;
thickness = 3;
backLipHeight = 6;

sideSupport = false; // extra support if space allows
trayLeftPadding = 0;// extra space between the left rail and tray. configure this to move the tray left/right.

// for screw holes
mountPoints = [];
mountPointType = "m3";
mountPointElevation = 1; // basically standoff height

//intersection() creates a new shape that keeps only the overlapping (common) volume shared by all child shapes, removing any parts that don’t intersect every child. 

//the difference() function works by subtracting subsequent shapes from the first shape 
union () {
    // translate() moves the object from its original location to a new location in the 3D space  
    /*translate([mainRailSideSupportToInnerEdge+thickness,thickness,thickness]){
    bottomScrewTray (
        u = rackunits,
        trayWidth = trayWidth,
        trayDepth = trayDepth,
        trayThickness = thickness,
        frontLipHeight = (rackunits*10)+(thickness*2) ,
        backLipHeight = backLipHeight,
        mountPoints = mountPoints,
        frontThickness = thickness,
        sideThickness = thickness,
        mountPointElevation = mountPointElevation,
        mountPointType = mountPointType,
        sideSupport = sideSupport,
        trayLeftPadding = trayLeftPadding
        );
    }; // end translate
*/
    

    translate ([ 0,0,0]){
        rotate([0, 90, 90]) {
            //raspberry_pi_4b();

//                import("Raspberry Pi 4 Model B.stl");
        }; // end rotate
    }; // end translate*/
} // end difference

