function [x, xR] = kelvinForced(F, R, E1, E2, xR0, x0, dt)
    x = zeros(size(F));
    xR = zeros(size(F));
%starting condition
    x(1) = x0;
    xR(1) = xR0;
% forwad eular inte
    for i = 1:length(F)-1
        dxRdt = E2 * (x(i) - xR(i)) / R;
        xR(i+1) = xR(i) + dxRdt * dt;
% Update total length using F(i+1) and xR(i+1)
        x(i+1) = (F(i+1) + E2*xR(i+1)) / (E1 + E2);
    end
end