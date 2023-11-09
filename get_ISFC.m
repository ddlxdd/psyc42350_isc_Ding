function ISFC = get_ISFC(mean_timeseries)

[subj, rois, ts] = size(mean_timeseries);

    for sub = 1:subj
        all_other = setdiff(1:subj, sub);
    
        all_other_mean = squeeze(mean(mean_timeseries(all_other, :, :), 1));
    
        for sub_roi = 1:rois
            for other_roi = 1:rois
                sub_ts = squeeze(mean_timeseries(sub, sub_roi, :));
                other_ts = all_other_mean(other_roi,:);
    
                isc = corr(sub_ts, other_ts');
                ISFC(sub, sub_roi, other_roi) = isc;
            end
        end
    end
end