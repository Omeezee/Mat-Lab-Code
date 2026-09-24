%%part 1
dt = 0.01;
t = 0:dt:10;
%0.5 Hz sine wave to verify its done wel 
F1 = 1 + sin(2*pi*0.5*t);
figure;
plot(t,F1);
xlabel('time s');
ylabel('force');
title('Section 1 Force Input');
grid on;

%maxwell force funciton 
xR0 = 0;

[x1, xR1] = maxwellForced(F1, 1,   1, xR0, dt);
[x2, xR2] = maxwellForced(F1, 2,   1, xR0, dt);
[x3, xR3] = maxwellForced(F1, 0.5, 2, xR0, dt);
figure;
plot(t,x1); hold on;
plot(t,xR1);
plot(t,x2);
plot(t,xR2);
plot(t,x3);
plot(t,xR3);
xlabel('time s');
ylabel('length');
title('Maxwell Model Lengths');
legend('x: R=1,E=1','x_R: R=1,E=1', ...
       'x: R=2,E=1','x_R: R=2,E=1', ...
       'x: R=0.5,E=2','x_R: R=0.5,E=2');
grid on;

%increasing r reduces flow because of the derivative so larger r gives slower graph. smaller r
%gives faster graph. Increaesing E reduces the F/E step elastic
%displacement become smaller. in cyclic cycles the spring gives osicalltion
%changes in length hile the r becomes slower making it creep. 
%% section 2
% 0.5 Hz sine wave, min = -1, max = 1
F2 = sin(2*pi*0.5*t);

figure;
plot(t,F2);
xlabel('Time (s)');
ylabel('Force');
title('Section 2 Force Input');
grid on;

[x1_loop] = maxwellForced(F2, 1, 1, xR0, dt);
[x2_loop] = maxwellForced(F2, 2, 1, xR0, dt);
[x3_loop] = maxwellForced(F2, 1, 2, xR0, dt);

figure;
plot(x1_loop,F2); hold on;
plot(x2_loop,F2);
plot(x3_loop,F2);
xlabel('displacmenet x');
ylabel('force F');
title('maxwell force length loops');
legend('R=1,E=1','R=2,E=1','R=1,E=2');
grid on;

%increasing r reduces flow because of the derivative so larger r gives slower graph. smaller r
%gives faster graph. Increaesing E reduces the F/E step elastic
%displacement become smaller. in cyclic cycles the spring gives osicalltion
%changes in length hile the r becomes slower making it creep. 
%% section 3
F3 = zeros(size(t));
F3(t > 1) = 1;

figure;
plot(t,F3);
xlabel('time s');
ylabel('force');
title('section 3 step force');
grid on;
x0 = 0;
x_v1 = voigtForced(F3, 1, 1, dt, x0);
x_v2 = voigtForced(F3, 2, 1, dt, x0);
x_v3 = voigtForced(F3, 2, 2, dt, x0);
x_v4 = voigtForced(F3, 4, 2, dt, x0);
figure;
plot(t,x_v1); hold on;
plot(t,x_v2);
plot(t,x_v3);
plot(t,x_v4);
xlabel('time s');
ylabel('displacment x');
title('Voigt');
legend('R=1,E=1','R=2,E=1','R=2,E=2','R=4,E=2');
grid on;

% the response speed depends on E/R a larger E/R gives faster setteling and
% a smaller one is slower. THe equilib discplacment is found when dx/dt is
% 0. larger spring stiffness gives samller displacmenet 
%% section 4

F4 = sin(2*pi*2*t);

figure;
plot(t,F4);
xlabel('Time (s)');
ylabel('Force');
title('Section 4 Force Input');
grid on;

x_loop1 = voigtForced(F4, 1, 1, dt, x0);
x_loop2 = voigtForced(F4, 2, 1, dt, x0);
x_loop3 = voigtForced(F4, 1, 2, dt, x0);

figure;
plot(x_loop1,F4); hold on;
plot(x_loop2,F4);
plot(x_loop3,F4);
xlabel('Displacement x');
ylabel('Force F');
title('Voigt Force-Length Loops');
legend('R=1,E=1','R=2,E=1','R=1,E=2');
grid on;
%dashpot reistance chanes the loop becuase increase the lag between force
%and displacment makes it slower. which makes the hystersis loop wider and
%incrases are of loop more energy is lost. 
%% section 5
F5 = zeros(size(t));
F5(t > 1) = 1;

figure;
plot(t,F5);
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
plot(t,x_k1); hold on;
plot(t,x_k2);
plot(t,x_k3);
plot(t,x_k4);
xlabel('Time (s)');
ylabel('Displacement x');
title('Kelvin Body Creep Response');
legend('E1=1,E2=1,R=1', ...
       'E1=1,E2=1,R=2', ...
       'E1=1,E2=2,R=2', ...
       'E1=2,E2=2,R=1');
grid on;

%ratio e2/r control how quick the branch responds larger e2/r means faster
%responses and shorter time to steaed state. smaller e2/r is slower
%repsosne at equilibriu, the dashpot stops changing so e2 branch is not
%importnat to long term impact that will leave e1 to determine the final
%displacement larger e1 gives a smaller equilib lenght