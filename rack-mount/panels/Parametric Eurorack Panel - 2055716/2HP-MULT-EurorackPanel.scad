panelThickness = 3;
panelHp=21; //106.5mm
holeCount=6;
mountHoleDiameter = 3;
holeWidth = mountHoleDiameter+1; //If you want wider holes for easier mounting. Otherwise set to any number lower than mountHoleDiameter. Can be passed in as parameter to eurorackPanel()
hwCubeWidth = holeWidth>mountHoleDiameter ? holeWidth-mountHoleDiameter : 0;

// parameters for smooth circles
$fa = 6;
$fs = 0.2; // minimum segment length half the filament laid down (I usually run 0.4)

threeUHeight = 200;//133.35; // overall 3u height - 1U=44.45
//In Eurorack modular synthesizers, horizontal pitch (HP) is the standard unit for measuring module width, where 1 HP equals 0.2 inches (5.08 mm).//
hp=5.08; // horizontal pitch in mm
panelOuterHeight = 106.5; // from Eurorack documentation
offsetToMountHoleCenterY = 3; // from Eurorack documentation
offsetToMountHoleCenterX = panelHp<3 ? hp/2+hwCubeWidth/2 : hp+hwCubeWidth/2;
echo("offsetToMountHoleCenterY",offsetToMountHoleCenterY);
echo("offsetToMountHoleCenterX",offsetToMountHoleCenterX);

module eurorackPanel(panelHp,  mountHoles=2, hw = holeWidth, ignoreMountHoles=false)
{
    //mountHoles ought to be even. Odd values are -=1
    difference()
    {
        cube([hp*panelHp,panelOuterHeight,panelThickness]);
        
        if(!ignoreMountHoles)
        {
            eurorackMountHoles(panelHp, mountHoles, hw);
        }
    }
}

module eurorackMountHoles(php, holes, hw)
{
    holes = holes-holes%2;//mountHoles ought to be even for the sake of code complexity. Odd values are -=1
    eurorackMountHolesTopRow(php, hw, holes/2);
    eurorackMountHolesBottomRow(php, hw, holes/2);
}

module eurorackMountHolesTopRow(php, hw, holes)
{
    
    //topleft
    translate([offsetToMountHoleCenterX,panelOuterHeight-offsetToMountHoleCenterY,0])
    {
        eurorackMountHole(hw); 
    }
    if(holes>1)
    {
        translate([(hp*php)-hwCubeWidth-hp,panelOuterHeight-offsetToMountHoleCenterY,0])
    {
        eurorackMountHole(hw);
    }
    }
    if(holes>2)
    {
        holeDivs = php*hp/(holes-1);
        for (i =[1:holes-2])
        {
            translate([holeDivs*i,panelOuterHeight-offsetToMountHoleCenterY,0]){
                eurorackMountHole(hw);
            }
        }
    }
}

module eurorackMountHolesBottomRow(php, hw, holes)
{
    
    //bottomRight
    translate([(hp*php)-offsetToMountHoleCenterX,offsetToMountHoleCenterY,0])
    {
        eurorackMountHole(hw);
    }
    if(holes>1)
    {
        translate([offsetToMountHoleCenterX,offsetToMountHoleCenterY,0])
        {
        eurorackMountHole(hw);
        }
    }
    if(holes>2)
    {
        holeDivs = php*hp/(holes-1);
        for (i =[1:holes-2])
        {
            translate([holeDivs*i,offsetToMountHoleCenterY,0]){
                eurorackMountHole(hw);
            }
        }
    }
}

module eurorackMountHole(hw)
{
    mountHoleRad = mountHoleDiameter/2;
    mountHoleDepth = panelThickness+2; //because diffs need to be larger than the object they are being diffed from for ideal BSP operations
    
    hwCubeWidth = hwCubeWidth<0 ? 0 : hwCubeWidth;
    translate([0,0,panelThickness/2]){
        union()
        {
            cube([hwCubeWidth, mountHoleDiameter, mountHoleDepth], center=true);
            translate([-hwCubeWidth/2,0,0]){
                cylinder(r=mountHoleRad, h=mountHoleDepth, center=true);
            }
            translate([hwCubeWidth/2,0,0]){
                cylinder(r=mountHoleRad, h=mountHoleDepth, center=true);
            }
        }
    }
}

module aHole(hw)
{
    mountHoleRad = hw/2;
    mountHoleDepth = panelThickness+2; //because diffs need to be larger than the object they are being diffed from for ideal BSP operations

    translate([0,0,-1]){
        cylinder(r=mountHoleRad, h=mountHoleDepth);
    }
}
// interior holes
difference() {  
    eurorackPanel(panelHp, holeCount, holeWidth);
    
    // 0.1 inch (2.54mm) spacing
    
    holeOffset = 0.625*25.4;
    centerX = panelHp*hp/2;
    holeDiameter=3;
    translate([centerX,holeOffset,0]) aHole(holeDiameter);
    translate([centerX,holeOffset+1*0.5*25.4,0]) aHole(holeDiameter);
    translate([centerX,holeOffset+2*0.5*25.4,0]) aHole(holeDiameter);
    translate([centerX,holeOffset+3*0.5*25.4,0]) aHole(holeDiameter);
    
} 
// Eight 6mm Jack holes for making a passive mult
//difference() {  
//    eurorackPanel(panelHp, holeCount, holeWidth);
    
    // 6mm LED holes with 0.1 inch (2.54mm) spacing
//    holeOffset = 0.625*25.4;
//    centerX = panelHp*hp/2;
//    translate([centerX,holeOffset,0]) aHole(6);
//    translate([centerX,holeOffset+1*0.5*25.4,0]) aHole(6);
//    translate([centerX,holeOffset+2*0.5*25.4,0]) aHole(6);
//    translate([centerX,holeOffset+3*0.5*25.4,0]) aHole(6);
    
    // Skip a bit to provide distance (two groups of four) 
//    holeOffset2 = 2.875*25.4;
//    translate([centerX,holeOffset2+0*0.5*25.4,0]) aHole(6);    
//    translate([centerX,holeOffset2+1*0.5*25.4,0]) aHole(6);    
//    translate([centerX,holeOffset2+2*0.5*25.4,0]) aHole(6);
//    translate([centerX,holeOffset2+3*0.5*25.4,0]) aHole(6);
//}   
