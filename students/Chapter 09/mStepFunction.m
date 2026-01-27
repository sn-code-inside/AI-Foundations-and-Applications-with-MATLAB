
% Customer step function for motor system environment
% This function is used to help to build a customer function environment
% July 27, 2024

function [NextObs, Reward, IsDone, NextState] = mStepFunction(Action, State)
% Custom step function to construct motor environment for the function name case.
% This function applies the given action to the environment and evaluates the system dynamics for one simulation step.

% Max speed the input can apply
MaxSpeed = 50;
% Sample time
Ts = 0.02;
% Motor rotation angle at which to fail the episode - 2 degree
AngleThreshold = 2 * pi/180;
% Reward each time step as the motor is in normal rotating range
RewardNormalMotor = 1;
% Penalty when the motor fails to rotating in normal range
PenaltyErrorMotor = -1;

% Check if the given action is valid.
if (Action < -MaxSpeed) || (Action > MaxSpeed)
    error('Action must be %g for going left and %g for going right.', -MaxSpeed, MaxSpeed);
end

U_Voltage = Action;                 % Assign the Action to the output command U_Voltage
% Unpack the state vector from the logged signals.
Theta = State(1);
ThetaDot = State(2);

% Calculate output based on PD controller.
P = 80;
D = 120;
ThetaDotDot = U_Voltage + P*Theta + D*ThetaDot;

% Perform Euler integration to calculate next state.
NextState = State + Ts.*[ThetaDot; ThetaDotDot];

% Copy next state to next observation.
NextObs = NextState;

% Check terminal condition.
Theta = NextObs(1);
IsDone = abs(Theta) > AngleThreshold;

% Calculate reward.
if ~IsDone
    Reward = RewardNormalMotor;
else
    Reward = PenaltyErrorMotor;
end

end