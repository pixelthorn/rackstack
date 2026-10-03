// How thick the sides, top, and bottom of the case should be
case_thickness = 1.5;

// How much extra space to allow for the printed object to clear other parts without interfering with them
part_clearance = 0.3;

// How much extra space to add between objects that should press-fit into each other
press_fit_clearance = 0.2;

// Size of the ventilation holes, from vertex to opposite vertex
ventilation_hole_diameter = 3.2;

// Space between ventilation holes
ventilation_hole_spacing = 0.8;

// These two will probably be integrated into board-specific settings in the future
ribbon_slot_thin_width = 2;
ribbon_slot_thick_width = 17.5;

// Okay, so some notes about how this all works:
//
// The model attempts to be very parametrized.  Each Pi model is
// referenced be a string.  The known models are:
//
//  * "0" – All Pi Zero models without attached I/O pins
//  * "0H" – All Pi Zero models *with* attached I/O pins
//  * "1B" – The Pi 1B
//  * "1B+" – The Pi 1B+, 2B, and 3B
//  * "3B+" – The Pi 3B+
//  * "4B" – The Pi 4B
//
// We represent each model as a board with various components arranged
// arround the edges of the board.  Each component is defined as a
// rectangular solid; the SCAD model makes holes in the case for each one.
// Furthermore, each model also has definitions for the locations of the
// I/O pins and (vertically-oriented) ribbon cable connectors.  Holes are
// cut in the top of the case for each of those (though the I/O holes can
// be controlled by a module parameter).  Finally, each board has an area
// defined for ventilation holes; those should be placed over the CPU and
// any other heat-generating components.  A ventilation mesh will be
// opened in the top of the case in that area.
//
// The general board properties, plus the ventilation area, are defined in
// the `BOARD_DIMENSIONS` array.  The locations of a model's components
// are defined in the `BOARD_COMPONENTS` array.  The locations of the I/O
// pins and ribbon connectors are defined in the `BOARD_IO_HOLES` and
// `BOARD_RIBBON_SLOTS` arrays, respectively.  Component volume areas are
// defined in the `COMPONENTS` array; the component names in the
// `BOARD_COMPONENTS` array must match keys in the `COMPONENTS` array.

// A lot of the arrays function as dictionaries.  Each such array should
// contain a series of two-element arrays.  The first element is the key;
// the second element is the value.  There's a `get()` function defined
// below; it takes a key and an array as parameters.  If the key is
// present in the array, it returns the corresponding value.  (See the
// comment above the function definition for how it handles keys that
// aren't found.)

// For consistency of naming:
//
// RPi boards generally have an obvious top and bottom.  We'll always
// orient them so that:
//  * The top of the board is facing the positive Z axis
//  * The longer side of the board is parallel to the X axis
//  * The shorter side of the board is aprallel to the Y axis
//
// Furthermore, we'll orient the board so that the side with the SD card
// slot is closer to the negative side of the axis.
//
// That gives us the following six sides of the board:
//  * top: The top of the board, at a constant Z height
//  * bottom: the bottom of the board, at a constant Z height
//  * left: the side parallel to the Y axis, with the lower X coordinate
//  * right: the side parallel to the Y axis, with the higher X coordinate
//  * front: the side parallel to the X axis, with the lower Y coordinate
//  * back: the side parallel to the X axis, with the higher Y coordinate
//
// Graphically, looking down from above:
//
//            back
//    +--------------------+
//  l |   IO               | r
//  e |                   U| i
//  f |S       top        S| g
//  t |D                  B| h
//    |                    | t
//    +--------------------+
//            front
//
// * The distance from left to right is the width
// * The distance from front to back is the depth
// * The distance from bottom to top is the height (but for the base Pi,
//   the main vertical measurements are the board thickness and the
//   vertical clearance for the board's components)

// The way this works is that there's a "default" entry with measurements
// that are common across most boards.  Then each board has an entry with
// just the values that differ from the default.
//
// Vertical clearance is the height of the roof of the case above the
// board surface.  Minimum vertical clearance is the height of the roof of
// the case _without having to clear the IO pins_.  The latter is used
// when cutting holes for the pins to make the case a little slimmer.
//
// The mounting holes parameter should be an array of X, Y pairs.  Each
// pair gives the center of a hole, relative to the front left corner of
// the board.
//
// The ventilation area is a rectangle in which the ventilation holes will
// be cut.  It should be a four-element vector, with values left, front,
// width, and depth.  The left and front coordinates are relative to the
// front left corner of the board.
//
// Note that by default there is no defined area for ventilation holes, so
// every model should define at least that value.
BOARD_DIMENSIONS = [
  ["default", [
    ["width", 85],
    ["depth", 56],
    ["corner radius", 3],
    ["board thickness", 1.6],
    ["vertical clearance", 8.5],
    ["minimum vertical clearance", 6 + part_clearance],
    ["bottom clearance", 2.2],
    ["mounting holes", [
      [3.5,      3.5],
      [3.5 + 58, 3.5],
      [3.5,      3.5 + 49],
      [3.5 + 58, 3.5 + 49]]],
    ["mounting hole diameter", 2.75],
    ["ventilation area", [0, 0, 0, 0]]]],
  ["0", [
    ["width", 65],
    ["depth", 30],
    ["board thickness", 1.3],
    ["vertical clearance", 1.6 + part_clearance],
    ["minimum vertical clearance", 1.6 + part_clearance],
    ["bottom clearance", 0.7],
    ["mounting holes", [
      [3.5,      3.5],
      [65 - 3.5, 3.5],
      [3.5,      30 - 3.5],
      [65 - 3.5, 30 - 3.5]]],
    ["ventilation area", [22, 7, 32, 16]]]],
  ["0H", [
    ["width", 65],
    ["depth", 30],
    ["board thickness", 1.3],
    ["vertical clearance", 8.5],
    ["minimum vertical clearance", 1.6 + part_clearance],
    ["bottom clearance", 0.7],
    ["mounting holes", [
      [3.5,      3.5],
      [65 - 3.5, 3.5],
      [3.5,      30 - 3.5],
      [65 - 3.5, 30 - 3.5]]],
    ["ventilation area", [22, 7, 32, 16]]]],
  ["1B", [
    ["corner radius", 0],
    ["minimum vertical clearance", 7.7 + part_clearance],
    ["bottom clearance", 3.4],
    ["mounting holes", [
      [25.5,     18],
      [85 - 4.9, 56 - 12.6]]],
    ["ventilation area", [28, 15, 27, 26]],
    ["mounting hole diameter", 2.9]]],
  ["1B+", [
    ["ventilation area",
     let(left = 4 + 0.5 * ribbon_slot_thin_width + 2 * ventilation_hole_spacing,
         front = 11.5 + 0.5 * ribbon_slot_thick_width + 2 * ventilation_hole_spacing,
         right = 3.5 + 58,
         back = 56 - 3.5 - 2.54 - 2 * ventilation_hole_spacing)
       [left, front, right - left, back - front]]]],
  ["3B+", [
    ["ventilation area",
     let(left = 4 + 0.5 * ribbon_slot_thin_width + 2 * ventilation_hole_spacing,
         front = 11.5 + 0.5 * ribbon_slot_thick_width + 2 * ventilation_hole_spacing,
         right = 3.5 + 58 - 2.54 - 2 * ventilation_hole_spacing,
         back = 56 - 3.5 - 2.54 - 2 * ventilation_hole_spacing)
       [left, front, right - left, back - front]]]],
  ["4B", [
    ["ventilation area",
     let(left = 4 + 0.5 * ribbon_slot_thin_width + 2 * ventilation_hole_spacing,
         front = 11.5 + 0.5 * ribbon_slot_thick_width + 2 * ventilation_hole_spacing,
         right = 3.5 + 58 - 2.54 - 2 * ventilation_hole_spacing,
         back = 56 - 3.5 - 2.54 - 2 * ventilation_hole_spacing)
       [left, front, right - left, back - front]]]],
];

// Components are modeled as simple rectangular solids.  Give the 3D
// bounding box for each type of connector via "width", "depth", and
// "height" values.  Width is the distance parallel to the edge of the
// board on which the component is mounted.  Depth is the distance
// perpendicular to the board, including any distance the component
// projects outward from the edge.  (So if a component projects 2 mm in
// front of the board and extends 5 mm onto the board, its depth should be
// given as 7 mm.)  Height is the distance from the top of the board to
// the top of the component.
COMPONENTS = [
  ["audio", [
    ["width", 7],
    ["depth", 15],
    ["height", 6]]],
  ["audio (1B)", [
    ["width", 12.1],
    ["depth", 15.2],
    ["height", 9.8]]],
  ["composite video", [
    ["width", 10.1],
    ["depth", 19.3],
    ["height", 13]]],
  ["camera 22-pin", [
    ["width", 17],
    ["depth", 4.5],
    ["height", 1.3]]],
  ["dual usb a", [
    ["width", 13.8],
    ["depth", 17.3],
    ["height", 15.6]]],
  ["ethernet", [
    ["width", 16.1],
    ["depth", 21.2],
    ["height", 13.5]]],
  ["hdmi", [
    ["width", 15],
    ["depth", 12],
    ["height", 6]]],
  ["micro hdmi", [
    ["width", 7.2],
    ["depth", 8.5],
    ["height", 3.2]]],
  ["micro usb", [
    ["width", 8],
    ["depth", 5.7],
    ["height", 3]]],
  // The micro SD measurement includes the card as inserted into the slot.
  // The height includes enough space to clear the entire case above the
  // part of the card you pull to take it out.  Consequently, the depth is
  // _only_ enough to get a finger over the card edge; it doesn't cover
  // the full depth of the card slot, in contrast to how the other
  // components are modeled.
  ["micro sd", [
    ["width", 12],
    ["depth", 2.5],
    ["height", 10]]],
  ["mini hdmi", [
    ["width", 11.3],
    ["depth", 8],
    ["height", 3.4]]],
  ["usb c", [
    ["width", 9],
    ["depth", 7.5],
    ["height", 3.2]]],
];

// BOARD_COMPONENTS is a map of which components are on each board, ans
// where they are on the board.
//
// `side` should be "front", "back", "left", or "right".
//
// `position` is the X, Y position of the center, front, bottom point of
// the component, *relative to the side it's on*.  It's assumed that the
// bottom of the component is flush with the top of the board.
//
// Origins for each side are:
//
//  * front: board front left corner
//  * right: board front right corner
//  * back: board back right corner
//  * left: board back left corner
//
// In every case, the X value of the parameter moves along the side
// starting from the origin, while the Y value moves into (positive) or
// away from (negative) the board.
BOARD_COMPONENTS = [
  ["0", [
    ["micro sd", [
      ["side", "left"],
      ["position", [30 - 16.9, -2.5]]]],
    ["mini hdmi", [
      ["side", "front"],
      ["position", [12.4, -1]]]],
    ["micro usb", [
      ["side", "front"],
      ["position", [41.4, -1]]]],
    ["micro usb", [
      ["side", "front"],
      ["position", [54, -1]]]],
    ["camera 22-pin", [
      ["side", "right"],
      ["position", [15, -1]]]],
  ]],
  ["0H", [
    ["micro sd", [
      ["side", "left"],
      ["position", [30 - 16.9, -2.5]]]],
    ["mini hdmi", [
      ["side", "front"],
      ["position", [12.4, -1]]]],
    ["micro usb", [
      ["side", "front"],
      ["position", [41.4, -1]]]],
    ["micro usb", [
      ["side", "front"],
      ["position", [54, -1]]]],
    ["camera 22-pin", [
      ["side", "right"],
      ["position", [15, -1]]]],
  ]],
  ["1B", [
    ["micro usb", [
      ["side", "left"],
      ["position", [48.6, -0.5]]]],
    ["hdmi", [
      ["side", "front"],
      ["position", [44.2, -1.2]]]],
    ["ethernet", [
      ["side", "right"],
      ["position", [9.7, -1]]]],
    ["dual usb a", [
      ["side", "right"],
      ["position", [30.6, -7.3]]]],
    ["audio (1B)", [
      ["side", "back"],
      ["position", [20.1, -3.4]]]],
    ["composite video", [
      ["side", "back"],
      ["position", [38.8, -7.3]]]],
  ]],
  ["1B+", [
    ["micro usb", [
      ["side", "front"],
      ["position", [10.6, -1]]]],
    ["hdmi", [
      ["side", "front"],
      ["position", [32, -1.5]]]],
    ["audio", [
      ["side", "front"],
      ["position", [53.5, -2]]]],
    ["ethernet", [
      ["side", "right"],
      ["position", [10.25, -2]]]],
    ["dual usb a", [
      ["side", "right"],
      ["position", [29, -2]]]],
    ["dual usb a", [
      ["side", "right"],
      ["position", [47, -2]]]],
    ]],
  ["3B+", [
    ["micro usb", [
      ["side", "front"],
      ["position", [10.6, -1]]]],
    ["hdmi", [
      ["side", "front"],
      ["position", [32, -1.5]]]],
    ["audio", [
      ["side", "front"],
      ["position", [53.5, -2]]]],
    ["ethernet", [
      ["side", "right"],
      ["position", [10.25, -2]]]],
    ["dual usb a", [
      ["side", "right"],
      ["position", [29, -2]]]],
    ["dual usb a", [
      ["side", "right"],
      ["position", [47, -2]]]],
    ]],
  ["4B", [
    ["usb c", [
      ["side", "front"],
      ["position", [3.5 + 7.7, -1]]]],
    ["micro hdmi", [
      ["side", "front"],
      ["position", [3.5 + 7.7 + 14.8, -1]]]],
    ["micro hdmi", [
      ["side", "front"],
      ["position", [3.5 + 7.7 + 14.8 + 13.5, -1]]]],
    ["audio", [
      ["side", "front"],
      ["position", [3.5 + 7.7 + 14.8 + 13.5 + 7 + 7.5, -1]]]],
    ["dual usb a", [
      ["side", "right"],
      ["position", [9, -2]]]],
    ["dual usb a", [
      ["side", "right"],
      ["position", [27, -2]]]],
    ["ethernet", [
      ["side", "right"],
      ["position", [45.75, -2]]]],
  ]],
];

// Each member here is an X, Y pair giving the center of each hole for a
// ribbon cable.  It's assumed that ribbon cables are the same width
// across all Pi models.  The coordinates are relative to the front left
// corner of the board.
BOARD_RIBBON_SLOTS = [
  ["0", []],
  ["0H", []],
  ["1B", [
    [12, 28],
    [58, 11.5]]],
  ["1B+", [
    [4, 28],
    [32 + 13, 11.5]]],
  ["3B+", [
    [4, 28],
    [32 + 13, 11.5]]],
  ["4B", [
    [4, 3.5 + 24.5],
    [3.5 + 7.7 + 14.8 + 13.5 + 7, 11.5]
  ]],
];

// Each member here is a four-tuple of [X, Y, width, height], giving the
// position and dimensions of a hole to make room for a group of I/O pins
// on the board.  X and Y are relative to the front left corner of the
// board.
BOARD_IO_HOLES = [
  ["0", []],
  ["0H", [
    [3.5 + 29 - 10 * 2.54, 30 - 3.5 - 2.54, 20 * 2.54, 2 * 2.54]]],
  ["1B", [
    // Connectors are 1 mm from left of board, but let's just clear all the
    // way through the case on that side.
    let(left = 1,
        front = 56 - 1.5 - 2 * 2.54,
        width = 13 * 2.54,
        depth = 2 * 2.54,
        extra_left_space = 1 + part_clearance + case_thickness,
        extra_front_space = 1.27,
        extra_width = extra_left_space + 2.54,
        extra_depth = 2.54)
      [left - extra_left_space, front - extra_front_space, width + extra_width, depth + extra_depth]]],
  ["1B+", [
    [3.5 + 29 - 10 * 2.54, 56 - 3.5 - 2.54, 20 * 2.54, 2 * 2.54]]],
  ["3B+", [
    [3.5 + 29 - 10 * 2.54, 56 - 3.5 - 2.54, 20 * 2.54, 2 * 2.54],
    [3.5 + 58 - 1 * 2.54, 56 - 9.623 - 2.54, 2 * 2.54, 2 * 2.54]]],
  ["4B", [
    [3.5 + 29 - 10 * 2.54, 56 - 3.5 - 2.54, 20 * 2.54, 2 * 2.54],
    [3.5 + 58 - 1 * 2.54, 56 - 3.5 - 6.14 - 2.54, 2 * 2.54, 2 * 2.54],
  ]],
];


include <common.scad>
include <MCAD/polyholes.scad>
include <Round-Anything/polyround.scad>


// General function to treat an array of arrays as a dict.  `vector`
// should be an array of two-element arrays.  `key` should be a value
// matching the first element of one of those arrays.
//
//  * If `key` matches the first element of a `vector` member, the second
//    value of the member is returned
//  * If `key` doesn't match anything and `allow_nomatch` is true, undef
//    is returned
//  * If `key` doesn't match anything and `allow_nomatch` is true, an
//    error is signaled (by way of an assertion failure)
function get(key, vector, allow_nomatch=false) =
  let(result = search([key], vector)[0])
    is_list(result)
      ? allow_nomatch
        ? undef
        : echo("get", key=key, result=result, vector=vector)
            assert(false, "key not found")
      : vector[result][1];

// Looks up a property for a given board model.
function board_prop(model, property) =
  let(specific_prop = get(property, get(model, BOARD_DIMENSIONS, true), true),
      generic_prop = get(property, get("default", BOARD_DIMENSIONS)))
    is_undef(specific_prop) ? generic_prop : specific_prop;

function board_components(model) = get(model, BOARD_COMPONENTS);
function component_dimensions(component) = get(component, COMPONENTS);

shadow_line_lower_lip = 2 * case_thickness / 3;
shadow_line_upper_lip = 1 * case_thickness / 3;
function case_radius(model) = board_prop(model, "corner radius") + case_thickness + part_clearance;
function case_width(model) = board_prop(model, "width") + 2 * case_thickness + 2 * part_clearance;
function case_depth(model) = board_prop(model, "depth") + 2 * case_thickness + 2 * part_clearance;
function lower_case_height(model) = case_thickness + board_prop(model, "bottom clearance") + board_prop(model, "board thickness") + shadow_line_lower_lip;
function upper_case_height(model, slim) =
  case_thickness
  + (slim ? board_prop(model, "minimum vertical clearance") : board_prop(model, "vertical clearance"))
  - shadow_line_lower_lip;
function board_top(model) = case_thickness + board_prop(model, "bottom clearance") + board_prop(model, "board thickness");
function mounting_post_height(model) = min(2, board_prop(model, "minimum vertical clearance") - part_clearance);

function case_radii_points(model) = [
  [0,                 0,                 case_radius(model)],
  [case_width(model), 0,                 case_radius(model)],
  [case_width(model), case_depth(model), case_radius(model)],
  [0,                 case_depth(model), case_radius(model)],
];
function case_perimeter_points(dims) = polyRound(case_radii_points(dims), 90 / $fa);


module lower_case(model, print_position=true) {
  y_translation = board_prop(model, "width") + 2 * (case_thickness + part_clearance);
  translation = print_position ? [0, y_translation, 0] : [0, 0, 0];
  rotation = print_position ? -90 : 0;
  translate(translation)
    rotate(rotation, [0, 0, 1])
      difference () {
        lower_case_shell_and_posts(model);
        translate([case_thickness + part_clearance, case_thickness + part_clearance, board_top(model)]) {
          port_openings(model, "bottom", false);
        }
      }
}

module lower_case_shell_and_posts(model) {
  lower_case_shell(model);
  translate([case_thickness + part_clearance, case_thickness + part_clearance, case_thickness])
    for (pos = board_prop(model, "mounting holes"))
      translate(pos)
        mounting_post(model);
}

module lower_case_shell(model) {
  // floor
  linear_extrude(case_thickness)
    polygon(case_perimeter_points(model));
  difference() {
    // outer walls
    linear_extrude(lower_case_height(model))
      shell2d(-case_thickness)
      polygon(case_perimeter_points(model));
    // shadow line cutout
    translate([0, 0, lower_case_height(model) - shadow_line_lower_lip])
      linear_extrude(case_thickness)
      shell2d(-2 * case_thickness / 3, case_thickness)
      polygon(case_perimeter_points(model));
  }
}

module mounting_post(model) {
  cylinder(
    h=board_prop(model, "bottom clearance"),
    d=2 * board_prop(model, "mounting hole diameter"));
  cylinder(
    h=board_prop(model, "bottom clearance") + board_prop(model, "board thickness") + mounting_post_height(model),
    d=board_prop(model, "mounting hole diameter") - 2 * part_clearance,
    $fn=8);
}

// This is easiest to build from the top down.
module upper_case(model, io_holes=false, print_position=true) {
  x_translation = -board_prop(model, "width") - 2 * (case_thickness + part_clearance);
  y_translation = -board_prop(model, "depth") - 2 * (case_thickness + part_clearance);
  z_only_translation = upper_case_height(model) + board_top(model);
  xy_translation = print_position ? [x_translation, y_translation, 0] : [0, 0, 0];
  z_translation = print_position ? [0, 0, z_only_translation] : [0, 0, 0];
  rotation = print_position ? 180 : 0;
  translate(z_translation)
    rotate(rotation, [-1, 1, 0])
      translate(xy_translation)
        difference() {
          upper_case_lid(model, io_holes);
          translate([case_thickness + part_clearance, case_thickness + part_clearance, board_top(model)]) {
            port_openings(model, "top", io_holes);
            ribbon_slots(model);
            ventilation_holes(model);
            if (io_holes)
              io_slots(model);
          }
        }
}

module upper_case_lid(model, slim) {
  translate([0, 0, lower_case_height(model) + upper_case_height(model, slim)]) {
    // ceiling
    translate([0, 0, -case_thickness])
      linear_extrude(case_thickness)
      polygon(case_perimeter_points(model));
    // outer walls
    translate([0, 0, -upper_case_height(model, slim)])
      linear_extrude(upper_case_height(model, slim))
      shell2d(-case_thickness)
      polygon(case_perimeter_points(model));
    // shadow line lip
    translate([0, 0, -upper_case_height(model, slim) - shadow_line_upper_lip])
      linear_extrude(case_thickness)
        shell2d(-case_thickness / 3)
      polygon(case_perimeter_points(model));
    translate([case_thickness + part_clearance, case_thickness + part_clearance, 0])
      for (pos = board_prop(model, "mounting holes"))
        translate(pos)
          mounting_hole(model, slim);
  }
}

module mounting_hole(model, slim) {
  translate([0, 0, -upper_case_height(model, slim) - shadow_line_lower_lip])
  difference() {
    cylinder(
      h=upper_case_height(model, slim) + shadow_line_lower_lip - part_clearance,
      d=2 * board_prop(model, "mounting hole diameter"));
    translate([0, 0, -EXTRA_SPACE])
      cylinder(
        h=EXTRA_SPACE + mounting_post_height(model) + part_clearance,
        d=board_prop(model, "mounting hole diameter") - 2 * part_clearance + 2 * press_fit_clearance);
  }
}

module port_openings(model, side, slim) {
  components = board_components(model);
  for (component = components) {
    component_space(component[0], component[1], model, side, slim);
  }
  translate([-case_thickness - part_clearance - EXTRA_SPACE, board_prop(model, "depth") / 2, 0])
    rotate(-90, [0, 0, 1])
    connector_sd_card(side, model);
}

module orient_to_side(side, model) {
  if (side == "front") {
    children();
  } else if (side == "right") {
    translate([board_prop(model, "width"), 0, 0])
      rotate(90, [0, 0, 1])
        children();
  } else if (side == "back") {
    translate([board_prop(model, "width"), board_prop(model, "depth"), 0])
      rotate(180, [0, 0, 1])
        children();
  } else if (side == "left") {
    translate([0, board_prop(model, "depth"), 0])
      rotate(-90, [0, 0, 1])
        children();
  } else {
    echo(side=side);
    assert(false, "Unknown side.");
  }
}

// `board_side` is "top" or "bottom", depending on which side is being rendered.
module component_space(component_name, component_board_params, model, board_side, slim) {
  assert(!is_undef(is_top(board_side)));
  component_dims = component_dimensions(component_name);
  x_offset = get("position", component_board_params)[0];
  y_offset = get("position", component_board_params)[1];
  width = get("width", component_dims);
  height = get("height", component_dims);
  depth = get("depth", component_dims);
  distance_to_case_top = upper_case_height(model, slim) - height;
  extra_depth = case_thickness + part_clearance + EXTRA_SPACE + y_offset;
  extra_bottom_space = is_top(board_side) ? case_thickness : 0;
  extra_top_space = distance_to_case_top < case_thickness / 3 ? case_thickness : 0;
  orient_to_side(get("side", component_board_params), model)
    translate([x_offset - width / 2 - part_clearance, y_offset - extra_depth, -part_clearance - extra_bottom_space])
      cube([
        width + 2 * part_clearance,
        depth + part_clearance + extra_depth,
        height + 2 * part_clearance + extra_top_space + extra_bottom_space]);
}

module connector_sd_card(side, model) {
  assert(!is_undef(is_top(side)));
  // Only make space on the bottom.  The Pi Zero series puts the SD card
  // on the top of the board, so for those models we can skip making a
  // hole for it here and treat it as a normal surface component
  // elsewhere.
  if (!is_top(side) && model[0] != "0") {
    // The first generation Pis used full-size SD cards
    sd_card_offset = model == "1A" || model == "1B" ? -2 : 0;
    sd_card_width = model == "1A" || model == "1B" ? 28.3 : 12;
    sd_card_depth = case_thickness + part_clearance;
    sd_card_height = 3;
    translate([-sd_card_width / 2 + sd_card_offset, 0, -board_top(model) - EXTRA_SPACE])
      cube([sd_card_width, sd_card_depth, lower_case_height(model) + case_thickness]);
  }
}

ribbon_radii_points = [
  [-ribbon_slot_thin_width / 2 - part_clearance, -ribbon_slot_thick_width / 2 - part_clearance, ribbon_slot_thin_width / 2 + part_clearance],
  [ ribbon_slot_thin_width / 2 + part_clearance, -ribbon_slot_thick_width / 2 - part_clearance, ribbon_slot_thin_width / 2 + part_clearance],
  [ ribbon_slot_thin_width / 2 + part_clearance,  ribbon_slot_thick_width / 2 + part_clearance, ribbon_slot_thin_width / 2 + part_clearance],
  [-ribbon_slot_thin_width / 2 - part_clearance,  ribbon_slot_thick_width / 2 + part_clearance, ribbon_slot_thin_width / 2 + part_clearance],
];

module ribbon_slots(model) {
  slots = get(model, BOARD_RIBBON_SLOTS);
  for (slot = slots) {
    translate(slot)
      linear_extrude(upper_case_height(model) + case_thickness)
        polygon(polyRound(ribbon_radii_points, 90 / $fa));
  }
}

module io_slots(model) {
  slots = get(model, BOARD_IO_HOLES);
  for (slot = slots) {
    translate([slot[0] - part_clearance, slot[1] - part_clearance, 0])
      cube([slot[2] + 2 * part_clearance, slot[3] + 2 * part_clearance, upper_case_height(model) + case_thickness]);
  }
}

// TODO: Put partial hexagons at the left and right sides of the area?
module ventilation_holes(model) {
  area = board_prop(model, "ventilation area");
  area_left = area[0];
  area_front = area[1];
  area_width = area[2];
  area_depth = area[3];
  hex_width = ventilation_hole_diameter;
  hex_depth = ventilation_hole_diameter * tan(60) / 2;
  dx = 1.5 * hex_width + 2 * ventilation_hole_spacing * cos(30);
  dy = hex_depth + ventilation_hole_spacing;
  extra_x_space = (area_width + 2 * ventilation_hole_spacing * cos(30)) % (dx / 2);
  extra_y_space = (area_depth + ventilation_hole_spacing) % dy;
  y_cells = floor((area_depth + ventilation_hole_spacing) / dy);
  min_x = area_left + hex_width / 2 + extra_x_space / 2;
  max_x = area_left + area_width - hex_width / 2;
  min_y = area_front + hex_depth / 2 + extra_y_space / 2;
  max_y = area_front + area_depth - hex_depth / 2;
  for (x = [min_x:dx:max_x])
    for (y = [min_y:dy:max_y])
      translate([x, y])
        cylinder(d=ventilation_hole_diameter, h=upper_case_height(model) + case_thickness, $fn=6);
  for (x = [min_x + dx / 2:dx:max_x])
    for (y = [min_y + dy / 2:dy:max_y])
      translate([x, y])
        cylinder(d=ventilation_hole_diameter, h=upper_case_height(model) + case_thickness, $fn=6);
  edge_hex_side = hex_width / 2 - ventilation_hole_spacing / (2 * sin(60));
  side_x_offsets = [-hex_width / 4 - edge_hex_side * cos(60), -hex_width / 4, hex_width / 4, hex_width / 4 + edge_hex_side * cos(60)];
  side_y_offsets = [edge_hex_side * sin(60), 0, 0, edge_hex_side * sin(60)];
  for (x = [min_x + dx / 2:dx:max_x]) {
    linear_extrude(upper_case_height(model) + case_thickness)
      let(base_y = min_y - ventilation_hole_spacing / 2)
        polygon([ for (i = [0:1:len(side_x_offsets)-1]) [x + side_x_offsets[i], base_y - side_y_offsets[i]] ]);
    linear_extrude(upper_case_height(model) + case_thickness)
      let(base_y = min_y + dy * (y_cells - 1) + ventilation_hole_spacing / 2)
        polygon([ for (i = [0:1:len(side_x_offsets)-1]) [x + side_x_offsets[i], base_y + side_y_offsets[i]] ]);
  }
}

function is_top(side) =
  side == "top"
  ? true
  : side == "bottom"
    ? false
  : undef;


color("#4363d8")
  lower_case("0", print_position=false);
color("#ffe11955")
  upper_case("0", true, print_position=false);

translate([0, 50, 0]) {
  color("#4363d8")
    lower_case("0H", print_position=false);
  color("#ffe11955")
    upper_case("0H", true, print_position=false);
}

translate([-100, 300, 0]) {
  color("#4363d8")
    lower_case("1B", print_position=false);
  color("#ffe11955")
    upper_case("1B", true, print_position=false);
}

translate([-100, 200, 0]) {
  color("#4363d8")
    lower_case("1B+", print_position=false);
  color("#ffe11955")
    upper_case("1B+", true, print_position=false);
}

translate([-100, 100, 0]) {
  color("#4363d8")
    lower_case("3B+", print_position=false);
  color("#ffe11955")
    upper_case("3B+", true, print_position=false);
}

translate([-100, 0, 0]) {
  color("#4363d8")
    lower_case("4B", print_position=false);
  color("#ffe11955")
    upper_case("4B", true, print_position=false);
}
