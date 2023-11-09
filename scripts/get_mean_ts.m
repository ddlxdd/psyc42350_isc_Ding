function mean_timeseries = get_mean_ts(roi_data)

[a,b,c,d] = size(roi_data);

for subj = 1:a;
        for roi = 1:b;

            ts = roi_data(subj, roi, :, :);
            
            mean_timeseries(subj, roi, :) = mean(ts, 4); 
        end
    end
end