clc;
%Taking the input parameters
L = input('Enter the total length of the beams in mm : ');
A = input('Enter the area of the beam in mm^2 : ');
E = input('Enter the Young modulus of the beam in MPa : ');
P = input('Enter the load of the beam in N: ');
k = input('Enter the stiffness of the spring in N/mm : ');
e = input('Enter the number of total elements (including spring) : ');
n = e+1;
e_b = e-1;
c = 1;
K1 = zeros(n,n);
K2 = zeros(n,n);
%Getting the Global stiffness matrix
while c<e
    for i = c:c+1
        for j = c:c+1
            if (i == j)
                K1(i,j) = K1(i,j) + e_b*(A*E)/L;
            else
                K1(i,j) = K1(i,j) - e_b*(A*E)/L;
            end
        end
    end
    c=c+1;
end
for i = c:n
    for j = c:n
        if (i == j)
            K2(i,j) = k;
        else 
            K2(i,j) = -k;
        end
    end
end
K = K1+K2;
disp('The Global stiffness matrix is : '); disp(K);
%Applying the boundary conditions
Kg = K;
Kg(1,1) = 100000000000;
Kg(n,n) = 100000000000;
%The load matrix
F = [0;P;0;0];
%Solving for displacements
u = linsolve(Kg,F);
disp('The displacements in mm are : '); disp(u);
%The reactions are
react = K * u - F;
disp('The reactions at each node is : '); disp(react);