function intra_subject_ISC = get_intra_subject_ISC(roi_data)

[subj, rois, ts, sessions] = size(roi_data);

    for sub = 1:subj
        for roi = 1:rois
            session1 = squeeze(roi_data(sub,roi,:,1));
            session2 = squeeze(roi_data(sub,roi,:,2));
    
            isc = corr(session1,session2);
    
            intra_subject_ISC(sub,roi) = isc;
        end
    end
end




