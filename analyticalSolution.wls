#!/usr/bin/env wolframscript
(* Check if we're in the right directory *)
Directory[]

(* Import the numerical data *)
XZBz := Import["Output/XZBz.txt","Table"]

(* List the imported table to check it *)
(*XZBz*)

(* Split the coordinates into separate vectors *)
X := XZBz[[All,1]]
Z := XZBz[[All,2]]

(* List the variables to check them *)
(*X
Z*)

(* Definitions of constants *)
a := 7.25*^-3
L := 25*^-3
\[Micro] := 4*Pi*1*^-7
n := 125
current := 1*^-3
preFactor := (\[Micro]*n*current)/(2*Pi)

(* Definitions of simplifying variables *)
h[rho_] := Sqrt[4*a*rho/(a + rho)^2]
k[rho_,zeta_] := Sqrt[4*a*rho/((a + rho)^2 + zeta^2)]

(* Definitions of functions *)
Br[r_,z_] := preFactor*(1/L)((k[r,z+L/2]^2-2)/k[r,z+L/2])*EllipticK[k[r,z+L/2]^2]+(2/k[r,z+L/2])*EllipticE[k[r,z+L/2]^2]-((k[r,z-L/2]^2-2)/k[r,z-L/2])*EllipticK[k[r,z-L/2]^2]-(2/k[r,z-L/2])*EllipticE[k[r,z-L/2]^2]
Bz[r_,z_] := preFactor*(1/L)1/(Sqrt[a*r])*((z+L/2)k[r,z+L/2](EllipticK[k[r,z+L/2]^2]+((a-r)/(a+r))EllipticPi[h[r]^2,k[r,z+L/2]^2])-(z-L/2)k[r,z-L/2](EllipticK[k[r,z-L/2]^2]+((a-r)/(a+r))EllipticPi[h[r]^2,k[r,z-L/2]^2]))

(* Plot the z component of the B field to check it *)
(*Plot3D[Bz[r,z ],{r,0,1.5*a},{z,-L*2/3,L*2/3}]*)

(* Calculate the z component analytically *)
BzAnalytic := Re[Bz[X,Z]]
(*BzAnalytic*)

(* Collect points and Bx values into a matrix for export *)
dataForExport := Transpose[{X,Z,BzAnalytic}]
(*dataForExport*)

(* Export the data *)
Export["Output/XZBzAnalytic.txt",dataForExport,"Table"]