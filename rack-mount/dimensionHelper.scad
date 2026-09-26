include <./common.scad>

// OpenSCAD script to output some helpful dimensions for creating new rack-mount items:

echo("Vertical distance between 2 main rail hole centers (screwDiff): ", screwDiff);
echo("Horizontal distance between 2 opposing main rail holes (rackMountScrewWidth): ", rackMountScrewWidth);

echo("Distance between main rail screw, and main rail inner edge (railScrewHoleToInnerEdge):", railScrewHoleToInnerEdge);
echo("Distance between main rail screw, and main rail outer edge (railScrewHoleToOuterEdge):", railScrewHoleToOuterEdge);
echo("Max supported rack-mount width (maxUnitWidth): ", maxUnitWidth);
echo("Max recommended rack-mount depth (maxUnitDepth): ", maxUnitDepth);

echo("Z axis length between screws(rackMountScrewXDist): ",rackMountScrewXDist );
echo("X axis length between screws(rackMountScrewZDist): ",rackMountScrewZDist );


