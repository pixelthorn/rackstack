// RasPi_4B - 3U-rack.scad    
//
// RackPi Raspberry Pi (2B / 3B / 3B+)
// Case Shield 2" wide 3U high with OLED & Power Switch
// V1.0	May 18th, 2021; by Aad Onderwater
//
// After the originial design by Daniel Reinke (Duitsland)
//
// Original title:
// RackPi Raspberry Pi (2B / 3B / 3B+ / 4B)
// Rack Shield 19" 2U with OLED & Power Switch
// July 27th, 2018
//
// https://www.thingiverse.com/sliderbor/designs
//
//
// All measures are times 10! (devide by 10 before slicing)
//
// --------------------------------------------------------------------
//
// This is free and unencumbered code released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this code, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.
// 
// In jurisdictions that recognize copyright laws, the author
// of this code dedicate any and all copyright interest in the
// code to the public domain. I make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. I intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.
// 
// THE CODE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE CODE OR THE USE OR
// OTHER DEALINGS IN THE CODE.
//
// Remember where you got your code from...
//
// For more information, please refer to <http://unlicense.org/>
// 

$fa = 0.2;
$fs = 0.08;


// Frontplaat
ShieldWidth = 503.5;
ShieldLength = 1285.0;
ShieldThickness = 20.0;

// Verstevigingsrand1
ReinfOuterWidth1 = 152.0;
ReinfOuterLength1 = 720.0;
ReinfInnerWidth1 = ReinfOuterWidth1 - 30.0;
ReinfInnerLength1 = ReinfOuterLength1 - 30.0;

// Verstevigingsrand2
ReinfOuterWidth2 = 70.0;
ReinfOuterLength2 = 70.0;
ReinfInnerWidth2 = ReinfOuterWidth2 - 20.0;
ReinfInnerLength2 = ReinfOuterLength2 - 20.0;

// Schroefgaten
ScrewDiameter = 26.5;
ScrewHole_X = 73.6;										// From the edge horizontal
ScrewHole_Y = 29.8;										// From the edge vertical
ScrewHole_H = 30.0;										// 0.5mm top and bottom

// Display window
DisplayWidth = 235.0;									// Window in X-direction
DisplayLength = 130.0;									// Window in Y-direction
DisplaySize = 280.0;									// Largest size of the display's PCB
WallThickness = 10.0;									// Thickness of the wall around the display
ClearanceWidth = 100.0;									// Distance from the edge of the top and bottom of the shield
DisplayMargin = 5.0;									// 0.5 mm between wall and display
OffsetDisplay = 57.5;									// Display is positioned 5mm from the edge of the PCB

// Displaysteunen variabelen
SupportWidth = 65.0;									// Width of support for display PCB
SupportLength = 42.5;									// Length of support for display PCB
SupportHeight = 22.0;									// Heigth (thickness) of support for display PCB

// Rand variabelen
WallOuterSide = 310.0;									// outer side of wall around display window
WallInnerSide = 290.0;									// inner side of wall around display window
WallHeight = 80.0;										// height of wall around display window

// Aan/uit schakelaar
SwitchWidth = 23.0;										// Width of the switch knob (2mm)
SwitchLength= 45.0;										// Length of the knob movement (4.2mm)
SwitchOuterWidth = 112.0;								// Width of the switch wall (8.9mm) + 2mm
SwitchOuterLength = 71.0;								// Length of the switch wall (4.6mm) + 2mm
SwitchInnerWidth = 92.0;								// Width of the switch casing (8.9mm)
SwitchInnerLength = 51.0;								// Length of the switch casing (4.6mm)
SwitchWallHeight = 60.0;								// Height of the switch wall
SwitchSupportDiameter = 0;								// Switch support to place switch over... (in my case no support)

// LED indicator
LED_RimHeight = 10.0;
LED_OuterDiameter = 52.5;
LED_InnerDiameter = 30.;

// PrintMargin after 3D printing 0.35mm... maximum
// This margin on all ' L'  measures...
// Mechanical drawings Raspberry Pi:  https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/
PrintMargin = 0.0;

// Raspi windows, USB
USB_Width = 146.0;										// Horizontal measurements
USB_Length = 136.0;										// Vertical measurements
USB_Offset_L1 = 90.0 + PrintMargin;						// Seen from the outside of the Raspi Bracket (ShieldThickness + Offset)
USB_Offset_L2 = 270.0 + PrintMargin;					// Seen from the outside of the Raspi Bracket (ShieldThickness + Offset)
USB_Offset_B = 72.5;									// Seen from the outside of the RaspiBeugel (ShieldThickness + PCB_Dikte + Offset)

// Raspi windows, NET
NET_Width = 140.0;										// Horizontal measurements
NET_Length = 160.0;										// Vertical measurements
NET_Offset_B = 62.5;									// Seen from the outside of the RaspiBeugel (ShieldThickness + PCB_Dikte + Offset)
NET_Offset_L = 457.5 + PrintMargin;						// Seen from the outside of the Raspi Bracket (ShieldThickness + Offset)

// Raspi rondom uitsparingen, zoals in het origineel, USB
USB_Width_R = 170.0;									// Horizontal measurements
USB_Length_R = 160.0;									// Vertical measurements
USB_Offset_BR = 59.0;									// Seen from the outside of the RaspiBeugel (ShieldThickness + PCB_Dikte + Offset)

// Raspi rondom uitsparingen, zoals in het origineel, NET
NET_Width_R = 145.5;									// Horizontal measurements
NET_Length_R = 170.0;									// Vertical measurements
NET_Offset_LR = 414.0 + PrintMargin;					// Seen from the outside of the Raspi Bracket (ShieldThickness + Offset)
NET_Offset_BR = NET_Offset_B;							// Seen from the outside of the RaspiBeugel (ShieldThickness + PCB_Dikte + Offset)

// Raspi beugel
SupportScrewDiameter = 30.0;
SupportScrewHeight = 30.0;
SupportScrewRaiserBottom = 120.0;
SupportScrewRaiserTop = 60.0;
SupportScrewDistanceFromShield = 265.0;					// Distance from the shield to the first set of screws (see documentation webpage)  !!! 0.5mm extra bij 4B !!!
Support_Y_Distance = 490.0;								// Distance between the screws over the width of the Pi 
Support_Z_Distance = 580.0;								// Distance from the first set of screws to the second set of screws

BracketOuterWidth = 270.0;
BracketInnerWidth = BracketOuterWidth - 2*ShieldThickness;
BracketOuterLength = 610.0;
BracketInnerLength = BracketOuterLength - 2*ShieldThickness;
BracketHeight = SupportScrewDistanceFromShield + Support_Z_Distance;
Bracket_Displacement_X = 81.0;
Bracket_Displacement_Y = -ShieldLength/11;
Bracket_Displacement_Z = (ShieldThickness+BracketHeight)/2;

Support_Displacement_X = 85.0;							// NOTA BENE; This is no measurement, pure T&E
Support_Displacement_Y = 0.0;
Support_Displacement_Z = -BracketHeight/2;

module raspberry_pi_4b(){
    // The entire frontplate; FRONT + REAR
    union () {

        // Het COMPLETE Frontplaat FRONT - de FRONT voorzien van alle windows (Frontplaat, schroefgaten, DISPLAY, LED, Schakelaar en Raspi)
        difference () {
            // Frontplaat om mee te beginnen...
            union () {
                // Alleen Frontplaat...
                cube ([ShieldWidth,ShieldLength,ShieldThickness], center=true);
                // Met versteviging1...
                translate ([ -115, -117.5, ((2*WallHeight/3)+ShieldThickness)/2]) {
                    difference () {
                        cube([ReinfOuterWidth1, ReinfOuterLength1, 2*WallHeight/3], center=true);
                        cube([ReinfInnerWidth1, ReinfInnerLength1, 2*WallHeight/3+1], center=true);
                    }
                }
                // Met versteviging2...
                translate ([ 140, 207.5, ((2*WallHeight/3)+ShieldThickness)/2]) {
                    difference () {
                        cube([ReinfOuterWidth2, ReinfOuterLength2, 2*WallHeight/3], center=true);
                        cube([ReinfInnerWidth2, ReinfInnerLength2, 2*WallHeight/3+1], center=true);
                    }
                }
            }
            
            // Gaten voor de schroeven met het chassis  (eraf)
            translate ([-(ShieldWidth/2-ScrewHole_X), (ShieldLength/2-ScrewHole_Y),0])
                cylinder (h=ScrewHole_H, r1=ScrewDiameter/2, r2=ScrewDiameter/2, center=true); // schroefgat LB
            translate ([-(ShieldWidth/2-ScrewHole_X),-(ShieldLength/2-ScrewHole_Y),0])
                cylinder (h=ScrewHole_H, r1=ScrewDiameter/2, r2=ScrewDiameter/2, center=true); // schroefgat LO
            translate ([ (ShieldWidth/2-ScrewHole_X),-(ShieldLength/2-ScrewHole_Y),0])
                cylinder (h=ScrewHole_H, r1=ScrewDiameter/2, r2=ScrewDiameter/2, center=true); // schroefgat RO
            translate ([ (ShieldWidth/2-ScrewHole_X),(ShieldLength/2-ScrewHole_Y),0])
                cylinder (h=ScrewHole_H, r1=ScrewDiameter/2, r2=ScrewDiameter/2, center=true); // schroefgat RB
                    
            // DISPLAY window (met verkanting van 45 graden  (eraf)
            translate ([0,(ShieldLength/2-ClearanceWidth-WallThickness-DisplayMargin-OffsetDisplay-(DisplayLength/2)),0]) {
                
                // Necessary variables for a 45 degree cant
                PolyWidth = DisplayWidth + 2*ShieldThickness;     // Basis Poly
                PolyLength =  DisplayLength +  2*ShieldThickness;     // Basis Poly
                PolyHeight =  DisplayLength/2 +  ShieldThickness;     // Height Poly

                CubePoints1 = [
                    [  -PolyWidth/2,           -PolyLength/2, -ShieldThickness/2-1 ],            //0
                    [   PolyWidth/2,           -PolyLength/2, -ShieldThickness/2-1 ],            //1
                    [   PolyWidth/2,            PolyLength/2, -ShieldThickness/2-1 ],            //2
                    [  -PolyWidth/2,            PolyLength/2, -ShieldThickness/2-1 ],            //3
                    [  -PolyWidth/2+PolyHeight, 0,             PolyHeight-ShieldThickness/2 ],   //4
                    [   PolyWidth/2-PolyHeight, 0,             PolyHeight-ShieldThickness/2 ],   //5
                    [   PolyWidth/2-PolyHeight, 0,             PolyHeight-ShieldThickness/2 ],   //6
                    [  -PolyWidth/2+PolyHeight, 0,             PolyHeight-ShieldThickness/2 ]];  //7
      
                CubeFaces1 = [
                    [0,1,2,3],  // bottom
                    [4,5,1,0],  // front
                    [7,6,5,4],  // top
                    [5,6,2,1],  // right
                    [6,7,3,2],  // back
                    [7,4,0,3]]; // left
                  
                polyhedron( CubePoints1, CubeFaces1 );
            }
            
            // LED window  (eraf)
            translate ([ ShieldWidth/4,-ShieldLength/2+ClearanceWidth+SwitchOuterLength/2,0]) {
                    cylinder (h=ShieldThickness+2 ,r1=LED_InnerDiameter/2 ,r2=LED_InnerDiameter/2, center=true);
            }
            
            // Schakelaar window  (eraf)
            translate ([-ShieldWidth/6,-ShieldLength/2+ClearanceWidth+SwitchOuterLength/2,0]) {
                cube ([SwitchLength,SwitchWidth,ShieldThickness+2], center=true); // Schakelaarstiftgat
            }
            //
            // Plaatsing van de windows voor de Raspberry Pi 4B...
            //
            // Raspi windows voor USB en Netwerk (eraf) (Van Boven naar Beneden: 1. USB1, 2. USB2, 3. NET)
            translate ([Bracket_Displacement_X+BracketOuterWidth/2-USB_Width/2-USB_Offset_B, Bracket_Displacement_Y+BracketInnerLength/2-USB_Offset_L1, 0]) {
                cube ([ USB_Width, USB_Length, ShieldThickness+2 ], center=true);                    // 1. USB1
            }
            translate ([Bracket_Displacement_X+BracketOuterWidth/2-USB_Width/2-USB_Offset_B, Bracket_Displacement_Y+BracketInnerLength/2-USB_Offset_L2, 0]) {
                cube ([ USB_Width, USB_Length, ShieldThickness+2 ], center=true);                    // 2. USB2
            }
            translate ([Bracket_Displacement_X+BracketOuterWidth/2-NET_Width/2-NET_Offset_B, Bracket_Displacement_Y+BracketInnerLength/2-NET_Offset_L, 0]) {
                cube ([ NET_Width, NET_Length, ShieldThickness+2 ], center=true);                    // 3. NET
            }		
        }    
        
        // The complete frontplate REAR - equipped with all surface mounting (DISPLAY, Raspi, Switch and LED)
        {
            // DISPLAY steunen voor het window met rand
            translate ([0,(ShieldLength/2-ClearanceWidth-WallOuterSide/2),(ShieldThickness+WallHeight)/2-1]) {
                union () {
                    // rand rondom het display
                    difference () {
                        cube ([WallOuterSide,WallOuterSide,WallHeight-1], center=true);
                        cube ([WallInnerSide,WallInnerSide,WallHeight], center=true);
                    }
                    // steunen voor het display
                    union () {
                        translate ([-(DisplaySize-SupportWidth)/2, (DisplaySize-SupportLength)/2,(-WallHeight+SupportHeight)/2])
                            cube ([SupportWidth,SupportLength,SupportHeight], center=true); // displaysteun LB
                        translate ([-(DisplaySize-SupportWidth)/2,-(DisplaySize-SupportLength)/2,(-WallHeight+SupportHeight)/2])
                            cube ([SupportWidth,SupportLength,SupportHeight], center=true); // displaysteun LO
                        translate ([ (DisplaySize-SupportWidth)/2,-(DisplaySize-SupportLength)/2,(-WallHeight+SupportHeight)/2])
                            cube ([SupportWidth,SupportLength,SupportHeight], center=true); // displaysteun RO
                        translate ([ (DisplaySize-SupportWidth)/2, (DisplaySize-SupportLength)/2,(-WallHeight+SupportHeight)/2])
                            cube ([SupportWidth,SupportLength,SupportHeight], center=true); // displaysteun RB
                    }
                }
            }
        
            // LED 'opbouw' rond het gat
            translate ([ ShieldWidth/4,-ShieldLength/2+ClearanceWidth+SwitchOuterLength/2,(ShieldThickness+LED_RimHeight)/2]) {
                difference () {
                    cylinder (h=LED_RimHeight   ,r1=LED_OuterDiameter/2 ,r2=LED_OuterDiameter/2, center=true);
                    cylinder (h=LED_RimHeight+2 ,r1=LED_InnerDiameter/2 ,r2=LED_InnerDiameter/2, center=true);
                }
            }
        
            // Schakelaar 'opbouw' rond het stiftgat
            translate ([-ShieldWidth/6,-ShieldLength/2+ClearanceWidth+SwitchOuterLength/2,(ShieldThickness+SwitchWallHeight)/2]) {
                union () {      
                    // rand rondom de schakelaar
                    difference () {
                        cube ([SwitchOuterWidth, SwitchOuterLength, SwitchWallHeight-1], center=true);
                        cube ([SwitchInnerWidth, SwitchInnerLength, SwitchWallHeight+1], center=true);
                    }            
                    // steunen voor de schakelaar
    //                union () {
    //                    translate ([+(SwitchOuterWidth+SwitchLength)/4, 0, 0])
    //                        cylinder (h=SwitchWallHeight, r1=SwitchSupportDiameter/2, r2=SwitchSupportDiameter/2, center=true); // schakelaarsteun
    //                    translate ([-(SwitchOuterWidth+SwitchLength)/4, 0, 0])
    //                        cylinder (h=SwitchWallHeight, r1=SwitchSupportDiameter/2, r2=SwitchSupportDiameter/2, center=true); // schakelaarsteun
    //                }
                }
            }
            
            // **************************************************************************************************
            //
            // Raspi 'opbouw' rond de gaten
            //
            //***************************************************************************************************
            translate ([Bracket_Displacement_X, Bracket_Displacement_Y, Bracket_Displacement_Z]) {
                difference () {
                    union () {
                        // De basis beugel van de Pi
                        difference () {
                            // De begin kolom...
                            cube ([ BracketOuterWidth,    BracketOuterLength,   BracketHeight], center=true);
                            cube ([ BracketInnerWidth,    BracketInnerLength,   BracketHeight+2], center=true);
                            // Het voorste rechthoekige deel eraf gehaald...
                            translate ([-30.0, 0, 110.0]) {
                                cube ([ BracketOuterWidth-58, BracketOuterLength+2,   BracketHeight-219.0], center=true);
                            }
                            // Het schuine deel onderin er van af...
                            translate ([0, 0, -BracketHeight/2+220.0]) {
                                          
                                CubePoints1 = [
                                    [  -BracketOuterWidth/2-1,       BracketOuterLength/2+1, -120.0 ],     //0 
                                    [  -BracketOuterWidth/2-1,      -BracketOuterLength/2-1, -120.0 ],     //1 
                                    [   BracketOuterWidth/2-60.0,   -BracketOuterLength/2-1,  0 ],         //2
                                    [   BracketOuterWidth/2-60.0,    BracketOuterLength/2+1,  0 ],         //3
                                    [  -BracketOuterWidth/2-1,       BracketOuterLength/2+1,  0 ],         //4
                                    [  -BracketOuterWidth/2-1,      -BracketOuterLength/2-1,  0 ],         //5
                                    [   BracketOuterWidth/2-60.0,   -BracketOuterLength/2-1,  0 ],         //6
                                    [   BracketOuterWidth/2-60.0,    BracketOuterLength/2+1,  0 ]];        //7
              
                                CubeFaces1 = [
                                    [0,1,2,3],  // bottom
                                    [4,5,1,0],  // front
                                    [7,6,5,4],  // top
                                    [5,6,2,1],  // right
                                    [6,7,3,2],  // back
                                    [7,4,0,3]]; // left
                          
                                polyhedron( CubePoints1, CubeFaces1 ); 
                            }
                            // Het schuine deel bovenaan er van af... 
                            translate ([0, 0, BracketHeight/2]) {
                                CubePoints2 = [
                                    [  BracketOuterWidth/2-60.0,  BracketOuterLength/2+1, -40.0 ],      //0 
                                    [  BracketOuterWidth/2-60.0, -BracketOuterLength/2-1, -40.0 ],      //1 
                                    [  BracketOuterWidth/2+1.0,  -BracketOuterLength/2-1,  0 ],         //2
                                    [  BracketOuterWidth/2+1.0,   BracketOuterLength/2+1,  0 ],         //3
                                    [  BracketOuterWidth/2-60.0,  BracketOuterLength/2+1,  1 ],         //4
                                    [  BracketOuterWidth/2-60.0, -BracketOuterLength/2-1,  1 ],         //5
                                    [  BracketOuterWidth/2+1.0,  -BracketOuterLength/2-1,  1 ],         //6
                                    [  BracketOuterWidth/2+1.0,   BracketOuterLength/2+1,  1 ]];        //7
              
                                CubeFaces2 = [
                                    [0,1,2,3],  // bottom
                                    [4,5,1,0],  // front
                                    [7,6,5,4],  // top
                                    [5,6,2,1],  // right+ShieldThickness+2 
                                    [6,7,3,2],  // back
                                    [7,4,0,3]]; // left
                                
                                polyhedron( CubePoints2, CubeFaces2 ); 
                            }
                        } 
                        // Toevoegen van de steunen voor de Raspi
                        translate ([ Support_Displacement_X, Support_Displacement_Y, Support_Displacement_Z]) {
                            rotate ([ 0, 90, 0]) {
                                translate ([ -SupportScrewDistanceFromShield,  Support_Y_Distance/2, 0]) {
                                    cylinder (h=SupportScrewHeight ,r1=SupportScrewRaiserTop/2 ,r2=SupportScrewRaiserBottom/2 ,center=false);
                                }
                                translate ([ -SupportScrewDistanceFromShield, -Support_Y_Distance/2, 0]) {
                                    cylinder (h=SupportScrewHeight ,r1=SupportScrewRaiserTop/2 ,r2=SupportScrewRaiserBottom/2 ,center=false);
                                }
                                translate ([ -(SupportScrewDistanceFromShield+Support_Z_Distance),  Support_Y_Distance/2, 0]) {
                                    cylinder (h=SupportScrewHeight ,r1=SupportScrewRaiserTop/2 ,r2=SupportScrewRaiserBottom/2 ,center=false);
                                }
                                translate ([ -(SupportScrewDistanceFromShield+Support_Z_Distance), -Support_Y_Distance/2, 0]) {
                                    cylinder (h=SupportScrewHeight ,r1=SupportScrewRaiserTop/2 ,r2=SupportScrewRaiserBottom/2 ,center=false);
                                }
                                translate ([ -(SupportScrewDistanceFromShield+Support_Z_Distance),  Support_Y_Distance/2, SupportScrewHeight]) {
                                    cylinder (h=ShieldThickness, r1=SupportScrewRaiserBottom/2, r2=SupportScrewRaiserBottom/2 ,center=false);
                                }
                                translate ([ -(SupportScrewDistanceFromShield+Support_Z_Distance), -Support_Y_Distance/2, SupportScrewHeight]) {
                                    cylinder (h=ShieldThickness, r1=SupportScrewRaiserBottom/2, r2=SupportScrewRaiserBottom/2 ,center=false);
                                }
                            }
                        }
                    }

                    // Verwijderen van de schroefgaten in de steunen (We zitten hier weer in een 'difference' structuurdeel...)
                    translate ([Support_Displacement_X, Support_Displacement_Y, Support_Displacement_Z]) {
                        rotate ([0,90,0]) {
                            translate ([ -SupportScrewDistanceFromShield,  Support_Y_Distance/2, -1]) {
                                cylinder (h=SupportScrewHeight+ShieldThickness+2 ,r1=SupportScrewDiameter/2 ,r2=SupportScrewDiameter/2 ,center=false);
                            }
                            translate ([ -SupportScrewDistanceFromShield, -Support_Y_Distance/2, -1]) {
                                cylinder (h=SupportScrewHeight+ShieldThickness+2 ,r1=SupportScrewDiameter/2 ,r2=SupportScrewDiameter/2 ,center=false);
                            }
                            translate ([ -(SupportScrewDistanceFromShield+Support_Z_Distance),  Support_Y_Distance/2, -1]) {
                                cylinder (h=SupportScrewHeight+ShieldThickness+2 ,r1=SupportScrewDiameter/2 ,r2=SupportScrewDiameter/2 ,center=false);
                            }
                            translate ([ -(SupportScrewDistanceFromShield+Support_Z_Distance), -Support_Y_Distance/2, -1]) {
                                cylinder (h=SupportScrewHeight+ShieldThickness+2 ,r1=SupportScrewDiameter/2 ,r2=SupportScrewDiameter/2 ,center=false);
                            }
                        }
                    }              
                    // Verwijderen van een deel uit de steun (We zitten nog steeds in het 'difference' stuctuurdeel...)
                    translate ([ (BracketOuterWidth-ShieldThickness)/2, Support_Displacement_Y, Support_Displacement_Z]) {
                        rotate ([0,90,0]) {
                            for(i = [ -3*Support_Z_Distance/10 : 3*Support_Z_Distance/20 : 3*Support_Z_Distance/10 ]) {
                                for(j = [ -3*Support_Y_Distance/10 : 3*Support_Y_Distance/20 : 3*Support_Y_Distance/10 ]) {
                                    translate ([ -(SupportScrewDistanceFromShield+Support_Z_Distance/2)+i, j, 0]) {
                                        cube ([ 3*Support_Z_Distance/40, 3*Support_Y_Distance/40, ShieldThickness+2], center=true);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            // Toevoegen van een steun voor de NET en 2x USB aansluitingen, zoals in het origineel... Basisplaat met verwijderde uitsparingen.
            translate ([ Bracket_Displacement_X, Bracket_Displacement_Y, ShieldThickness ]) {
                difference () {
                    translate ([ 0, 0, 0 ]) {
                        cube ([ BracketOuterWidth, BracketOuterLength, ShieldThickness ], center=true);
                    }
                    //
                    // Plaatsing van de windows voor de Raspberry Pi 4B...
                    //
                    // Raspi 'rondom' windows voor USB en Netwerk (Van Boven naar Beneden: 1. USB1, 2. USB2, 3. NET)
                    translate ([BracketOuterWidth/2-USB_Width_R/2-USB_Offset_BR, BracketInnerLength/2-USB_Offset_L1, 0]) {
                        cube ([ USB_Width_R, USB_Length_R, ShieldThickness+1 ], center=true);						// 1. USB1
                    }
                    translate ([BracketOuterWidth/2-USB_Width_R/2-USB_Offset_BR, BracketInnerLength/2-USB_Offset_L2, 0]) {
                        cube ([ USB_Width_R, USB_Length_R, ShieldThickness+1 ], center=true);						// 2. USB2
                    }
                    translate ([BracketOuterWidth/2-NET_Width_R/2-NET_Offset_BR, BracketInnerLength/2-NET_Offset_L, 0]) {
                        cube ([ NET_Width_R, NET_Length_R, ShieldThickness+1 ], center=true);						// 3. NET
                    }
                }
            }
        }
    }
};

