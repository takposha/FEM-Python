clear all; 
clc;  

function y=SpringAssemble(K, k, ni, nj)
K(ni,ni)=K(ni,ni)+k(1,1);
K(ni,nj)=K(ni,nj)+k(1,2);
K(nj,ni)=K(nj,ni)+k(2,1);
K(nj,nj)=K(nj,nj)+k(2,2);
y=K;
end

k_i=[1; 1; 1]; %N/m
nn=4; %number of the nodes (for plot)
syms U1 U2 U3 U4 P;
U(1,1)=0; U(2,1)=U2; U(3,1)=0; U(4,1)=0;
F(2,1)=P;

for ai=1:4;
    k=k_single{1,ai};
    ni=ai; nj=ai+1;
    K=SpringAssemble(K, k, ni, nj);
end

disp('The Global stiffness matrix is : '); 
K
Kc = K; 
X = 10000000;
Kc(1,1) = X; 
Kc(3,3) = X; 
Kc(4,4) = X; 
P = 10; 
F = [0; P; 0; 0]; 
u = linsolve(Kc,F) 
