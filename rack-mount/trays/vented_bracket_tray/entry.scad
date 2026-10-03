
// ===== Combined Assembly (Fixed): Entry Brackets + Honeycomb Tray =====
// - Uses your exact bracket geometry from entry.scad
// - Places right bracket using visualize=true so spacing = boxWidth
//
// Keep your project structure so `use <entry.scad>` resolves correctly.
use <../../angle-bracket/entry.scad>
//use <../honeycomb_bracket_tray/bracket.scad>;
include <../../common.scad>

// ---------------- User Parameters ----------------
boxWidth        = 195;
boxDepth        = 200;
//max depth for mini is 205
base_thickness  = 4.0;   // tray plate thickness
wall_thickness  = 4.0;   // forwarded to entry.scad's thickness
u               = 4;
sideVent        = false;

slotWidth =5; //Width of ventilation slots in mm (default: 2)
spacing = 40; // Distance between stripe centers in mm (default: 4)
borderX=10;  // solid margin left/right of the vent field, in mm
borderY=10;  // solid margin front/back of the vent field, in mm

// Vertical and bonding tweaks
baseZ = -wall_thickness; // Z of tray -wall_thickness places tray on print plate
bondOverlapX = 0.0;   // extend tray under rails in X (each side)
bondOverlapY = 0.0;   // extend slightly front/back in Y if desired


module vented_plate(plateWidth, plateLength, plateThickness) {
    // Solid border is borderX on left/right, borderY on front/back.
    // Everything inside this window gets vented; nothing outside it does.
    ventW = plateWidth  - 2*borderX;
    ventL = plateLength - 2*borderY;

    // Stripes run at 45 deg.  Build them in a frame centered on the middle of
    // the plate, so the field is symmetric and long enough to reach all four
    // corners of the vent window.
    perpSpacing = spacing / sqrt(2);   // center-to-center measured across the stripes
    n = ceil((ventW + ventL) / (2*spacing)) + 1;             // stripes each side of center
    stripeLen = sqrt(ventW*ventW + ventL*ventL) + 2*spacing; // over-long, gets clipped
    
    // Full bottom plate
    difference() {
        cube([plateWidth, plateLength, plateThickness], center=false);
        // Clip the stripe field to the centered window
       intersection() {
            translate([borderX, borderY, -plateThickness])
                cube([ventW, ventL, plateThickness*3], center=false);
            //add the stripes to the plate frame
            union() {
                for (k = [-n : 1 : n]) {
                    translate([plateWidth/2, plateLength/2, -plateThickness])
                    rotate([0, 0, 45])
                    translate([k*perpSpacing - slotWidth/2, -stripeLen/2, 0])
                    cube([slotWidth, stripeLen, plateThickness*3], center=false);
                }
            }
        }
    }
}

// ---------------- Bridge to your entry.scad ----------------
module __entry_brackets(
    wall_t = wall_thickness,
    width  = boxWidth,
    depth  = boxDepth,
    unit   = u,
    vent   = sideVent
) {
    // visualize=true so right rail is placed at x=boxWidth
    angleBrackets(
        visualize = true,
        thickness = wall_t,
        boxWidth  = width,
        boxDepth  = depth,
        u         = unit,
        sideVent  = vent
    );
}

// ---------------- Final Assembly ----------------
module angleBrackets_with_vented_tray(
    width        = boxWidth,
    depth        = boxDepth,
    base_h       = base_thickness,
    wall_t       = wall_thickness,
    unit         = u,
    vent         = sideVent,
    baseZ_in     = baseZ,
    bondOX       = bondOverlapX,
    bondOY       = bondOverlapY
) {
    union() {
        // 1) Brackets from your entry.scad
        __entry_brackets(wall_t=wall_t, width=width, depth=depth, unit=unit, vent=vent);

        // 2) Tray centered between x=[0,width] and y=[0,depth], with small overlap under rails
        translate([-bondOX, -bondOY, baseZ_in])
            vented_plate(width + 2*bondOX, depth + 2*bondOY, base_h);
    }
}

// Preview
angleBrackets_with_vented_tray();