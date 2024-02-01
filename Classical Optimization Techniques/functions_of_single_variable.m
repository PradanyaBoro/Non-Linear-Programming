syms x 'real'

f1 = x^3 - 6*x^2 + 9*x + 1;  % Define the function

f_x = diff(f1,x);    % Find first order derivative of f
sol = solve(f_x == 0, x);    % Solve f(x)=0

f_x2 = diff(f_x,x);  % Find 2nd order derivative of f

n = size(sol,1);    % To check the number of critical points
for i = 1:1:n       % Calculate 2nd order derivative for each critical points
    val = subs(f_x2, x, sol(i));    % Substitute critical points in 2nd order derivative
    val_f1 = subs(f1, x, sol(i));   % Substitute critical points in function to find max/min
    if val > 0
        fprintf('%f is local minima ', sol(i))
        fprintf('and minimum value is %f\n', val_f1)
    elseif val < 0
        fprintf('%f is local maxima ', sol(i))
        fprintf('and maximum value is %f\n', val_f1)
    else
        fprintf('%f is a point of inflection\n', sol(i))
    end
end

fplot(f1)   % Plot the function for verification
