function [f, g1, g2] = problem_1_function

syms x1 x2 'real'

% Define the objective function
f = 7*x1^2 + 6*x1 + 5*x2^2;

% Define constraints
g1 = x1 + 2*x2 - 10;
g2 = x1 - 3*x2 - 9;

end