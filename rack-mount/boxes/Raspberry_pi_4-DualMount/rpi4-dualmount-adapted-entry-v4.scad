include <../../common.scad>
use <../../plateBase.scad>

/*
  Adapted 10" Raspberry Pi 4 "DualMount" faceplate for rackstack.

  Source: 10-zoll_Raspberry_pi_4-DualMount_ohne_text.3mf -> rpi4-dualmount-from-3mf_v2.stl(via trimesh).

  This file:
   1. Re-orients the source: X=width, Y=height, Z=depth, front plate at Z=0,
      body extending backward (-Z) into the rack.
   2. Crops away the original 10" mounting ears (keeps x=[cropXMin,cropXMax],
      the Pi bay content, at true 1:1 scale).
   3. Cuts that footprint out of a plateBase() and drops the model's own
      perforated front plate into the gap - so the Pi bay openings and port
      cutouts pass cleanly through, instead of being covered by a solid slab.

  !!! Make sure the correct rack frame preset is set in config/rackFrame.scad !!!
*/

/*the 4U plate is 50mm tall while the model's plate is 44mm, so it's centered with about a 3mm frame above and below the bays. If you'd rather have that material distributed differently, plateU is the knob.*/
sourceFile = "rpi4-dualmount-from-3mf_v2.stl";
cropXMin = -90; cropXMax = 90;
panelHeight = 44.0; panelDepth = 103;
plateU = 4; plateThickness = 3;
screwToXEdge = 4.5; screwToYEdge = 5.0;

cropWidth = cropXMax - cropXMin;
screwDx = rackMountScrewWidth;
screwDy = uDiff * plateU;
targetCenterX = screwDx/2;
targetCenterY = screwDy/2;
coreCenterLocalY = panelHeight/2;
coreX0 = targetCenterX + cropXMin;
coreY0 = targetCenterY - coreCenterLocalY;

module correctedSource() {
  /*Orientation note: in the source, the FRONT plate is the Y=+51.5 face
  (not Y=-51.5). rotate([90,0,0]) puts it at Z=0 facing forward.*/
  translate([0, 22, -51.5]) rotate([90,0,0]) import(sourceFile);
}
module coreOnly() {
   /*the source is for a 10" rack - adjust for rackstack mini*/
  intersection() {
    correctedSource();
    translate([cropXMin, -20, -panelDepth-10])
      cube([cropWidth, panelHeight+40, panelDepth+20]);
  }
}
module placedCore() {
  translate([targetCenterX, coreY0, 0]) coreOnly();
}

union() {
  // plate with the core's footprint removed, so the model's own
  // perforated bezel occupies that area instead of a solid slab
  difference() {
    plateBase(U=plateU, plateThickness=plateThickness, screwToXEdge=screwToXEdge,
              screwToYEdge=screwToYEdge, screwType="m4", filletR=2);
    translate([coreX0, coreY0 + 0.001, -plateThickness-1])
      cube([cropWidth, panelHeight - 0.002, plateThickness+2]);
  }
  placedCore();
}
