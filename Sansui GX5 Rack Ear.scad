/*
 ____                             _     ____ __  __      ____
/ ___|   __ _  _ __   ___  _   _ (_)   / ___|\ \/ /     | ___|
\___ \  / _` || '_ \ / __|| | | || |  | |  _  \  / _____|___ \
 ___) || (_| || | | |\__ \| |_| || |  | |_| | /  \|_____|___) |
|____/  \__,_||_| |_||___/ \__,_||_|   \____|/_/\_\     |____/

Sansui GX-5 rack mounting ear model
Parameterised for use with multiple Sansui components
2021 - Simon Laszcz 

All measurements are in millimetres (mm)

DISCLAIMER
~~~~~~~~~~
- This model has been made public in good faith, but:
- It has NOT been tested with a wide variety of components. It has been shown to work for the SE-9.
- Proportions and relative dimensions were taken from the handles to hand. The intention was to create a functional
rack ear rather than an identical copy. The handle was ommited to reduce 3D printing cost.
- No responsibility will be accepted for printed ears that do not fit the intended component.
- No responsibility will be accepted for printed ears that break or fail to support the intended component.
- You should ensure that parameter measurements are accurate.
- Some parameters may be tweaked to reduce printing cost but the resulting strengh of the printed part must be considered.
- You should print cheap prototypes before committing to a more expensive final print.
- The final print should be made using a material strong enough to support the intended component,
e.g. Carbon-fibre Nylon (CF Nylon) or similar.

NOMENCLATURE
~~~~~~~~~~~~
- Ear: A rack mount handle without a handle, i.e. only those parts required to attach a component to a rack.
- Component: e.g. SE-9, AX-7
- Faceplate: Switch and dial mounting plate attached to the front of the case.
- Ear case fixing: That part of the rack ear attached to the component case.
- Ear rack fixing: That part of the rack ear attached to the GX-5 rack.
*/

///////////////
//  PARAMETERS
///////////////

//  Height of the component's faceplate. Defines the size of the ear
case_faceplate_height = 140;
//  The amount the component faceplate overhangs the case on one side
case_faceplate_overhang_x = 1;
//  The amount the component faceplate overhangs the top of the case. If it's nearly flush set this to 1
case_faceplate_overhang_top = 1;
//  The amount the component faceplate overhangs the bottom of the case
case_faceplate_overhang_bottom = 3;
//  The faceplate on the SE-9 is rolled over the top of the case. When looking side-on, this is the width
//  Use the furl dimensions, along with case_faceplate_overhang_x to dictate the size of the notches printed on the ear case fixing
case_furl_width = 10;
//  The faceplate on the SE-9 is rolled over the top of the case. When looking side-on, this is the height
case_furl_height = 5;
//  Thickness of the component faceplate when looking front-on
case_faceplate_thickness = 2;
//  X distance of the screw hole centre from the front of the case (not including faceplate)
case_screw_x = 22;
//  Y distance of the screw hole centre from the top of the case
case_top_screw_y = 30;
//  Y distance of the screw hole centre from the top of the case
case_bottom_screw_y = 110;
//  Distance between top of case and top of case fixing. Tweak to reduce printing costs but beware that too big a margin will reduce strength
case_side_margin_y = 5;

//////////////////////////////////////
//  COMPUTED/CONSTANTS
//  Probably no need to change these
//////////////////////////////////////

//  CONSTANT. Diameter of screw hole
screw_hole_diameter = 5;
//  CONSTANT. Countersink dimension
screw_hole_countersink_diameter = 14;
//  CONSTANT. Countersink dimension
screw_hole_countersink_depth = 1;
//  CONSTANT. Computed height of the case
case_height = case_faceplate_height - case_faceplate_overhang_top - case_faceplate_overhang_bottom;
//  CONSTANT. Height of the ear part that fixes to the case
ear_case_fixing_height = case_height - (case_side_margin_y * 2);
//  CONSTANT. Width of the ear part that fixes to the case
ear_case_fixing_width = 46;
//  CONSTANT. Depth of the ear part through which the ear is screwed to the case
ear_case_fixing_screw_plate_depth = 6;
//  CONSTANT. Width (front-on) of the ear rack fixing
ear_rack_fixing_width = 25;
//  CONSTANT. Thickness of the ear rack fixing
ear_rack_fixing_thickness = 5;
//  CONSTANT. Radius of corners nearest rear of the case
ear_case_fixing_corner_radius = 4;
//  CONSTANT. Slot dimension
ear_rack_fixing_slot_width = 7;
//  CONSTANT. Slot dimension
ear_rack_fixing_slot_length = 15;
//  CONSTANT. Distance from top/bottom of the rack fixing to the edge of the fixing slot, expressed as a %age of the rack fixing's height
ear_rack_fixing_slot_pc_from_edge = 0.13;
//  CONSTANT. Overall resolution
$fn = 50;

/////////////////////////
//  VALIDATION
//  n.b. Not exhaustive
/////////////////////////

assert(case_side_margin_y >= 0 && case_side_margin_y <= 10, "case_side_margin_y outside range 1..10");
assert(case_top_screw_y - (screw_hole_countersink_diameter / 2) > case_side_margin_y, "Top screw would be within case_side_margin_y");

////////////
//  MODEL
////////////

color("grey") {
    difference() {
        ear_rack_fixing();
        ear_rack_fixing_slot_masks();
    }
    difference() {
        ear_case_fixing();
        ear_case_fixing_faceplate_notches();
        ear_case_fixing_screw_masks();
    }
}

module ear_rack_fixing() { 
    chamfer = ear_rack_fixing_thickness / 2;
    dx = ear_rack_fixing_thickness - case_faceplate_thickness;
    dy = ear_rack_fixing_width + case_faceplate_overhang_x;
    dz = (case_faceplate_height - ear_case_fixing_height) / 2;
    
    translate([dx, dy, -dz]) {
        rotate([90, 270, 0])
        linear_extrude(ear_rack_fixing_width)
        //  Profile of the longest side. Length depends on faceplate height. Other dimensions are fixed
        polygon([
            [0, 0],
            [case_faceplate_height, 0],
            [case_faceplate_height, chamfer],
            [case_faceplate_height - chamfer, ear_rack_fixing_thickness],
            [chamfer, ear_rack_fixing_thickness],
            [0, chamfer]]);
    }
}

module ear_rack_fixing_slot_masks() {
    //  Slot radius
    rad = ear_rack_fixing_slot_width / 2;
    //  The rack fixing is offset on the z-axis by -dz
    dz = (case_faceplate_height - ear_case_fixing_height) / 2;
    //  Distance to centre of slot from top/bottom edge
    d = (case_faceplate_height * ear_rack_fixing_slot_pc_from_edge) + rad;   
    //  Top slot distance
    dz_top =  -dz + case_faceplate_height - d;
    //  Bottom slot
    dz_bottom = -dz + d;
    //  Gap between slot and edge of rack fixing
    dy = ear_rack_fixing_width - ear_rack_fixing_slot_length;
    mask_dy = case_faceplate_thickness + dy + (ear_rack_fixing_slot_length * 2) + rad;

    translate([-(ear_rack_fixing_thickness * 2), mask_dy, dz_top])
    rotate([0, 90, -90])
    //  Slot mask
    hull() {    
        //  Make the shape arbitrarily big enough to create the slot without rounding errors
        translate([0, 0, ear_rack_fixing_slot_length * 2]) rotate([-90, 0, 0]) cylinder(ear_rack_fixing_thickness * 4, rad, rad);
        rotate([-90, 0, 0]) cylinder(ear_rack_fixing_thickness * 4, rad, rad);
    }
    
    translate([-(ear_rack_fixing_thickness * 2), mask_dy, dz_bottom])
    rotate([0, 90, -90])
    //  Slot mask
    hull() {    
        //  Make the shape arbitrarily big enough to create the slot without rounding errors
        translate([0, 0, ear_rack_fixing_slot_length * 2]) rotate([-90, 0, 0]) cylinder(ear_rack_fixing_thickness * 4, rad, rad);
        rotate([-90, 0, 0]) cylinder(ear_rack_fixing_thickness * 4, rad, rad);
    }
}

module ear_case_fixing() {      
    difference() {
        linear_extrude(ear_case_fixing_height) {
        //  Side-profile. Fixed size independent of case height
        polygon([
            [0, 0],
            [ear_case_fixing_width, 0],
            [ear_case_fixing_width, 2],
            [ear_case_fixing_width - 10, ear_case_fixing_screw_plate_depth],
            [14, ear_case_fixing_screw_plate_depth],
            [0, 11]]);
        }

        //  Top-right rounded corner mask
        //  Add 10 to y to ensure proper clipping
        translate([ear_case_fixing_width - ear_case_fixing_corner_radius, -10, ear_case_fixing_corner_radius])
        rotate([-90, 0, 0])
        linear_extrude(20) 
        difference() {
            //  Square with a quarter circle removed
            square(size = [ear_case_fixing_corner_radius * 2, ear_case_fixing_corner_radius * 2]);
            circle(ear_case_fixing_corner_radius);
        }    
    
        //  Bottom-right rounded corner mask
        translate([ear_case_fixing_width - ear_case_fixing_corner_radius, 10, ear_case_fixing_height - ear_case_fixing_corner_radius])
        rotate([90, 0, 0])
        linear_extrude(20) 
        difference() {
            //  Square with a quarter circle removed
            square(size = [ear_case_fixing_corner_radius * 2, ear_case_fixing_corner_radius * 2]);
            circle(ear_case_fixing_corner_radius);
        }     
    }
}

module ear_case_fixing_faceplate_notches() {
    sz_z = max(case_faceplate_overhang_top, case_faceplate_overhang_bottom) * 2;

    translate([-1, -1, -1])
    cube([ear_rack_fixing_thickness, case_faceplate_thickness + 1, sz_z + 1]);

    translate([-1, -1, ear_case_fixing_height - sz_z])
    cube([ear_rack_fixing_thickness, case_faceplate_thickness + 1, sz_z + 1]);
}

module ear_case_fixing_screw_masks() {
    screw_hole_radius = screw_hole_diameter / 2;
    screw_hole_countersink_radius = screw_hole_countersink_diameter / 2;

    //  Add 10 to y to ensure proper clipping.
    translate([case_screw_x, ear_case_fixing_screw_plate_depth + 10, case_top_screw_y - case_side_margin_y])
    rotate([90, 0, 0])
    union() {
        cylinder(screw_hole_countersink_depth + 10, screw_hole_countersink_radius, screw_hole_countersink_radius);
        cylinder(20, screw_hole_radius, screw_hole_radius);
    }
    
    translate([case_screw_x, ear_case_fixing_screw_plate_depth + 10, case_bottom_screw_y - case_side_margin_y])
    rotate([90, 0, 0])
    union() {
        cylinder(screw_hole_countersink_depth + 10, screw_hole_countersink_radius, screw_hole_countersink_radius);
        cylinder(20, screw_hole_radius, screw_hole_radius);
    }
}