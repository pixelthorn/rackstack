use <./tray-honeycomb.scad>

/*
  Parametric rack-mount tray:
  Dimensions can be adjusted using the variables below. You can also add mounting holes to fasten things that have
  screw holes at the bottom.

  !!! Please also make sure that the correct rack frame preset is set in rackFrame.scad !!!
*/

module traySystem (

trayU = 2,

baseWidth = 195,
baseDepth = 185,

baseThickness = 3,
frontThickness = 3,
sideThickness = 3,

backLipHeight = 2,
frontLipHeight = 2,

sideSupport = false,
trayLeftPadding = 10,

mountPointType = "m3",
mountPointElevation = 1,

mountPoints = [],

// Honeycomb
hex_side = 4.0,
cell_wall = 1.5,
rim_width = 3.0

) {

  bottomScrewTray (
    u = trayU,
    trayWidth = baseWidth,
    trayDepth = baseDepth,
    trayThickness = baseThickness,
    frontLipHeight = frontLipHeight,
    backLipHeight = backLipHeight,
    mountPoints = mountPoints,
    frontThickness = frontThickness,
    sideThickness = sideThickness,
    mountPointElevation = mountPointElevation,
    mountPointType = mountPointType,
    sideSupport = sideSupport,
    trayLeftPadding = trayLeftPadding,
    hex_side = hex_side,
    cell_wall = cell_wall,
    rim_width = rim_width
  );
}

traySystem();