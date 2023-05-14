module plate(serial = "VX.XXXX", logo = true, depth_offset = 5, alignment_bar_depth = 2, text_thickener = 0, screws = true, pegs = false, alignment_bar_height = 6) {
    height=20;
    width_0 = 15.23;
    char_width = 10;
    width = width_0 + len(serial) * char_width;

    engraving_depth = 2;

    font_size = 8;
    font_face = "Play";

    screw_offset = 13.5;
    screw_pos = width / 2 - screw_offset;

    peg_offset = 10.5;
    peg_pos = width / 2 - peg_offset;
    peg_thickness = 4.6;

    epsilon = .01;

    module base() {
        shoulder_height=11;
        shoulder_width=5;
        radius = 2;
        radius_top = 2.85;

        module corner(pos = [0,0,0], r = radius) {
            thickness = 3;

            translate(pos) hull() {
                rotate_extrude() translate ([r,0]) difference() {
                    circle(radius);
                    translate([-radius, -radius*2]) square(radius*2);
                }
                translate([0,0,thickness - epsilon]) cylinder(epsilon, r = r);
            }
        }

        hull() for (flip = [0:1]) {
            mirror([flip,0,0]) {
                corner([width/2,radius * 2,0]);
                corner([width/2-shoulder_width, height - radius - radius_top, 0], radius_top);
                corner([width/2+radius-radius_top, shoulder_height, 0], radius_top);
            };
        };

        hull() for (flip = [0:1]) {
            mirror([flip,0,0]) {
                translate([width/2, radius * 2, -depth_offset])
                    cylinder(depth_offset + epsilon, r = radius * 2);
                translate([width/2 + radius, shoulder_height, -depth_offset])
                    cylinder(depth_offset + epsilon, r = radius);
            }
        }

        translate([0, height/2, -alignment_bar_depth/2 - depth_offset]) {
            alignment_bar_width = width - screw_offset * 3;
            cube([alignment_bar_width, alignment_bar_height, alignment_bar_depth + epsilon], center = true);
        }
    };

    module screw_hole(x) {
        inner_diameter = 1.9;
        outer_diameter = 2.9;
        surface_diameter = 3;
        taper_length = 1;

        translate([x,height/2,-epsilon]) union() {
            translate([0, 0, -10]) cylinder(20, r = inner_diameter);
            cylinder(taper_length, inner_diameter, outer_diameter);
            translate([0,0,1 - epsilon]) cylinder(10, r = surface_diameter);
        }
    }

    module voron_logo() {
        scale_factor = 3.02;
        scale([scale_factor,scale_factor, 1]) linear_extrude(5, convexity = 4) difference() {
            polygon([[0,2], [sqrt(3),1], [sqrt(3),-1], [0,-2], [-sqrt(3),-1], [-sqrt(3),1]]);
            union() {
                polygon([[.4543,1.0884],[.9775,1.0884], [-.4541,-1.0892], [-.9772,-1.0892]]);
                polygon([[.5102, -1.0892], [-.013, -1.0892], [.7025, -.0005], [1.2257,-.0005]]);
                polygon([[-.5102, 1.0892], [.013, 1.0892], [-.7025, .0005], [-1.2257,.0005]]);
            }
        }
    }

    module peg() {
        module thicken(distance=1) {
            hull() for (i = [0 : 1]) {
                translate([0, distance*i, 0]) children();
            }
        }

        module rotate_extrude_offset(a = 90) {
                rotate([90,a,0]) rotate_extrude(angle = a) children();
        }


        thicken(peg_thickness) {
            cylinder(epsilon, r=0.2);
            translate([2.596,0,0]) cylinder(5, r=0.2);
            translate([1.8,0,5.2]) rotate([90,0,0]) rotate_extrude() translate([.8,0]) circle(.2);
            translate([-.2,0,6]) rotate([0,90,0]) cylinder(2, r=.2);
        }
        thicken(peg_thickness) {
            translate([-.2,0,4.7]) rotate([90,0,0]){
                rotate_extrude() translate([1.3,0]) circle(.2);
                translate([0,0,-.2]) cylinder(.4, r = 1.3);
            }
        }
        for (i=[0:1]) translate ([-1.2,peg_thickness*i,2.35]) rotate([0,300,0]) rotate_extrude_offset(60) translate([1.3,0]) {
            circle(.2);
            translate([0,-.2]) square(.4);
        }
        translate([-1.2,0,2.35]) rotate([0,300,0]) rotate_extrude_offset(60) translate([1.1,-peg_thickness]) square([1,peg_thickness]);
        for (i=[0:1]) translate([3.8,i*peg_thickness,1.2]) rotate([0,90,0]) rotate_extrude_offset() translate([1.2,0]) { circle(.2); translate([0,-.2]) square([1,.4]); };
        translate([3.8,0,1.2]) rotate([0,90,0]) rotate_extrude_offset() translate([1.1,-peg_thickness]) square([1,peg_thickness]);
    }

    rotate([180,0,0]) difference() {
        base();
        union() {
            translate([0, (height - font_size) / 2, engraving_depth]) linear_extrude(10, convexity=len(serial) + 4)
                offset(delta = text_thickener)
                    text(text=serial, font = font_face, halign = "center", size = font_size);
            if (screws) {
                screw_hole(screw_pos);
                screw_hole(-screw_pos);
            }
            if (logo) {
                // Coordinates to the center of the logo, relative to left and bottom edges
                xoff = screws ? 4.75 : 7; ypos = 9.67;

                translate([xoff - width/2, ypos, engraving_depth]) voron_logo();
            }
        }
    }

    if (pegs) {
        for (i = [-1:2:1])
        translate([i*peg_pos,-height/2-peg_thickness/2,depth_offset-.2]) {
            mirror([(i-1)/-2,0,0]) peg();
        }
    }
}