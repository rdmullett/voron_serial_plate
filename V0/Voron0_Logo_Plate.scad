font1="Play";
serial="VX.XXX";
logo=true;
serial_length=len(serial);

baseplate= logo ? "Serial_Plate_Voron0_Logo.stl" : "Serial_Plate_Voron0_NoLogo.stl";

length_to_move= (serial_length<=7)? -41.5 : -46.5;

difference(font1, serial, logo) {
    rotate([0,180,0]) translate([length_to_move,0,-20]) import(baseplate, center=true); 
    rotate([90,0,0]) translate([0,6,-1]) linear_extrude(20) text(text=serial, font=font1, size=8, halign="center");
}
