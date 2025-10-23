
% Generate a customer environment for a DC motor system
% This piece of codes is to call 2 functions to build a customer environment
% July 27, 2024

ObsInfo = rlNumericSpec([2 1]);
ObsInfo.Name = "Motor States";
ObsInfo.Description = 'theta, dtheta';

ActInfo = rlFiniteSetSpec([-50 50]);
ActInfo.Name = "Motor Action";
Action = 0;

[InitialObservation, Info] = mResetFunction()
[NextObservation, Reward, IsDone, UpdatedInfo] = mStepFunction(Action, Info)

motor_func_env = rlFunctionEnv(ObsInfo, ActInfo, "mStepFunction", "mResetFunction")

