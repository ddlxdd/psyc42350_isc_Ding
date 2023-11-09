function loo_temporal_ISC = get_loo_ISC(mean_timeseries)

[subj, rois, ts] = size(mean_timeseries);

  for i = 1:rois
        for j = 1:subj
            others = setdiff(1:subj, j);

            mean_all = squeeze(mean(mean_timeseries(others, i, :), 1));

            target_ts = squeeze(mean_timeseries(j, i, :));

            loo_isc = corr(target_ts, mean_all);

            loo_temporal_ISC(j, i) = loo_isc;
        end
  end
end