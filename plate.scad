module plate(serial = "VX.XXXX") {
    height=20;
    width_0 = 15.23;
    char_width = 10;
    width = width_0 + len(serial) * char_width;
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
    };

    base();
}