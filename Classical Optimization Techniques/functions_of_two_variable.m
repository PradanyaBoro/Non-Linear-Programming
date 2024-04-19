% Define symbolic variables x and y as real
syms x y 'real'

% Define the function f(x, y)
f = 2*x^2 - 4*x*y + y^4 + 2;

% Compute partial derivatives of f with respect to x and y
f_x = diff(f, x);
f_y = diff(f, y);

% Solve for critical points by setting partial derivatives to zero
[extrema_x, extrema_y] = solve(f_x == 0, f_y == 0, x, y);

% Compute second-order partial derivatives
f_xx = diff(f_x, x);
f_yy = diff(f_y, y);
f_xy = diff(f_y, x);

% Get the number of critical points
n = size(extrema_x, 1);

% Loop through each critical point
for i = 1:n
    % Evaluate second-order partial derivatives at the critical point
    Hxx = subs(f_xx, [x, y], [extrema_x(i), extrema_y(i)]);
    Hyy = subs(f_yy, [x, y], [extrema_x(i), extrema_y(i)]);
    Hxy = subs(f_xy, [x, y], [extrema_x(i), extrema_y(i)]);
    
    % Construct the Hessian matrix
    H = zeros(2, 2);
    H(1, 1) = Hxx;
    H(1, 2) = Hxy;
    H(2, 1) = Hxy;
    H(2, 2) = Hyy;
    
    % Calculate eigenvalues of the Hessian matrix
    e = eig(H);
    
    % Evaluate the function value at the critical point
    f_val = subs(f, [x, y], [extrema_x(i), extrema_y(i)]);
    
    % Determine the nature of the critical point and print the result
    if(all(e > 0))
        fprintf('(%f, %f) is a local minimum, and the minimum value is %f\n', ...
            extrema_x(i), extrema_y(i), f_val)
    elseif(all(e < 0))
        fprintf('(%f, %f) is a local maximum, and the maximum value is %f\n', ...
            extrema_x(i), extrema_y(i), f_val)
    else
        fprintf('(%f, %f) is a saddle point\n', extrema_x(i), extrema_y(i))
    end
end

% Plot the function

% Plot the function

% Convert symbolic expression to a function handle
f_handle = matlabFunction(f, 'Vars', [x, y]);

% Create a new figure for the mesh plot
figure;

% Generate a mesh plot using the function handle
[x_mesh, y_mesh] = meshgrid(linspace(min(extrema_x), max(extrema_x), 100), ...
                            linspace(min(extrema_y), max(extrema_y), 100));
z_mesh = f_handle(x_mesh, y_mesh);
mesh(x_mesh, y_mesh, z_mesh);

% Add title and axis labels to the plot
title('Mesh Plot of the Function');
xlabel('x-axis');
ylabel('y-axis');
zlabel('f(x, y)');
