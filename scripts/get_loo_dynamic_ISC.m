function loo_dynamic_ISC = get_loo_dynamic_ISC(mean_timeseries, windows, step)

[subj, rois, ts] = size(mean_timeseries);

number_windows = floor((ts - windows) / step);
total_windows = number_windows + 1;


  for i = 1:rois
        for j = 1:total_windows
            start = (j - 1) * step + 1;
            stop = start + windows - 1;

            for sub = 1:subj
                current_ts = squeeze(mean_timeseries(sub, i, start:stop));

                others = setdiff(sub:subj, sub);
                mean_all = squeeze(mean(mean_timeseries(others, i, start:stop), 1));

                loo_isc = corr(current_ts, mean_all);
                
                loo_dynamic_ISC(sub, i, j) = loo_isc;
            end
        end
  end


  first_isc = squeeze(loo_dynamic_ISC(1, 1, :));
  start_w = (0:total_windows - 1) * step + 1;

  figure;
  plot(start_w,  first_isc);
  xlabel('Time');
  ylabel('ISC');
  title('Dynamic ISC(Subject=1, ROI=1)');

  saveas(gcf, 'E:/Psych423/lab6/dynamic_ISC_subject1_ROI1.pdf');
end


