%% Voigt model solved with ode45
clear; clc; close all;

% Time span
tspan = [0 10];

% Parameters
R = 1;
E = 1;
x0 = 0;

% Force function: 0.5 Hz sine wave
Ffun = @(t) sin(2*pi*0.5*t);

% Voigt ODE:
% F(t) = E*x + R*dx/dt
% so
% dx/dt = (F(t) - E*x)/R
odefun = @(t,x) (Ffun(t) - E*x)/R;

% Solve with ode45
[t, x] = ode45(odefun, tspan, x0);

% Evaluate force on the same time points
F = Ffun(t);

% Plot force and displacement
figure;
plot(t, F, 'LineWidth', 1.5); hold on;
plot(t, x, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Voigt Model with ode45: Force and Displacement');
legend('Force F(t)', 'Displacement x(t)');
grid on;

% Plot displacement for 10 evenly spaced resistances from 0.01 to 10
Rvals = linspace(0.01, 10, 10);

figure;
hold on;
for k = 1:length(Rvals)
    Rk = Rvals(k);
    odefun_k = @(t,x) (Ffun(t) - E*x)/Rk;
    [tk, xk] = ode45(odefun_k, tspan, x0);
    plot(tk, xk, 'LineWidth', 1.2);
end
xlabel('Time (s)');
ylabel('Displacement x');
title('Voigt Model Displacement for 10 Resistance Values');
legend('R=0.01','R=1.12','R=2.23','R=3.34','R=4.45', ...
       'R=5.56','R=6.67','R=7.78','R=8.89','R=10.00', ...
       'Location','best');
grid on;


% I used AI chat gpt make this code by putting in what needed to be done
% from the assignment "Create a new script and close your solution to the problems above. Enable MATLAB’s Copilot integration and use Copilot (or the AI tool of your choice) to answer the following question. You can edit the produced code if you need to. Include a comment describing the steps you took to get the AI solution including prompts and manual edits. Solve for the position of the Voigt model with a resistance R=1 and elastance E=1 over a 10 second time span. The force (F) applied to the model is a 0.5 Hz sine wave. Use the ode45 function to integrate dx/dt to calculate the displacement x. Plot the force and displacement. In another plot, show the displacement for 10 evenly spaced resistances from 0.01 to 10."
%i had to put in my orgiginal code for evrything too to make sure that it
%would produce accurate code. 