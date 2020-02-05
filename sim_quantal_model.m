function [outputArg1,outputArg2] = sim_quantal_model(inputArg1,inputArg2)

% this stochastic model simulates the behavior on multiple iterations of
% visuomotor rotation adaptation. the same model can be used to predict
% normal visuomotor rotation or error clamp behavior. it is a two-layer
% nested model. the inner layer detects the presence of an error. it is
% formulated as a signal detection problem, with 
% p(error==1) = f(error magnitude)
% the outer layer determines whether the detected error should elicit an
% update in the sensorimotor map (adaptation), depending on the history of 
% effective or ineffective updating (ie if there have been repeated updates
% without any corresponding sensory consequences, there is no reason to
% continue adapting).

outputArg1 = inputArg1;
outputArg2 = inputArg2;
end

