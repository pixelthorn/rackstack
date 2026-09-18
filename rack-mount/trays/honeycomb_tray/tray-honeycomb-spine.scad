include <../../common.scad>
use <../../rackEars.scad>

// --- honeycomb helpers, lifted from catalog/honeycomb-tray/entry.scad ---
module __hex2d(side) {
    polygon(points=[ for (i=[0:5]) [ side*cos(60*i), side*sin(60*i) ] ]);
}

module __honeycomb_plate(width, depth, plate_h, side, wall, rim, spine_x=-1, spine_w=0) {
    difference() {
        cube([width, depth, plate_h], center=false);
        x_step = 1.5 * side;
        y_step = sqrt(3) * side;
        w = width - 2*rim;
        d = depth - 2*rim;
        translate([rim, rim, 0])
        union() {
            for (ix = [0 : ceil(w / x_step) + 1]) {
                x = side + ix * x_step;
                y_off = (ix % 2) * (y_step/2);
                for (iy = [0 : ceil(d / y_step) + 1]) {
                    y = y_off + iy * y_step;
                    // skip any hex whose center falls inside the spine band
                    inSpine = (spine_w > 0) && (abs((x+rim) - spine_x) < spine_w/2 + side);
                    if (x >= 0 && x <= w && y >= 0 && y <= d && !inSpine) {
                        translate([x, y, 0])
                            linear_extrude(height=plate_h + 0.05)
                                __hex2d(max(0.01, side - wall));
                    }
                }
            }
        }
    }
}

module bottomScrewTray(u, trayWidth, trayDepth, trayThickness, mountPoints, mountPointElevation, mountPointType, frontThickness, sideThickness, frontLipHeight, backLipHeight, trayLeftPadding, sideSupport=true,
  hex_side=6, cell_wall=1.5, rim_width=3) {   // <-- new honeycomb params

  lipThickness = sideThickness;
  screwDx = rackMountScrewWidth;
  screwDz = uDiff * u;
  plateLength = screwDx + 2*rackMountScrewXDist;
  plateHeight = screwDz + 2*rackMountScrewZDist;
  minScrewToTraySpacing = railScrewHoleToInnerEdge;
  leftScrewDistToTray = minScrewToTraySpacing + trayLeftPadding;
  leftScrewGlobalX = -leftScrewDistToTray;
  rightScrewGlobalX = screwDx + leftScrewGlobalX;

  assert(trayWidth <= screwDx-(2*minScrewToTraySpacing + trayLeftPadding));

  difference() {
    applyMountHoles()
    translate(v = [-sideThickness, -frontThickness, -trayThickness])
    body();
  }

  module body() {

    // honeycomb base instead of a solid cube
    __honeycomb_plate(trayWidth, trayDepth, trayThickness, hex_side, cell_wall, rim_width, spine_x=trayWidth/2, spine_w=14);

    // front lip
    translate(v = [0, 0, trayThickness])
    cube(size = [trayWidth, lipThickness, frontLipHeight]);

    // back lip
    translate(v = [0, trayDepth-lipThickness, trayThickness])
    cube(size = [trayWidth, lipThickness, backLipHeight]);

    translate(v = [leftScrewGlobalX, 0, rackMountScrewZDist])
    rackEarModule(frontThickness = frontThickness, sideThickness = sideThickness, frontWidth =
        leftScrewDistToTray+rackMountScrewXDist+sideThickness, sideDepth = trayDepth-lipThickness, u = u, backPlaneHeight=trayThickness+backLipHeight, support=sideSupport);

    translate(v = [rightScrewGlobalX, 0, rackMountScrewZDist])
    mirror(v = [1, 0, 0])
    rackEarModule(frontThickness = frontThickness, sideThickness = sideThickness, frontWidth =
       rightScrewGlobalX-trayWidth+rackMountScrewXDist+sideThickness, sideDepth = trayDepth-lipThickness, u = u, backPlaneHeight=trayThickness+backLipHeight, support=sideSupport);
  }

  module applyMountHoles() {
    mountPointPosThickness = 2;
    if (len(mountPoints) > 0) {
      apply_pn() {
        for (i = [0:len(mountPoints)-1]) {
          x = mountPoints[i][0]; y = mountPoints[i][1];
          translate(v = [x, y, 0])
          cylinder(r = screwRadiusSlacked(mountPointType)+mountPointPosThickness, h = mountPointElevation);
        }
        for (i = [0:len(mountPoints)-1]) {
          x = mountPoints[i][0]; y = mountPoints[i][1];
          translate(v = [x, y, -trayThickness])
          mirror(v = [0, 0, 1])
          counterSunkHead_N(mountPointType, inf, inf);
        }
        children(0);
      }
    } else {
      children(0);
    }
  }
}