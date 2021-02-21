font1="Play";
serial="VX.XXX";
logo=true;

baseplate= logo ? "Serial_Plate_Voron_Logo.stl" : "Serial_Plate_Voron_NoLogo.stl";

difference(font1, serial, logo) {
    rotate([0,180,0]) translate([-41.5,0,-20]) import(baseplate, center=true); 
    rotate([90,0,0]) translate([0,6,-1]) linear_extrude(20) text(text=serial, font=font1, size=8, halign="center");
}
