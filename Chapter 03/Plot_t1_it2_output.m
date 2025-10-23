% Func:   Plot both FIS
% Name: Plot_t1_it2_output.m
% Date:   Sept. 19, 2023

plot(out.t1_out.Time, out.t1_out.Data, out.t2_out.Time, out.t2_out.Data, 'LineWidth',2);
grid;
legend('Type-1 FIS', 'IT2 FIS', 'Location', 'southeast');

% END
