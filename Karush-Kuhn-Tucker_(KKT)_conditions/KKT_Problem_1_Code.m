% Define symbolic variables x1, x2, l1, and l2 as real
syms x1 x2 l1 l2 'real';

% Calling the functions to get the expressions for the objective function and constraints
[f, g1, g2] = problem_1_function;

% Define the Lagrange's function using the objective function and Lagrange multipliers
l = f + l1 * g1 + l2 * g2;

% Find the gradient of the Lagrange's function with respect to x1 and x2
grad = gradient(l, [x1, x2]);

% Display KKT conditions
fprintf('Optimality condition: %s = 0 and %s = 0 \n', char(grad(1)), char(grad(2)));
fprintf('Feasibility condition : %s <= 0 and %s <= 0 \n', char(g1), char(g2));
fprintf('Complementary slackness : %s = 0 and %s = 0 \n', char(l1 * g1), char(l2 * g2));
fprintf('Condition 4: l1 <= 0 and l2 <= 0 \n\n');

solution_counter = 1;

% Case-1: when l1 == 0 and l2 == 0 -> condition 1 is in play
fprintf('Case-1: l1 == 0, l2 == 0 -> Condition 1 \n');

[sol_x1, sol_x2] = solve(subs(grad(1), [l1, l2], [0, 0]) == 0, subs(grad(2), [l1, l2], [0, 0]) == 0, x1, x2);

% Evaluate constraints for the obtained solution
val_g1 = subs(g1, [x1, x2], [sol_x1, sol_x2]);
val_g2 = subs(g2, [x1, x2], [sol_x1, sol_x2]);

% Check feasibility and print the result
if sol_x1 >= 0 && sol_x2 >= 0 && val_g1 <= 0 && val_g2 <= 0
    fprintf('(%f, %f) is feasible \n', sol_x1, sol_x2);
    solutions(solution_counter,:) = [sol_x1 sol_x2];
    solution_counter = solution_counter + 1;
else
    fprintf('(%f, %f) is infeasible\n', sol_x1, sol_x2);
end

% Repeat the process for other cases (Cases 2, 3, and 4)...
fprintf('case-2: when l1 == 0 and l2 /= 0 -> condition 2 is in play \n');

[sol_x1, sol_x2, ~] = solve(subs(grad(1), l1, 0) == 0, subs(grad(2), l1, 0) == 0, g2 == 0, x1, x2, l2);

val_g1 = subs(g1, [x1, x2], [sol_x1, sol_x2]);
val_g2 = subs(g2, [x1, x2], [sol_x1, sol_x2]);

if sol_x1 >= 0 && sol_x2 >= 0 && val_g1 <= 0 && val_g2 <= 0
    fprintf('(%f, %f) is feasible \n', sol_x1, sol_x2);
    solutions(solution_counter,:) = [sol_x1 sol_x2];
    solution_counter = solution_counter + 1;
else
    fprintf('(%f, %f) is infeasible \n', sol_x1, sol_x2);
end



fprintf('case-3: when l1 /= 0 and l2 == 0 -> condition 3 is in play \n');

[sol_x1, sol_x2, ~] = solve(subs(grad(1), l2, 0) == 0, subs(grad(2), l2, 0) == 0, g1 == 0, x1, x2, l1);

val_g1 = subs(g1, [x1, x2], [sol_x1, sol_x2]);
val_g2 = subs(g2, [x1, x2], [sol_x1, sol_x2]);

if sol_x1 >= 0 && sol_x2 >= 0 && val_g1 <= 0 && val_g2 <= 0
    fprintf('(%f, %f) is feasible \n', sol_x1, sol_x2);
    solutions(solution_counter,:) = [sol_x1 sol_x2];
    solution_counter = solution_counter + 1;
else
    fprintf('(%f, %f) is infeasible \n', sol_x1, sol_x2);
end

fprintf('case-4: when l1 /= 0 and l2 /= 0 -> condition 4 is in play \n');

[sol_x1, sol_x2, sol_l1, sol_l2] = solve(grad(1) == 0, grad(2) == 0, g1 == 0, g2 == 0, x1, x2, l1, l2);

val_g1 = subs(g1, [x1, x2], [sol_x1, sol_x2]);
val_g2 = subs(g2, [x1, x2], [sol_x1, sol_x2]);

if sol_x1 >= 0 && sol_x2 >= 0 && val_g1 <= 0 && val_g2 <= 0
    fprintf('(%f, %f) is feasible \n', sol_x1, sol_x2);
    solutions(solution_counter,:) = [sol_x1 sol_x2];
    solution_counter = solution_counter + 1;
else
    fprintf('(%f, %f) is infeasible \n', sol_x1, sol_x2);
end

% Find the solution that maximizes the objective function among feasible solutions
func_best = subs(f, [x1, x2], [solutions(1,1), solutions(1,2)]);
global_best = [solutions(1,1), solutions(1,2)];

for i = 1:size(solutions, 1)
    new = subs(f, [x1, x2], [solutions(i,1), solutions(i,2)]);
    if new > func_best
        func_best = new;
        global_best = [solutions(i,1), solutions(i,2)];
    end
end

% Print the final optimal solution
fprintf('Optimal solution: %f at (%f, %f) \n', func_best, global_best(1), global_best(2));