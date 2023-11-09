function loo_spatial_ISC = get_loo_spatial_ISC(mean_timeseries)

[subj, rois, ts] = size(mean_timeseries);

    for sub = 1:subj
        others = setdiff(1:subj, sub);
    

        others_mean = squeeze(mean(mean(mean_timeseries(others, :, :), 1), 3));
        current_mean = squeeze(mean(mean_timeseries(sub, :, :), 3));

        %disp(size(others_mean));
        %disp(size(current_mean));

    
        loo_spatial_ISC(sub) = corr(current_mean', others_mean');
    end
end