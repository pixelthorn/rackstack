use <../tray/tray.scad>

/*
  Simple tray with front plate. 
  
  Please make sure to configure the correct rack frame dimensions in rackFrame.scad.
*/
rackunits=4;
trayWidth = 205;
trayDepth = 200;
thickness = 3;
backLipHeight = 6;

sideSupport = true; // extra support if space allows
trayLeftPadding = 0;// extra space between the left rail and tray. configure this to move the tray left/right.

// for screw holes
mountPoints = [];
mountPointType = "m3";
mountPointElevation = 1; // basically standoff height


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

