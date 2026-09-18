include <../common.scad>
use <../plateBase.scad>

// Creates blank plate with opening
// U: Height in rack units (1, 2, 3, etc.)
// plateThickness: Thickness of the plate in mm (default: 3)
// screwType: Mounting screw type (default: "m4")
// filletR: Corner fillet radius in mm (default: 2)
// borderX: Margin from left/right edges in mm (default: 10)
// borderY: Margin from top/bottom edges in mm (default: 3)

module ventilatedPlate(U, plateThickness=3, screwType="m4", filletR=2,borderX=10, borderY=3) {
    difference() {
        plateBase(U=U, plateThickness=plateThickness, screwType=screwType, filletR=filletR);
        screwDx = rackMountScrewWidth;
        screwDy = uDiff * U;
        screwToEdge = 4.5;

        plateLength = screwDx + 2*screwToEdge;
        plateHeight = screwDy + 2*screwToEdge;


        translate([-screwToEdge, -screwToEdge, 0]) {
            intersection() {
                translate([borderX, borderY, -plateThickness])
                cube([plateLength - 2*borderX, plateHeight - 2*borderY, plateThickness*2], center=false);


            }
        }
    }
}


ventilatedPlate(U=10, borderX=20);
