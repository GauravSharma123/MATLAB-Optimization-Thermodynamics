%% Using Symbolic Toolkit for Linear Interpolation
% The following code helps us linearly interpolate the required property
% values given that we can input the saturated liquid and vapor values from
% established tables that can be accessed online or via textbook.

% The values are interpolated as an example for an exit pressure value of
% 23.85 psia.

% Defining the known variables for tank A
v_A = 3.2; % Listed in the problem
vg_At1 = 0.47119; % From the saturated table
m_At1 = v_A/vg_At1; % Using the basic definition
u_At1 = 105.11;
u_At2 = 108.786;

% Using linear interpolation to find specific volume of tank A at time t2
p_1 = 20; %From Saturated Table
p2 = 23.85; %From the problem
p_3 = 30; %From Saturated Table
vg_20 = 2.76; %From Superheated Table
vg_30 = 1.813; %From Superheated Table
% Calling the symbolic toolbox to interpolate the data
syms x
vg_A_t2 = vpa(solve((p2 - p_1) / (p_3 - ...
    p_1) == (x - vg_20) / (vg_30 - vg_20)));
m_At2 = (v_A / vg_A_t2); % Using the basic definition

% Defining the known variables for tank B
vf_Bt1 = 0.0113; %From saturated Table
vg_Bt1 = 5.7769; %From saturated Table
xBt1 = 0.01; %From the problem
vB1 = (1-xBt1) * vf_Bt1 + xBt1 * vg_Bt1; % Quality Definition
Vb = 2.5; %From the problem

% Defining the known variables for tank B
u_Bt1 = 0.87576; %From saturated Table

% Using linear interpolation to find the specific volume of the fluid in 
% tank B at time 2 (for sat liquid and sat vapor)
p_22 = 20; %From saturated Table
p2 = 23.85; %From the problem
p_25 = 25; %From saturated table
vf_22 = 0.01181; %From saturated Table
vf_23 = 0.01196; %From saturated Table
% Calling the symbolic toolkit
vf_Bt2 = (solve((p2 - p_22) / ...
    (p_25 - p_22) == (x - vf_22) / (vf_23 - vf_22)));

% Sat vapor
p_22 = 20; %From saturated Table
p2 = 23.85; %From the problem
p_25 = 25; %From saturated Table
vg_22 = 2.2781; %From Saturated Table
vg_25 = 1.8442; %From Saturated Table
% Calling the symbolic tool kit
vg_Bt2 = (solve((p2 - p_22) / ...
    (p_25 - p_22) == (x - vg_22) / (vg_25 - vg_22)));

% Using linear interpolation to find the specific internal energy
% of the fluid in tank B at time 2 (for sat liquid and sat vapor)
p_22 = 20; %From saturated Table
p2 = 23.85; %From the problem
p_25 = 25; %From saturated Table
uf_22 = 11.393; %From Saturated Table
uf_25 = 14.367; %From Saturated Table
% Calling the symbolic toolkit 
uf_Bt2 = (solve((p2 - p_22) / ...
    (p_25 - p_22) == (x - uf_22) / (uf_25 - uf_22)));
% Sat Vapor
p_20 = 20; %From saturated Table
p2 = 23.85; %From the problem
p_25 = 25; %From saturated Table
ug_20 = 94.31; %From Saturated Table
ug_25 = 95.62; %From Saturated Table
% Calling the symbolic toolkit 
ug_Bt2 = (solve((p2 - p_20) / ...
    (p_25 - p_20) == (x - ug_20) / (ug_25 - ug_20)));
% Solving for specific entropy values
% Sat Liquid
p_20 = 20; %From saturated Table
p2 = 23.85; %From the problem
p_25 = 25; %From saturated Table
sf_20 = 0.02603; %From Saturated Table
sf_25 = 0.03247; %From Saturated Table
% Calling the symbolic toolkit 
sf_Bt2 = (solve((p2 - p_20) / ...
    (p_25 - p_20) == (x - sf_20) / (sf_25 - sf_20)));

% Sat Vapor
p_20 = 20; %From saturated Table
p2 = 23.85; %From the problem
p_25 = 25; %From saturated Table
sg_20 = 0.22570; %From Saturated Table
sg_25 = 0.22465; %From Saturated Table
% Calling the symbolic toolkit 
sg_Bt2 = (solve((p2 - p_20) / ...
    (p_25 - p_20) == (x - sg_20) / (sg_25 - sg_20)));

% The following terms will also be solved on the matrix. The reason for
% them being solved in equation is to help us deal with the non-linearity
% presented in equation 35
mAo = (m_At1 - m_At2);
% Approximation for hAo_avg and sA0_avg
hg_At1 = 113.96; % Superheated Table
hg_At2 = 118.94; % Superheated Table
hAo_avg = (hg_At1 + hg_At2)/2;
s_At1 = 0.22045; % Saturated Table
s_At2 = 0.25534; % Simple Interpolation
sAo_avg = (s_At2+s_At1)/2;
% Defining known variables
hBe = 13.73522;
hBo = hBe;
h_Be = hBe;
m_Bt1 = Vb / vB1;