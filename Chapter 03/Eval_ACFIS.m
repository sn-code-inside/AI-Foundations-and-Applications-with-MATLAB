
% Evaluate our air conditioner FIS
% Eval_ACFIS.m
% August 29, 2023

fis = readfis('ac_fis');
output = evalfis(fis, [70 2.5])
input = [38 0.6; 42 1.2; 48 1.5; 52 1.8; 67 3.2; 70 3.3; 78 4.1; 45 5.0; 89 4.8;
                82 3.6; 72 4.2; 69 1.6; 58 2.3; 48 2.2; 59 3.3; 67 4.1; 79 3.5; 81 3.8];
output = evalfis(fis, input)

plot(output, 'b-o', 'LineWidth',2);
grid;
legend('output', 'Location', 'northeast');


