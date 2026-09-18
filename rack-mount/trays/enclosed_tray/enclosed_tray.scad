use <../tray/tray.scad>

/*
  Simple tray with front plate
  
  Please make sure to configure the correct rack frame dimensions in rackFrame.scad.
*/


difference () {
    bottomScrewTray (
        u = 2,
        trayWidth = 140,
        trayDepth = 140,
        trayThickness = 3,
        frontLipHeight = 26,
        backLipHeight = 6,
        mountPoints = [[15, 15], [15+105, 15],[15, 15+105], [15+105, 15+105]],
        frontThickness = 3,
        sideThickness = 3,
        mountPointElevation = 1,
        mountPointType = "m4",
        sideSupport = true,
        trayLeftPadding = 15
        );

    }