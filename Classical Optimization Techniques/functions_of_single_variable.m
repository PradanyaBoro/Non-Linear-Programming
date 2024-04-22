% Define symbolic variable
syms x 'real'

% Define the function f1(x)
f1 = x^3 - 6*x^2 + 9*x + 1;

% Find the first-order derivative of f1
f_x = diff(f1, x);

% Solve for critical points by setting the first-order derivative to zero
sol = solve(f_x == 0, x);

% Find the second-order derivative of f1
f_x2 = diff(f_x, x);

% To check the number of critical points
n = size(sol, 1);

% Loop through each critical point
for i = 1:n
    % Calculate the second-order derivative for each critical point
    val = subs(f_x2, x, sol(i));
    
    % Substitute critical points in the function to find max/min
    val_f1 = subs(f1, x, sol(i));
    
    % Determine the nature of the critical point and print the result
    if val > 0
        fprintf('%f is a local minimum, and the minimum value is %f\n', sol(i), val_f1)
    elseif val < 0
        fprintf('%f is a local maximum, and the maximum value is %f\n', sol(i), val_f1)
    else
        fprintf('%f is a point of inflection\n', sol(i))
    end
end

% Plot the function for verification
fplot(f1)
xlabel('x-axis');
ylabel('f1(x)');
title('Plot of the Function f1(x)');
