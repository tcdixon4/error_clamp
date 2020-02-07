function [mu, sigma] = batch_sim(ec_mags, num_subjects)


%% simulate many subjects

num_clamps = length(ec_mags);
mu = cell(num_clamps,1);
sigma = cell(num_clamps,1);

for mag = num_clamps:-1:1
    
    data_matrix = zeros(num_subjects, 500);
    for subject = 1:num_subjects
        data_matrix(subject,:) = sim_quantal_model(ec_mags(mag));        
    end
    
    %% record mean and standard deviation
    mu{mag} = mean(data_matrix);
    sigma{mag} = std(data_matrix);
    
end


%% plot results

figure('Name','Quantal model EC predictions', 'Position',[100,100,900,500])
for mag = 1:num_clamps
    if mag==1
        color = 'k';
    elseif mag==2
        color = 'b';
    elseif mag==3
        color = 'r';
    elseif mag==4
        color = 'g';
    elseif mag==5
        color = 'm';
    else
    end
    shadedErrorBar(1:500, mu{mag}, sigma{mag}, ...
        'lineprops', {color, 'markerfacecolor', color});
    hold on
end

ylabel('Reach angle')
xlabel('Trial #')
xlim([0,100])
h = findobj(gca,'Type','line');
legend(h,{strcat(num2str(ec_mags(5)),char(176)),...
    strcat(num2str(ec_mags(4)),char(176)),...
    strcat(num2str(ec_mags(3)),char(176)),...
    strcat(num2str(ec_mags(2)),char(176)),...
    strcat(num2str(ec_mags(1)),char(176))});




