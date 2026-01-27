
% Create a built-in DQN Agent with MATLAB Functions
% Name: Create_DQN_Agent.m
% Input: Customer environment motor_func_env, which has been added in Workspace
% Output: Created and trained DQN agent
% Aug 6, 2024

obsInfo = getObservationInfo(pid_motor_env);
actInfo = getActionInfo(pid_motor_env);

agent = rlPGAgent(obsInfo, actInfo);

getAction(agent, {rand(obsInfo(1).Dimension), rand(obsInfo(1).Dimension)})

policy = getExplorationPolicy(agent)

trainOpts = rlTrainingOptions;

trainOpts.MaxEpisodes = 200;
trainOpts.MaxStepsPerEpisode = 500;
trainOpts.StopTrainingCriteria = "AverageReward";
trainOpts.StopTrainingValue = 495;
trainOpts.ScoreAveragingWindowLength = 20;

trainOpts.Verbose = false;
trainOpts.Plots = "training-progress";

trainingInfo = train(agent, pid_motor_env, trainOpts);

