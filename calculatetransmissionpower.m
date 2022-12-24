function Pr=calculatetransmissionpower(A,G,Pt,r)
%         A*G
% Pr = -------- Pt      .....(1)
%      4*pi*r^2
a1=A*G;
a2= r.^2;
a3=4*3.14*a2;
format bank
Pr = (a1/a3)*Pt;