include <plate.scad>

serial="VX.XXX";
logo=true;

$fn = $preview ? 24 : 48;

function is_v0() = serial[1] == "0";

plate(
    serial,
    logo = logo,
    depth_offset = is_v0() ? 0 : 5,
    alignment_bar_depth = is_v0() ? 0 : 2,
    screws = is_v0() ? false : true,
    pegs = is_v0() ? true : false,
    alignment_bar_height = is_v0() ? 4.6 : 6
);