// parametric storage box
// Scott Alfter
// 27 Feb 19

// CC-BY
// https://creativecommons.org/licenses/by/4.0/legalcode.txt

width=50;     // and depth, too
height=50;    // self-explanatory
roundness=10; // half of this is the radius of the corners
take_in=0.5;  // top of the box should be reduced by this amount for the lid
              // (should probably be somewhere near your printer's nozzle width)

label="Label";
label_size=7;
label_depth=0.25;

// choose one to render (both pieces needed for complete set)

// body();
// lid();

// does what it's named...you probably don't want to print this

// preview();

// nothing to modify below here in regular use

$fn=90;

module preview()
{
    body();
    translate([0,0,height])
    rotate([0,180,0])
        lid();
}

module body()
{
    difference()
    {
        intersection()
        {
            minkowski()
            {
                intersection()
                {
                    body_profile();
                    rotate([0,0,90])
                        body_profile();
                }

                sphere(d=roundness);
            }

            translate([0,0,height/2])
                cube([width, width, height], center=true);
        }

        translate([0,-width/2+label_depth, height/2])
        rotate([90,0,0])
        linear_extrude(label_depth, convexity=10)
            text(label, size=label_size, halign="center", valign="center");
    }
}

module body_profile()
{
    translate([0, width/2, height/2])
    rotate([90,0,0])
    linear_extrude(width, convexity=10)
    polygon([[-width/2+roundness/2, -height/2+roundness/2],
            [-width/2+roundness/2, height/2-7-roundness/2],
            [-width/2+take_in+roundness/2, height/2-5-roundness/2],
            [-width/2+take_in+roundness/2, height/2+roundness-roundness/2],
            [width/2-take_in-roundness/2, height/2+roundness-roundness/2],
            [width/2-take_in-roundness/2, height/2-5-roundness/2],
            [width/2-roundness/2, height/2-7-roundness/2],
            [width/2-roundness/2, -height/2+roundness/2]]);
}

module lid()
{
    linear_extrude(10)
    minkowski()
    {
        square(width-roundness, center=true);
        circle(d=roundness);
    }
}
