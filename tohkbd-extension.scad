$fn = 50;
depth = 4.7;
bt = 0.8;
bw = 2.6;
ch = 1.5;
width = 130;
height = 28;
sp = depth - ch - bt;

magdiam = 9.5;
magbord = magdiam + 5;
magcdep = 0.6;
msx = 6.9;
msy = 12.85;

ppud = 4.5;
ppdd = 2;
ppy = 19.05;
ipd = 4;

pbb = bw + 1.6;
cbay = 27;
cbayh = 11;
lrbay = 43;
bayx = 5.7;

dpud = 5;
dudd = 2.8;
ddep = 0.6;
dmpx = 17.2;
dmpy = 12.9;


difference() {
    cl = width / 2;
    cube ([width,depth,height], false);
    difference() {
        union() {
            translate([bw,0,bw]) cube ([width-bw*2,sp,height-bw*2], false);
            bvt = [bayx, width - bayx - lrbay];
            for (i = [0,1]) {
               xp = bvt[i];
               translate([xp,0,pbb]) cube([lrbay,depth-bt, height-pbb*2]);
            }
            translate([cl-(cbay/2),0,pbb]) cube([cbay,depth-bt,cbayh]);
        }
        for (i = [-1,1]) {
            xp = cl + (i*(cl - msx));
            translate([xp,depth-magcdep,msy]) rotate([90,0,0]) cylinder(d = magbord, h = depth - magcdep);
        }
    }
            
    for (i = [-1,1]) {
        xp = cl + (i*(cl - msx));
        translate([xp,depth - magcdep,msy]) rotate ([90,0,0]) cylinder(d = magdiam, h = depth - magcdep);
    }
    for (i = [-3:2]) {
        xp = cl + (i + 0.5)*ipd;
        translate([xp,depth,ppy]) rotate([90,0,0]) cylinder(d = ppdd, h = bt);
        translate([xp,depth-bt,ppy]) rotate([90,0,0]) cylinder(d1 = ppdd, d2 = ppud, h = ch);
    }
    for (i = [-1,1]) {
        xp = cl + (i*(cl - dmpx));
        translate([xp,depth,dmpy]) rotate ([90,0,0]) cylinder(d1 = dpud, d2=dudd, h = ddep);
    }
    
    connbay = 21.59;
    cbt = [bayx + lrbay - connbay, width - bayx - lrbay];
    
    for (i = [0,1]) {
       xp = cbt[i];
       translate([xp,0,height-pbb]) cube([connbay,depth-bt,pbb]);
    }

    

}

