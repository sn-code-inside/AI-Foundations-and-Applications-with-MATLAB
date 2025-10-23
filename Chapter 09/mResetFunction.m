
% Customer reset() function definition
% This function is used to help to build a customer function environment
% July 27, 2024

function [InitialObservation, InitialState] = mResetFunction()
% Reset function to place custom motor environment into a random initial state.

% Theta (randomize)
T0 = 2 * 0.05 * rand() - 0.05;
% Thetadot
Td0 = 0;

% Return initial environment state variables as logged signals.
InitialState = [T0; Td0];
InitialObservation = InitialState;

end