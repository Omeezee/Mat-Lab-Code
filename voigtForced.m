function x = voigtForced(F, R, E, dt, x0)
    x = zeros(size(F));
    dxdt = zeros(size(F));
    % starting
    x(1) = x0;
    % foraward eular int
    for i = 1:length(F)-1
        % From F = E*x + R*dx/dt
        dxdt(i) = (F(i) - E*x(i)) / R;
        x(i+1) = x(i) + dxdt(i) * dt;
    end
end