use <MCAD/2Dshapes.scad>

num_slices = 10;

radius = 20;

points = [
[0,0],
[radius,0],
[radius*(4/5),radius*(1/3)],
[radius*(1/3),radius*(4/5)],
[0,radius],
[0,0]
];

#polygon(points);

#circle(r=radius);

!pieSlice(radius,0,90);