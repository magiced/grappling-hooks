use <MCAD/2Dshapes.scad>

module triangle (w_b, h, l, centre = false)
{

    points = [
    [0,0],
    [w_b,0],
    [w_b/2,h],
    ];

    trans = (centre == true) ? [-w_b/2,-h/2,0] : [0,0,0] ;

    translate(trans)
        linear_extrude(l)
            polygon(points);
}

module trapezoid (w_b, w_t, h, l, centre = false)
{
    top_offset = ( w_b - w_t )/2;

    points = [
    [0,0],
    [w_b,0],
    [top_offset+w_t,h],
    [top_offset,h]
    ];

    trans = (centre == true) ? [-w_b/2,-h/2,0] : [0,0,0] ;

    translate(trans)
        linear_extrude(l)
            polygon(points);
}



w_shaft = 5;
l_shaft = 60;
w_head = 10;
h_head = 9;
w_arm = 25;
h_arm = 20;
w_arm_end = 6;
point_width = 2;
point_height = 10;
w_point = w_arm + point_width;
h_point = h_arm + point_height;
w_reinforcer = 6;
thk_reinforcer = 2;
thk_hook = 2;
num_hooks = 3;

hole_dia = 6;

grap_points = 
[
[0,0],
[w_head,            0],
[w_arm,             h_arm],
[w_point,           h_point],
[w_arm-w_arm_end,   h_arm],
[w_shaft * 1.4,           h_head],
[w_shaft * 1.2,           h_head * 1.3],
[w_shaft,           l_shaft-w_shaft],
[(0.9)*w_shaft,     l_shaft-(0.6)*w_shaft],
[(0.5)*w_shaft,     l_shaft-(0.15)*w_shaft],
[0,l_shaft], 
[0,0]
];

module arm()
{
    union()
    {
        // hook profile
    rotate([90,0,0])
        linear_extrude(height=thk_hook,center=true)
            {
                polygon(grap_points);
            }
     // bottom reinforcer       
     translate([0,-w_reinforcer/2,0])
                cube([w_head,w_reinforcer,thk_reinforcer]);
      
      // calc arm flange angles      
      l_arm_flange = sqrt ( pow(h_arm, 2) + pow(w_arm-w_head, 2));      
      arm_flange_angle = atan( (w_arm-w_head)/h_arm );
      
      // arm flange      
      translate([w_head,-w_reinforcer/2,0])
        rotate([0,-arm_flange_angle,0])
            cube([l_arm_flange,w_reinforcer,thk_reinforcer]);
      
      // calc tip flange angles and dims      
      w_point = w_arm + point_width;
      h_point = h_arm + point_height;
      arm_point_angle = atan( (point_height)/point_width );
     
     // tip flange       
     rotate([0,0,-90])
        translate([-w_reinforcer/2,w_arm,h_arm])           
            rotate([arm_point_angle,0,0])
                trapezoid(w_reinforcer,thk_hook,point_height,thk_reinforcer,0);      
            
      }
}

difference()
{
    union()
    {
        // calc number of arms
        rot_angle = 360/num_hooks;
        for(i = [0: rot_angle: 359])
        {
            // make the arms
            rotate([0,0,i])
                arm();
        }

    }
    
    // cut out the end hole
    translate([0,0,l_shaft-w_shaft-2])
        sphere(d=hole_dia);
}