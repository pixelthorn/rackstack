
// ===== Combined Assembly (Fixed): Entry Brackets + Solid Tray =====
// - Uses your exact bracket geometry from entry.scad
// - Places right bracket using visualize=true so spacing = boxWidth
//
// Keep your project structure so `use <entry.scad>` resolves correctly.
use <bracket.scad>;

// ---------------- User Parameters ----------------
boxWidth        = 175;
//boxWidth        = 202;
boxDepth        = 180;
//boxDepth        = 145;
//max depth for mini is 205
base_thickness  = 3.0;   // tray plate thickness
wall_thickness  = 1.0;   // forwarded to entry.scad's thickness
u               = 4;
sideVent        = false;



// Vertical and bonding tweaks
baseZ      = -wall_thickness;     // Z of tray 
bondOverlapX = 0.0;   // extend tray under rails in X (each side)
bondOverlapY = 0.0;   // extend slightly front/back in Y if desired


module __solid_plate(width, depth, plate_h) {
    // Full plate, then subtract ONLY the inner hex cores inside the rim area.
    difference() {
        cube([width, depth, plate_h], center=false);
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
module angleBrackets_with_solid_tray(
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
            __solid_plate(width + 2*bondOX, depth + 2*bondOY, base_h);
    }
}

// Preview
angleBrackets_with_solid_tray();