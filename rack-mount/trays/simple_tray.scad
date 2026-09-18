use <tray/tray.scad>

/*
  Simple tray with no lips on edges

  Please make sure to configure the correct rack frame dimensions in rackFrame.scad.
  
  Remember to use Velcro strips to secure the drive to the tray!
*/

bottomScrewTray (
    u = 4,
    trayWidth = 195,
    trayDepth = 175,
    trayThickness = 3,
    frontLipHeight = 0,
    backLipHeight = 0,
    mountPoints = [],
    frontThickness = 3,
    sideThickness = 3,
    mountPointElevation = 1,
    mountPointType = "m3",
    sideSupport = false,
    trayLeftPadding = 5 // extra space between the left rail and tray. configure this to move the tray left/right.
);
