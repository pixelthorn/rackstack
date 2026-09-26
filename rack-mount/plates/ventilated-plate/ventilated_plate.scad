include <../../common.scad>
use <../../plateBase.scad>

// Creates a ventilated blank plate with diagonal stripes

// ---------------- User Parameters ----------------
U               = 15;
plateThickness  = 3.0;  // tray plate thickness
slotWidth       = 15;  //Width of ventilation slots in mm
spacing         = 50;   // Distance between stripe centers in mm - must be larger than slotWidth
borderX         = 10;   // solid margin left/right of the vent field, in mm
borderY         = 10;   // solid margin front/back of the vent field, in mm
screwType       = "m4"; // Mounting screw type (default: "m4")
filletR         = 2;    // corner radius, Default = 2
// ------------------------------------------------


module ventilatedPlate(
        U=U,
        plateThickness=plateThickness,
        screwType=screwType,
        slotWidth=slotWidth,
        spacing=spacing,
        borderX=borderX, 
        borderY=borderY
) {
    screwToEdge = 4.5;
    angle = 45;
    screwDx = rackMountScrewWidth;
    screwDy = uDiff * U;
    plateWidth = screwDx + 2*screwToEdge;  // X axis 
    plateDepth = screwDy + 2*screwToEdge;  // Y axis
    
    // Create the vents
    // Solid border is borderX on left/right, borderY on front/back.
    // Everything inside this window gets vented; nothing outside it does.
    ventW = plateWidth  - 2*borderX;
    ventL = plateDepth - 2*borderY;

    if (slotWidth >= spacing)
        echo("Warning: slotWidth >= spacing, so the vent field has no solid ribs between stripes.");

    // Stripes run at 45 deg.  Build them in a frame centered on the middle of
    // the plate, so the field is symmetric and long enough to reach all four
    // corners of the vent window.
    perpSpacing = spacing;             // center-to-center measured across the stripes
    n = ceil((ventW + ventL) / (2*spacing)) + 1;             // stripes each side of center
    stripeLen = sqrt(ventW*ventW + ventL*ventL) + 2*spacing; // over-long, gets clipped
    
    // Full plate
    difference() {
        plateBase(U=U, plateThickness=plateThickness, screwType=screwType, filletR=filletR);
        
        // Match the plateBase local frame so the vent field is truly centered.
        translate([-screwToEdge, -screwToEdge, 0])
        intersection() {
            translate([borderX, borderY, -plateThickness])
                cube([ventW, ventL, plateThickness*3], center=false);

            union() {
                for (k = [-n : 1 : n]) {
                    translate([plateWidth/2, plateDepth/2, -plateThickness])
                    rotate([0, 0, angle])
                    translate([k*perpSpacing - slotWidth/2, -stripeLen/2, 0])
                    cube([slotWidth, stripeLen, plateThickness*3], center=false);
                }
            }
        }
      }  
} 

ventilatedPlate();

