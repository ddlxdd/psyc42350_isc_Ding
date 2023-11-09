
% Creating toy datasets roi_data and behavior

number_subjects = 20;   
number_rois = 5;       
number_timepoints = 50;  
number_sessions = 2;

rng(42)

roi_data = rand(number_subjects, number_rois, number_timepoints, number_sessions);

% I don't want to have 0s in my toy data
epsilon = 1e-6;
roi_data(roi_data < epsilon) = epsilon;

size(roi_data);

rng(42)
behavior = rand(1,number_subjects);
size(behavior);

% get the mean time series

mean_timeseries = get_mean_ts(roi_data);
size(mean_timeseries);

mean_timeseries(2, :)';

% Pairwise Temp ISC
pai_t_ISC = get_pairwise_isc(mean_timeseries);
% Save to .mat file
save('pairwise_ISC.mat', 'pai_t_ISC');

% LOO ISC
loo_temporal_ISC = get_loo_ISC(mean_timeseries);
% Save to .mat file
save('LOOV_Temporal_ISC.mat', 'loo_temporal_ISC');

% LOO Dynamic ISC
loo_dynamic_ISC = get_loo_dynamic_ISC(mean_timeseries, 10, 10);
% Save to .mat file
save('LOOV_Dynamic_ISC.mat', 'loo_dynamic_ISC');


% LOO Spatial ISC
loo_spatial_ISC = get_loo_spatial_ISC(mean_timeseries);
% Save to .mat file
save('LOOV_Spatial_ISC.mat', 'loo_spatial_ISC');

% intra subject ISC
intra_subj_ISC = get_intra_subject_ISC(roi_data);
% Save to .mat file
save('Intra_Subject_ISC.mat', 'intra_subj_ISC');

%ISFC
ISFC = get_ISFC(mean_timeseries);
% Save to .mat file
save('ISFC.mat', 'ISFC');



% behavior similarity

max_diff = max(behavior) - min(behavior);

for i = 1:number_subjects
    for j = 1:number_subjects
        behavioral_similarity(i, j) = 1 - (abs(behavior(i) - behavior(j)) / max_diff);

        if behavioral_similarity(i, j) == 0
            behavioral_similarity(i, j) = epsilon;
        end
    end
end

%disp(size(behavioral_similarity));

for roi = 1:5
  isc = triu(pai_t_ISC(:,:,roi), 1);
  behavior_vector = triu(behavioral_similarity, 1);

 

  disp(isc);
  
  isc_vector = isc(isc ~= 0);
  behavior_vector = behavior_vector(behavior_vector ~= 0);
  
  disp(size(behavior_vector));
  disp(size(isc_vector));
  %disp(isc_vector);
  %disp(behavior_vector);

  ISC_behavior(roi) = corr(isc_vector, behavior_vector);
  

end

disp(ISC_behavior);

% In this code, I caculate the correlation between temproal ISC score and
% the related subject behavior similarity score. My hypothesis for this
% test is to explore whether high similarity in humans behavior also
% indicate highly similar neural activations. The output for this test is
% ISC_behavior = [0.0751 0.1765 0.0268 -0.0765 -0.0642], I got two postive
% value for ROI1 and ROI2 suggest that there are some postive relationship
% in these two ROIs, but all the correlation value I got is pretty low,
% which shows the connection between these two similarities is week.



