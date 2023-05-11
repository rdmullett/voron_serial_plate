include <plate.scad>

serial="VX.XXX";
logo=true;

$fn = $preview ? 24 : 48;

plate(serial, logo = logo);