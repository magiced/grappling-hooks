$fn = 30;

num_hooks = 4;

w_hooks = 20;
d_hooks = 3;
l_hook_straights = 4;

l_tang = 30;
d_tang = 4;

d_ring = 5;
thk_ring = 2;


rot_angle = 360/num_hooks;
for(i = [0: rot_angle: 359])
{
    echo(i);
    rotate([0,0,i])
    translate([-w_hooks/2-d_hooks/2,0,w_hooks/2])
    rotate([270,0,0])
    hook(w_hooks,d_hooks,l_hook_straights);
}

//tang
translate([0,0,w_hooks/2])
    rounded_cylinder(d_tang,l_tang);

translate([0,0,l_tang+w_hooks/2+d_ring/2])
rotate([90,0,0])
round_ring(d_ring,thk_ring);

//TODO - try changing hook module to make a rectanglar section hook


module hook(width,dia,l_straight)
{
rotate_extrude(angle = 180)
translate([width/2,0,0])
{
circle(d=dia);
}

translate([width/2,0,0])
rotate([90,0,0])
cylinder(d=dia,h=l_straight);

translate([width/2,-l_straight,0])
sphere(d=dia);


translate([-width/2,0,0])
rotate([90,0,0])
cylinder(d=dia,h=l_straight);

translate([-width/2,-l_straight,0])
sphere(d=dia);
}

module rounded_cylinder(dia, length)
{
    sphere(d=dia);
    cylinder(d=dia,h=length);
    translate([0,0,length])
        sphere(d=dia);
}

module hole_tab(dia,hole_dia,l_centre_to_end,tab_thk)
{
    difference()
    {
        hull()
        {
            cylinder(d=dia,h=tab_thk);
            translate([l_centre_to_end-0.1,-dia/2,0])
                cube([0.1,dia,tab_thk]);
        }
        //hole
        cylinder(d=hole_dia,h=tab_thk);
    }
}

module round_ring(ring_dia,x_sec_dia)
{
    rotate_extrude()
    translate([ring_dia/2,0,0])
    circle(d=x_sec_dia);  
}