include <../../common.scad>
use <../../plateBase.scad>

/*
  Adapted 10" Raspberry Pi 4 "DualMount" faceplate for rackstack.

  The original file (10-zoll_Raspberry_pi_4-DualMount_ohne_text.stl) was designed
  for a generic 10-inch rack: 254mm outer width, ~236mm hole-to-hole spacing.
  It's also stored rotated ~41.7deg in its own coordinate frame (a print-bed-fitting
  trick), rather than axis-aligned.

  This file:
   1. Un-rotates the source STL back to axis-aligned.
   2. Crops away the original 10" mounting ears (kept only x=[cropXMin, cropXMax],
      which is the untouched Raspberry Pi bay content at true 1:1 scale).
   3. Mounts that untouched core onto a plateBase() sized for whatever rackstack
      profile is active in config/rackFrame.scad (mini by default: 224mm outer
      width, 215mm hole spacing).

  !!! Please also make sure that the correct rack frame preset is set in rackFrame.scad !!!
*/

// begin config ////////////////////////////////////////////////////////////////////////////////////////////////////////

sourceFile = "rpi4-dualmount-meshfixed.stl"; // repaired with pymeshfix - the original STL's mesh

// Empirically-found values (do not need to change unless you re-measure the source STL):
sourceRotationZ = 41.70;                          // degrees, un-rotates the STL to axis-aligned
sourceTranslate = [119.93005607, -135.0690859, 0]; // shifts the rotated STL's bounding box to start at the origin

// Measured (in the un-rotated frame) extent of the untouched Pi-bay content.
// Everything outside [cropXMin, cropXMax] is the original 10" mounting ears, discarded.
cropXMin = 35;
cropXMax = 220;
panelHeight = 44.02;  // measured un-rotated height (Y) of the source panel
panelDepth  = 103;    // measured depth (Z) of the source panel

plateU = 4;            // rack units tall for the new mounting plate
plateThickness = 3;
screwToXEdge = 4.5;
screwToYEdge = 5.0;

// end config //////////////////////////////////////////////////////////////////////////////////////////////////////////

cropWidth = cropXMax - cropXMin;

screwDx = rackMountScrewWidth;
screwDy = uDiff * plateU;
plateLength = screwDx + 2*screwToXEdge;
plateHeight = screwDy + 2*screwToYEdge;

echo("New plate size (mini): ", plateLength, " x ", plateHeight);
echo("Cropped core width kept from source: ", cropWidth);

targetCenterX = screwDx/2;
targetCenterY = screwDy/2;
coreCenterLocalX = (cropXMin + cropXMax)/2;
coreCenterLocalY = panelHeight/2;

module correctedSource() {
  translate(sourceTranslate)
  rotate([0, 0, sourceRotationZ])
  import(sourceFile);
}

module coreOnly() {
  intersection() {
    correctedSource();
    translate([cropXMin, -20, -5])
      cube([cropWidth, panelHeight+40, panelDepth+10]);
  }
}

module placedCore() {
  translate([targetCenterX - coreCenterLocalX, targetCenterY - coreCenterLocalY, 0])
  mirror([0, 0, 1])          // flip so the panel's tray structure extends backward (-Z),
  coreOnly();                // matching plateBase()'s own front-face-at-Z=0 convention
}

union() {
  plateBase(U=plateU, plateThickness=plateThickness, screwToXEdge=screwToXEdge, screwToYEdge=screwToYEdge, screwType="m4", filletR=2);
  placedCore();
}
