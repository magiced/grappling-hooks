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

trapezoid(10,7,10,1);

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

translate([0,30,0])
triangle(20,20,10,true);