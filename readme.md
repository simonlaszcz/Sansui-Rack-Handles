 ____                             _     ____ __  __      ____
/ ___|   __ _  _ __   ___  _   _ (_)   / ___|\ \/ /     | ___|
\___ \  / _` || '_ \ / __|| | | || |  | |  _  \  / _____|___ \
 ___) || (_| || | | |\__ \| |_| || |  | |_| | /  \|_____|___) |
|____/  \__,_||_| |_||___/ \__,_||_|   \____|/_/\_\     |____/

Sansui GX-5 rack mounting ear model
Parameterised for use with multiple Sansui components
2021 - Simon Laszcz 

![render](/handle.png)

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
- You should visually inspect every aspect of the model before printing.
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

///////////////
//  PARAMETERS
///////////////

//  Height of the component's faceplate. Defines the size of the ear
case_faceplate_height = 140;
//  The amount the component faceplate overhangs the case on one side
case_faceplate_overhang_x = 1;
//  The amount the component faceplate overhangs the top of the case
case_faceplate_overhang_top = 0;
//  The amount the component faceplate overhangs the bottom of the case
case_faceplate_overhang_bottom = 3;
//  The faceplate on the SE-9 is rolled over the top of the case. When looking side-on, this is the width
//  Use the furl dimensions, along with case_faceplate_overhang_x to dictate the size of the notches printed on the ear case fixing
case_furl_width = 15;
//  The faceplate on the SE-9 is rolled over the top of the case. When looking side-on, this is the height
case_furl_height = 10;
//  Thickness of the component faceplate when looking front-on
case_faceplate_thickness = 2;
//  X distance of the screw hole centre from the front of the case (not including faceplate)
case_screw_x = 22;
//  Y distance of the screw hole centre from the top of the case
case_top_screw_y = 30;
//  Y distance of the screw hole centre from the top of the case
case_bottom_screw_y = 110;
//  Gap between case fixing and top/bottom of case. Can be used to reduce printing cost. Making it too big will reduce strength
case_side_margin = 10;