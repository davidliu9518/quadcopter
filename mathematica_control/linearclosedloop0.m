(* *)
ClearAll["Global`*"];


Ix = 7.5*10^(-3); 
Iy = 7.5*10^(-3);  
Iz = 1.3*10^(-2);  
Jr = 6.5*10^(-5);  
b = 3.13*10^(-5);  
d = 7.5*10^(-7);   
l = 0.23;          
m = 0.65;          
g = 9.81;          
dt = 0.01;         


phidot = x4; thetadot = x5; psidot = x6;
phi = x1; theta = x2; psi = x3; 
x = x7; xdot = x10;
y = x8; ydot = x11; z = x9; zdot = x12; intz = x13;

(*phidot*)		x1dot = f1;
(*thetadot*)		x2dot = f2;
(*psidot*)		x3dot = f3;
(*phidotdot*)		x4dot = f4;
(*thetadotdot*)		x5dot = f5;
(*psidotdot*)		x6dot = f6;
(*xdot*)		x7dot = f7;
(*ydot*)		x8dot = f8;
(*zdot*)		x9dot = f9;
(*xdotdot*)		x10dot = f10;
(*ydotdot*)		x11dot = f11;
(*zdotdot*)		x12dot = f12;
(*zintdot*)		x13dot = f13;

f1 = x4 + G1;
f2 = x5 + G2;
f3 = x6 + G3;
f4 = ( ((Iy - Iz)/Ix)*(thetadot)*(psidot)) + (Jr/Ix *thetadot*Omega)+ G4;
f5 = ( ((Iz - Ix)/Iy )*(phidot)*(psidot)) - ((Jr/Iy)*phidot*Omega) + G5 ;
f6 = ( ((Ix - Iy)/Iz)*(phidot)*(thetadot)) + G6;
f7 = x10 + G7;
f8 = x11 + G8;
f9 = x12 + G9;
f10 = G10;
f11 = G11;
f12 = g - G12;
f13 = x9;

(**** Input scheme ****)
G1 = 0
G2 = 0
G3 = 0
G4 = (l/Ix)*u22;
G5 = (l/Iy*u32);
G6 = u42*(1/Iz);
G7 = 0;
G8 = 0;
G9 = 0;
G10 = ((Cos[phi]*Sin[theta]*Cos[psi]) + Sin[phi]*Sin[psi])*(u12/m);
G11 = ((Cos[phi]*Sin[theta]*Sin[psi]) - (Sin[phi]*Cos[psi]))*(u12/m);
G12 = ((u12)/m)*Cos[phi]*Cos[theta];

Omega = d*omegasqr5;
omegasqr5 = -omegasqr1 + omegasqr2 - omegasqr3 + omegasqr4;
omegasqr1 = (U1/(4*b)) + (U3/(2*b*l)) - (U4/(4*d));
omegasqr2 = (U1/(4*b)) - (U2/(2*b*l)) + (U4/(4*d));
omegasqr3 = (U1/(4*b)) - (U3/(2*b*l)) - (U4/(4*d));
omegasqr4 = (U1/(4*b)) + (U2/(2*b*l)) + (U4/(4*d));

u12 = (b)*(omegasqr1 + omegasqr2 + omegasqr3 + omegasqr4);
u22 = (b)*(-omegasqr2 + omegasqr4);
u32 = (b)*(omegasqr1 - omegasqr3);
u42 = (d)*(-omegasqr1 + omegasqr2 -omegasqr3 + omegasqr4);
(***********************************************************)

f = {f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13};
X = {x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13};
U = {U1, U2, U3, U4};

zx = {x1->0, x2->0, x3->0, x4->0, x5->0, x6->0, x7->0, x8->0, x9->0, x10->0, x11->0, x12->0, x13->0};
zu = {U1->0, U2->0, U3->0, U4->0};
zxu = {x1->0, x2->0, x3->0, x4->0, x5->0, x6->0, x7->0, x8->0, x9->0, x10->0, x11->0, x12->0, x13->0, U1->0, U2->0, U3->0, U4->0};

dfdX = Grad[f, X];
dfdU = Grad[f, U];

A0 = dfdX/.zxu;
B0 = dfdU/.zxu;

(* *)
U1 = (0.000000000000000040040329806638157622061132068177*psi - 0.000000000000000004006260662349088113459483121302*psidot + 0.000000000000000040199263120208627223437034754057*thetadot + 0.00000000000016481994537721932724351482870661*theta + 0.00000000000098891967226331596346108897223964*x + 0.0000000000079113573781065277076887117779171*xdot + 4.11553517599868712295574368909*z + 2.5199605312384134592207374225836*zdot + 3.1622776601683793319988935444327*intz);


U2 = (189.73665961010275991993361266596*y - 31.630275731249675175149604910985*phidot - 31.622776601683793319988935444327*phi + 1517.8932768808220793594689013277*ydot);

U3 = (0.00000000000000070138917281910823366567033228324*psidot + 0.00000000000000043749598496085489029482841870694*psi - 31.630275731249682280576962511986*d_theta - 31.622776601683793319988935444327*theta - 189.73665961010275991993361266596*x - 1517.8932768808220793594689013277*xdot - 0.0000000000000070356585091052359927346895193447*z - 0.0000000000000034839309111753163949802837487703*zdot - 0.000000000000011331008570360934389675285377061*intz);

U4 = (0.00000000000000040464873271944341320474427745137*d_theta - 1.0*psi - 1.0129165771177819355131077827537*d_psi + 0.00000000000023878030692159577841250980175465*theta + 0.0000000000014326818415295746704750588105279*x + 0.000000000011461454732236597363800470484223*xdot - 0.00000000000000031636295750377493337137733115377*z + 0.00000000000000020031329352465790704239314222127*zdot - 0.00000000000000010038228518403374163714875500275*intz);



		