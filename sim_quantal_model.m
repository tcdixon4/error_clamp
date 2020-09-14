function [reach_angle_vec, belief_vec, is_error_vec, is_update_vec] = ...
    sim_quantal_model(ec_mag)

% this stochastic model simulates the behavior on a single session of
% visuomotor rotation adaptation. the same model can be used to predict
% normal visuomotor rotation or error clamp behavior. it is a two-layer
% nested model. the inner layer detects the presence of an error. it is
% formulated as a signal detection problem, with 
% p(error==1) = f(error magnitude)
% the outer layer determines whether the detected error should elicit an
% update in the sensorimotor map (adaptation), depending on the history of 
% effective or ineffective updating (ie if there have been repeated updates
% without any corresponding sensory consequences, there is no reason to
% continue adapting). the outer layer may be defined as stochastic or
% deterministic, graded or binary - more thought must be put in to make a
% theoretically based decision on this feature. for now, we will make it
% also stochastic

%% error clamp modelling

% runtime settable variables
quantum = 1;

mu_detect = 5;
sigma_detect = 1.5;
mu_attend = 0.75;
sigma_attend = 0.05;

% define probability of error detection, which is constant in error clamp
p_detect = normcdf(ec_mag, mu_detect, sigma_detect);
H = ones(20,1);

% set up time series vectors for the stochastic processes and the resulting
% reach angles on each trial
error_detect_vec = zeros(500,1);
error_attend_vec = zeros(500,1);
reach_angle_vec = zeros(500,1);
belief_vec = zeros(500,1);
is_error_vec = zeros(500,1);
is_update_vec = zeros(500,1);


% iterate over all reaches to simulate a single time series
% this may be vectorized in the future, but the for-loop makes the process
% more interpretable anyway
for trial = 1:499
    
    belief_vec(trial) = mean(H);
    
    % determine whether an error was detected on the current trial
    is_error = rand() < p_detect;
    
    % if there was an error detected, determine whether an update will be
    % made
    if is_error
        is_update = rand() < mean(H);
    else
        is_update = 0;
    end
    is_error_vec(trial) = is_error;
    
    % if there was an update, change the behavior on the next trial and
    % add to the history that there was an ineffective update
    if is_update
        reach_angle_vec(trial+1) = reach_angle_vec(trial) + quantum;
        H = circshift(H,1);
        H(1) = 0;
    else
        reach_angle_vec(trial+1) = reach_angle_vec(trial);
    end
    is_update_vec(trial) = is_update;
    
end
% 
% %% plot
% title_text = {strcat('\mu =', num2str(mu_attend)), ...
%     strcat('\sigma =', num2str(sigma_attend))};
% plot(reach_angle_vec(1:500))
% ylabel('Error')
% xlabel('Trial #')
% title('Linear, max 20')

end

