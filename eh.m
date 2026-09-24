%% BIOE 3071 - Viscoelastic Material Models
clear; clc; close all;

%% =========================
% Section 1: Maxwell Model
% ==========================
dt = 0.01;
t = 0:dt:10;

% 0.5 Hz sine wave, min = 0, max = 2
% Hint: a sine with amplitude 1 and offset 1 does this
F1 = 1 + sin(2*pi*0.5*t);

figure;
plot(t,F1,'LineWidth',1.5);
xlabel('Time (s)');
ylabel('Force');
title('Section 1 Force Input');
grid on;

% Parameter sets:
% (1) R=1, E=1
% (2) R=2, E=1
% (3) R=0.5, E=2
xR0 = 0;

[x1, xR1] = maxwellForced(F1, 1,   1, xR0, dt);
[x2, xR2] = maxwellForced(F1, 2,   1, xR0, dt);
[x3, xR3] = maxwellForced(F1, 0.5, 2, xR0, dt);

figure;
plot(t,x1,'LineWidth',1.5); hold on;
plot(t,xR1,'--','LineWidth',1.5);
plot(t,x2,'LineWidth',1.5);
plot(t,xR2,'--','LineWidth',1.5);
plot(t,x3,'LineWidth',1.5);
plot(t,xR3,'--','LineWidth',1.5);
xlabel('Time (s)');
ylabel('Length');
title('Maxwell Model Lengths');
legend('x: R=1,E=1','x_R: R=1,E=1', ...
       'x: R=2,E=1','x_R: R=2,E=1', ...
       'x: R=0.5,E=2','x_R: R=0.5,E=2');
grid on;

% Increasing R reduces dashpot flow because dx_R/dt = F/R, so larger R gives
% slower viscous elongation and less creep over time. Smaller R gives faster
% dashpot elongation and more creep. Increasing E reduces the spring term F/E,
% so the instantaneous elastic displacement becomes smaller. Under cyclic
% loading, the spring gives oscillatory changes in length while the dashpot
% causes creep, so the total length shows both cyclic variation and drift.

%increasing r reduces flow because of the derivative so larger r gives slower graph. smaller r
%gives faster graph. Increaesing E reduces the F/E step elastic
%displacement become smaller. in cyclic cycles the spring gives osicalltion
%changes in length hile the r becomes slower making it creep. 
%% =========================
% Section 2: Maxwell force-length loops
% ==========================
% 0.5 Hz sine wave, min = -1, max = 1
F2 = sin(2*pi*0.5*t);

figure;
plot(t,F2,'LineWidth',1.5);
xlabel('Time (s)');
ylabel('Force');
title('Section 2 Force Input');
grid on;

[x1_loop, ~] = maxwellForced(F2, 1, 1, xR0, dt);
[x2_loop, ~] = maxwellForced(F2, 2, 1, xR0, dt);
[x3_loop, ~] = maxwellForced(F2, 1, 2, xR0, dt);

figure;
plot(x1_loop,F2,'LineWidth',1.5); hold on;
plot(x2_loop,F2,'LineWidth',1.5);
plot(x3_loop,F2,'LineWidth',1.5);
xlabel('Displacement x');
ylabel('Force F');
title('Maxwell Force-Length Loops');
legend('R=1,E=1','R=2,E=1','R=1,E=2');
grid on;

% Increasing E decreases displacement at peak force because the elastic part
% of displacement is F/E. Increasing R slows dashpot motion, so less viscous
% displacement accumulates during a cycle. Hysteresis occurs because the
% dashpot depends on loading history. Changes in R and E alter both the peak
% displacement and the loop shape by changing the balance between elastic and
% viscous behavior.


%% =========================
% Section 3: Voigt creep test
% ==========================
F3 = zeros(size(t));
F3(t > 1) = 1;

figure;
plot(t,F3,'LineWidth',1.5);
xlabel('Time (s)');
ylabel('Force');
title('Section 3 Step Force');
grid on;

x0 = 0;

x_v1 = voigtForced(F3, 1, 1, dt, x0);
x_v2 = voigtForced(F3, 2, 1, dt, x0);
x_v3 = voigtForced(F3, 2, 2, dt, x0);
x_v4 = voigtForced(F3, 4, 2, dt, x0);

figure;
plot(t,x_v1,'LineWidth',1.5); hold on;
plot(t,x_v2,'LineWidth',1.5);
plot(t,x_v3,'LineWidth',1.5);
plot(t,x_v4,'LineWidth',1.5);
xlabel('Time (s)');
ylabel('Displacement x');
title('Voigt Creep Response');
legend('R=1,E=1','R=2,E=1','R=2,E=2','R=4,E=2');
grid on;

% For the Voigt model, dx/dt = (F - E*x)/R, so the response speed depends on
% E/R. A larger E/R gives faster settling, while a smaller E/R gives slower
% settling. The equilibrium displacement is found when dx/dt = 0, so F = E*x
% and therefore x_eq = F/E. Larger spring stiffness gives smaller final
% displacement.

% the response speed depends on E/R a larger E/R gives faster setteling and
% a smaller one is slower. THe equilib discplacment is found when dx/dt is
% 0. larger spring stiffness gives samller displacmenet 
%% =========================
% Section 4: Voigt force-length loops
% ==========================
% 2 Hz sine wave, min = -1, max = 1
F4 = sin(2*pi*2*t);

figure;
plot(t,F4,'LineWidth',1.5);
xlabel('Time (s)');
ylabel('Force');
title('Section 4 Force Input');
grid on;

x_loop1 = voigtForced(F4, 1, 1, dt, x0);
x_loop2 = voigtForced(F4, 2, 1, dt, x0);
x_loop3 = voigtForced(F4, 1, 2, dt, x0);

figure;
plot(x_loop1,F4,'LineWidth',1.5); hold on;
plot(x_loop2,F4,'LineWidth',1.5);
plot(x_loop3,F4,'LineWidth',1.5);
xlabel('Displacement x');
ylabel('Force F');
title('Voigt Force-Length Loops');
legend('R=1,E=1','R=2,E=1','R=1,E=2');
grid on;

% Increasing dashpot resistance increases the viscous effect during cyclic
% motion, which increases phase lag between force and displacement. This makes
% the hysteresis loop wider and increases the area inside the loop, meaning
% more energy is dissipated.

%dashpot reistance chanes the loop becuase increase the lag between force
%and displacment makes it slower. which makes the hystersis loop wider and
%incrases are of loop more energy is lost. 
%% =========================
% Section 5: Kelvin Body creep test
% ==========================
F5 = zeros(size(t));
F5(t > 1) = 1;

figure;
plot(t,F5,'LineWidth',1.5);
xlabel('Time (s)');
ylabel('Force');
title('Section 5 Step Force');
grid on;

xR0 = 0;
x0  = 0;

[x_k1, xR_k1] = kelvinForced(F5, 1, 1, 1, xR0, x0, dt);
[x_k2, xR_k2] = kelvinForced(F5, 2, 1, 1, xR0, x0, dt);
[x_k3, xR_k3] = kelvinForced(F5, 2, 1, 2, xR0, x0, dt);
[x_k4, xR_k4] = kelvinForced(F5, 1, 2, 2, xR0, x0, dt);

figure;
plot(t,x_k1,'LineWidth',1.5); hold on;
plot(t,x_k2,'LineWidth',1.5);
plot(t,x_k3,'LineWidth',1.5);
plot(t,x_k4,'LineWidth',1.5);
xlabel('Time (s)');
ylabel('Displacement x');
title('Kelvin Body Creep Response');
legend('E1=1,E2=1,R=1', ...
       'E1=1,E2=1,R=2', ...
       'E1=1,E2=2,R=2', ...
       'E1=2,E2=2,R=1');
grid on;

% The ratio E2/R controls how quickly the Kelvin branch responds. Larger E2/R
% means a faster response and shorter settling time, while smaller E2/R means
% a slower response. At equilibrium, the dashpot stops changing length, so the
% E2 branch no longer contributes to long-term deformation. That leaves E1 to
% determine the final displacement, so x_eq = F/E1. Larger E1 gives a smaller
% equilibrium length

%ratio e2/r control how quick the branch responds larger e2/r means faster
%responses and shorter time to steaed state. smaller e2/r is slower
%repsosne at equilibriu, the dashpot stops changing so e2 branch is not
%importnat to long term impact that will leave e1 to determine the final
%displacement larger e1 gives a smaller equilib lenght