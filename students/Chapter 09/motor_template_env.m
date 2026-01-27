classdef motor_template_env < rl.env.MATLABEnvironment
    %MOTOR_TEMPLATE_ENV: Template for defining custom environment in MATLAB.    
    
    %% Properties (set properties' attributes accordingly)
    properties
        % Specify and initialize environment's necessary properties    
        MaxSpeed = 50;
        % Sample time
        Ts = 0.02;
        % Motor rotation angle at which to fail the episode - 2 degree
        AngleThreshold = 2 * pi/180;
        % Reward each time step as the motor is in normal rotating range
        RewardNormalMotor = 1;
        % Penalty when the motor fails to rotating in normal range
        PenaltyErrorMotor = -1; 
    end
    
    properties
        % Initialize system state [theta, dtheta]'
        State = zeros(2, 1)
    end
    
    properties(Access = protected)
        % Initialize internal flag to indicate episode termination
        IsDone = false        
    end

    %% Necessary Methods
    methods              
        % Contructor method creates an instance of the environment
        % Change class name and constructor name accordingly
        function this = motor_template_env()
            % Initialize Observation settings
            ObservationInfo = rlNumericSpec([2 1]);
            ObsInfo.Name = "Motor States";
            ObsInfo.Description = 'theta, dtheta';
            
            % Initialize Action settings   
            ActInfo = rlFiniteSetSpec([-50 50]);
            ActInfo.Name = "Motor Action";
            
            % The following line implements built-in functions of RL env
            this = this@rl.env.MATLABEnvironment(ObservationInfo, ActInfo);
           
            % Initialize property values and pre-compute necessary values
            updateActionInfo(this);
        end
        
        % Apply system dynamics and simulates the environment with the given action for one step.
        function [NextObs, Reward, IsDone, NextState] = step(this, Action)
            
            % Get action
            U_Voltage = getVoltage(this, Action);            
            
            % Unpack state vector
            Theta = this.State(1);
            ThetaDot = this.State(2);
            
            % Calculate output based on PD controller.
            P = 80;
            D = 120;
            ThetaDotDot = U_Voltage + P*Theta + D*ThetaDot;

            % Perform Euler integration to calculate next state.
            NextState = this.State + this.Ts.*[ThetaDot; ThetaDotDot];
            % Copy next state to next observation.
             NextObs = NextState;

            % Check terminal condition.
            Theta = NextObs(1);
            IsDone = abs(Theta) > this.AngleThreshold ;
     
            % Get reward
            Reward = getReward(this);
            
            % (optional) use notifyEnvUpdated to signal that the environment has been updated (e.g. to update visualization)
            notifyEnvUpdated(this);
     
        end
        
        % Reset environment to initial state and output initial observation
        function InitialObservation = reset(this)
            % Theta (randomize)
            T0 = 2 * 0.05 * rand() - 0.05;
            % Thetadot
            Td0 = 0;

            % Return initial environment state variables as logged signals.
            InitialObservation = [T0; Td0];
            this.State = InitialObservation;
                   
            % (optional) use notifyEnvUpdated to signal that the 
            % environment has been updated (e.g. to update visualization)
            notifyEnvUpdated(this);
        end
    end
    %% Optional Methods (set methods' attributes accordingly)
    methods               
        % Helper methods to create the environment
        function U_Voltage = getVoltage(this, action)
            if ~ismember(action, this.ActionInfo.Elements)
                error('Action must be %g for going left and %g for going right.', -this.MaxSpeed, this.MaxSpeed);
            end
            U_Voltage = action;           
        end
        % update the action info based on max force
        function updateActionInfo(this)
            this.ActionInfo.Elements = this.MaxSpeed*[-1 1];
        end
        
        % Reward function
        function Reward = getReward(this)
            if ~this.IsDone
                Reward = this.RewardNormalMotor ;
            else
                Reward = this.PenaltyErrorMotor;
            end          
        end
        
        % (optional) Visualization method
        function plot(this)
            % Initiate the visualization
            
            % Update the visualization
            envUpdatedCallback(this)
        end
        
        % (optional) Properties validation through set methods
        function set.State(this, state)
            validateattributes(state,{'numeric'},{'finite', 'real','vector', 'numel', 2},'','State');
            this.State = double(state(:));
            notifyEnvUpdated(this);
        end
        
        function set.Ts(this, val)
            validateattributes(val,{'numeric'},{'finite','real','positive','scalar'},'','Ts');
            this.Ts = this.Ts;
        end
        function set.AngleThreshold(this,val)
            validateattributes(val,{'numeric'},{'finite','real','positive','scalar'},'','AngleThreshold');
            this.AngleThreshold = val;
        end
    end
    
    methods (Access = protected)
        % (optional) update visualization everytime the environment is updated 
        % (notifyEnvUpdated is called)
        function envUpdatedCallback(this)
        end
    end
end
