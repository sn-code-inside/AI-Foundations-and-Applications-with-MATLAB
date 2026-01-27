
% Initialize and configure the customer Simulink environment model
% Name: motor_simulink_env.m
% The name of the Simulink environment model is: motor.slx
% Output: motor_s_env
% Aug 2, 2024

mdl = "motor";
open_system(mdl)

actionInfo = rlNumericSpec([1 1]);
actionInfo.Name = "speed";

open_system(mdl + "/generate observations");
observationInfo = rlNumericSpec([2 1],...
    LowerLimit=[-50 0]',...
    UpperLimit=[50 0.035]');

observationInfo.Name = "observations";
observationInfo.Description = "speed,  speed_error";

open_system(mdl + "/calculate reward");
open_system(mdl + "/stop simulation");

motor_s_env = rlSimulinkEnv(mdl, mdl + "/RL Agent", observationInfo, actionInfo)

