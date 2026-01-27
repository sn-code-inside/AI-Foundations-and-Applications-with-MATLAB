
% Evaluate our interval type-2 FIS
% Eval_IT2FIS.m
% September 10, 2023

fis = readfis('itype2_fis');
output = evalfis(fis, [0.2 0.05])

input = [0.2 0.05; 0.21 0.06; 0.02 0.02; 0.28 0.10; -0.23 0.08; -0.12 -0.02; 0.07 -0.03; 0.16 0.041; 
                0.19 0.14; 0.25 -0.08; 0.05 -0.09; 0.13 -0.13; -0.27 -0.11; 0.23 -0.15; 0.22 -0.08; 0.09 -0.09; 
                0.17 -0.041; 0.07 0.02; -0.21 0.13];

output = evalfis(fis, input)

plot(output, 'b-o', 'LineWidth',2);
grid;
legend('output', 'Location', 'northeast');
