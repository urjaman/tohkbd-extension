// circle accuracy
$fn = 50;

// general metrics
depth = 4.7;
bt = 0.8;
bw = 2.6;
ch = 1.5;
width = 130.4;
height = 28;
sp = depth - ch - bt;

// magnet holes and their border
magdiam = 9.52;
magbord = magdiam + 5;
magcdep = 0.6;
msx = 6.9;
msy = 12.85;

// pogo pins geometry
ppud = 4.5;
ppdd = 2;
ppy = 19.05;
ipd = 4;

// component depressions ("bays") geometry
pbb = bw + 1.6;
cbay = 27;
cbayh = 11;
lrbay = 43;
bayx = 5.7;

// alignment dimples location and geometry
dpud = 5;
dudd = 2.8;
ddep = 0.6;
dmpx = 17.2;
dmpy = 12.9;

// connector places width ( 8.5 * 2.54 ;) )
connbay = 21.59;

// tape area height, substracts from middle bay
tah = 8.6;

difference() {
    // cl = center line (TODO...)
    cl = width / 2;
    v = 0.5; // rounding factor for the master cube
    translate([v,v,v]) 
    minkowski() {  
    cube ([width-v*2,depth-v*2,height-v*2], false);
        sphere(r = v, $fn = 24);
    }
    difference() {
        union() {
            translate([bw,0,bw]) cube ([width-bw*2,sp,height-bw*2], false);
            // component bays, left and right
            bvt = [bayx, width - bayx - lrbay];
            for (i = [0,1]) {
               xp = bvt[i];
               translate([xp,0,pbb]) cube([lrbay,depth-bt, height-pbb*2]);
            }
        }
        // magnet borders
        for (i = [-1,1]) {
            xp = cl + (i*(cl - msx));
            translate([xp,depth-magcdep,msy]) rotate([90,0,0]) cylinder(d = magbord, h = depth - magcdep);
        }
        // slot for pcb on the upside
        mb = width - bayx*2 - lrbay*2;
        mbh = 0.8;
        mbs = 1.60;
        translate([cl-(mb/2),0,height-bw-mbh]) cube([mb,sp-mbs,mbh]);
    }
    
    // magnet holes
    for (i = [-1,1]) {
        xp = cl + (i*(cl - msx));
        translate([xp,depth - magcdep,msy]) rotate ([90,0,0]) cylinder(d = magdiam, h = depth - magcdep);
    }
    
    // pogo pin holes
    for (i = [-3:2]) {
        xp = cl + (i + 0.5)*ipd;
        translate([xp,depth,ppy]) rotate([90,0,0]) cylinder(d = ppdd, h = bt);
        translate([xp,depth-bt,ppy]) rotate([90,0,0]) cylinder(d1 = ppdd, d2 = ppud, h = ch);
    }
    
    // alignment dimples
    for (i = [-1,1]) {
        xp = cl + (i*(cl - dmpx));
        translate([xp,depth,dmpy]) rotate ([90,0,0]) cylinder(d1 = dpud, d2=dudd, h = ddep);
    }
    
    // connector places
    cbt = [bayx + lrbay - connbay, width - bayx - lrbay];
    for (i = [0,1]) {
       xp = cbt[i];
       translate([xp,0,height-pbb]) cube([connbay,depth-bt,pbb]);
    }

    // center "bay"
    cbah = ((cbayh + pbb ) - bw) - tah;
    translate([cl-(cbay/2),0,bw + tah]) cube([cbay,depth-bt,cbah]);

    // "tape area"
    translate([cl-(cbay/2),0,bw]) cube([cbay,sp+0.1,tah]);
    
}

