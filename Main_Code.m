%% Defining symbolic variables (symbolic toolkit)
% This section will help us solve the non-linear part of the governing
% equations.
syms mB_t2 uB_t2 xB_t2 mB0

% Defining the known variables
hAO_avg = 116.4; % Value of hAO_avg
mAO = 5.408;     % Value of mAO
hBE = 11.44;     % Value of hBE
VB = 2.5;      % Value of VB
vB_f_t2 = 0.01193; % Value of vB_f_t2
vB_fg_t2 = 1.915;% Value of vB_fg_t2
uB_f_t2 = 13.73; % Value of uB_f_t2
uB_fg_t2 = 81.59;% Value of uB_fg_t2
mB_t1 = 36.24;   % Value of mB_t1
uB_t1 = 0.8761;   % Value of uB_t1
sb0 = 0.02605;

% Defining the four governing equations
eq1 = mB_t2 * uB_t2 - mB_t1 * uB_t1 == hAO_avg * mAO - hBE * mB0;
eq2 = mB_t2 == VB / (vB_f_t2 + xB_t2 * vB_fg_t2);
eq3 = mB_t2 - mB_t1 == mAO - mB0;
eq4 = uB_t2 == uB_f_t2 + xB_t2 * uB_fg_t2;

% Solving for the unknowns
sol = solve([eq1, eq2, eq3, eq4], [mB_t2, uB_t2, xB_t2, mB0]);

% Assinging the solutions to the variables
mB_t2_sol = sol.mB_t2;
uB_t2_sol = sol.uB_t2;
xB_t2_sol = sol.xB_t2;
mB0_sol = sol.mB0;

% Converting solutions to 5 decimal places
mB_t2_sol = vpa(sol.mB_t2, 5);
uB_t2_sol = vpa(sol.uB_t2, 5);
xB_t2_sol = vpa(sol.xB_t2, 5);
mB0_sol = vpa(sol.mB0, 5);

% Displaying the results
disp('Solution for mB_t2:');
disp(mB_t2_sol);
disp('Solution for uB_t2:');
disp(uB_t2_sol);
disp('Solution for xB_t2:');
disp(xB_t2_sol);
disp('Solution for mB0:');
disp(mB0_sol);
 
%% Solving the linear terms
% The following code solves the linear terms involved in the governing
% equations, allowing us to construct a 10x10 matrix.

% Defining values (The values are obtained from Linear_Interpolation_Code,
% also available on Github.
% These property values are defined in the problem by defining the state of
% the working fluid.

ha1 = 113.9; % [Btu/lbm]
hgb2 = 103.8; % [Btu/lbm]
mb1 = 36.24; % [lbm]
Pb1 = 7.432; % [psia]
sb1 = 0.002314; % [Btu/lbm-R]
TA2 = 80; % [F]
TLeave = 5.287; % [F]
ubfg2 = 81.59; % [Btu/lbm]
VolB = 2.5; % [ft^3]
vfb2 = 0.01193; % [ft^3/lbm]
sa2 = 0.2549;
ha2 = 118.9; % [Btu/lbm]
hLeave = hBE; % [Btu/lbm]
mb2 = mB_t2_sol; % [lbm]
PB2 = 23.85; % [lbf/in^2]
TB = -40; % [F]
ua1 = 105.1; % [Btu/lbm]
ufb2 = 13.73; % [Btu/lbm]
va1 = 0.4707; % [ft^3/lbm]
vgb2 = 1.927; % [ft^3/lbm]
xg2 = 1;
ub1 = 0.8761;
sao = 0.2373;
hao = 116.4; % [Btu/lbm]
hb1 = 0.971; % [Btu/lbm]
ma1 = 6.798; % [lbm]
mb0 = mB0_sol; % [lbm]
Pa1 = 101.4; % [psia]
Pgb2 = 23.85; % [lbf/in^2]
sa1 = 0.2197; % [Btu/lbm-R]
sbfg2 = 0.1937; % [Btu/lbm-R]
sLeave = sb0; % [Btu/lbm-R]
Tb1 = -40; % [F]
ua2 = 108.8; % [Btu/lbm]
va2 = 2.301; % [ft^3/lbm]
xA1 = 1;
xLeave = 0;
TT = 539.67;
sfb2 = 0.03111;
hfb2 = 13.79; % [Btu/lbm]
ma0 = 5.408; % [lbm]
PLeave = 23.95; % [lbf/in^2]
sa0 = 0.2373; % [Btu/lbm-R]
sgb2 = 0.2248; % [Btu/lbm-R]
TA1 = 80; % [F]
Tfb2 = 5.104; % [F]
ugb2 = 16.27; % [Btu/lbm]
VolA = 3.2; % [ft^3]
vbfg2 = 1.915; % [ft^3/lbm]
xB = 0.01;
xB_t2 = xB_t2_sol;
vb1 = 0.06898;
% Writing the matrix
A = [1 0 0 0 0 0 0 -1 1 0;
    -hao 1 0 0 0 0 0 ua1 -ua2 0;
    -sao -1/TT 1 0 0 0 0 -sa1 sa2 0;
    1 0 0 -1 0 0 0 0 0 1;
    sa0 0 0 -sLeave 1 -mb2 0 0 0 sb1;
    0 0 0 0 0 1 0 0 0 0;
    -hao 0 0 hLeave 0 0 mb2 0 0 -ub1;
    0 0 0 0 0 0 0 1 0 0;
    0 0 0 0 0 0 0 0 1 0;
    0 0 0 0 0 0 0 0 0 1];
B = [0;0;0;mb2;0;sfb2+xB_t2_sol*sbfg2;0;VolA/va1;VolA/va2;VolB/vb1];
X = A\B;
disp('SgenB')
disp(X(5))
disp('quality')
disp(xB_t2_sol)
disp('mass left in  b')
disp(mb2)
disp('Sgen B')
disp(X(5))
disp('SgenA')
disp(X(3))
disp('Heat Transfer')
disp(X(2))

%% Clearing
clc, clear
