function pairwise_temporal_ISC = get_pairwise_isc(mean_timeseries)
    [subj, rois, ts] = size(mean_timeseries);

   for roi = 1:rois
        for i = 1:subj
            for j = i+1:subj
                 disp(size(mean_timeseries(i, :)));
                 disp(size(mean_timeseries(j, :)));
                 
    
                ts1 = mean_timeseries(i, roi, :);
                ts2 = mean_timeseries(j, roi, :);

                ts1_vector = squeeze(ts1);
                ts2_vector = squeeze(ts2);


                disp(size(ts1));
                disp(size(ts1));
                
        
                isc = corr(ts1_vector,ts2_vector)

    
                pairwise_temporal_ISC(i, j, roi) = isc;
                pairwise_temporal_ISC(j, i, roi) = isc;

            end
        end
   end
end
