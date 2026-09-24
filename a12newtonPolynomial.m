function [coeffs, ddTable, polyFunc] = newtonPolynomial(xData, yData)
%This function, newtonPolynomial, takes in a set of x-values and corresponding y-values and builds the Newton interpolation polynomial. 
% It calculates a table of divided differences and extracts the coefficients that form the polynomial. 
% In addition, it returns a function that you can use to quickly evaluate the polynomial at any x-value. 
% For example, after calling [coeffs, ddTable, polyFunc] = newtonPolynomial(xData, yData), 
% you can find the estimated y-value at 2.5 by calling polyFunc(2.5).

    % Number of data points
    n = length(xData);
    
    % Initialize divided difference table
    ddTable = zeros(n,n);
    ddTable(:,1) = yData(:);  % first column is y-values

    % Build the divided difference table
    for col = 2:n
        for row = 1:(n - col + 1)
            ddTable(row,col) = (ddTable(row+1, col-1) - ddTable(row, col-1)) / ...
                                (xData(row+col-1) - xData(row));
        end
    end

    % The coefficients are the diagonal elements of ddTable
    coeffs = diag(ddTable)';

    % Create a function handle for polynomial evaluation using nested multiplication
    polyFunc = @(x) newtonEval(x, xData, coeffs);
end

function yVal = newtonEval(x, xData, coeffs)
% newtonEval: Evaluates the Newton polynomial at x using nested multiplication.
%
% INPUTS: x: scalar or vector of x-values at which to evaluate
%   xData  : vector of original x-values
%   coeffs : vector of Newton polynomial coefficients
%
% OUTPUT:
%   yVal   : evaluated polynomial values at x

    n = length(coeffs);
    yVal = coeffs(n) * ones(size(x));
    for k = (n-1):-1:1
        yVal = coeffs(k) + (x - xData(k)) .* yVal;
    end
end