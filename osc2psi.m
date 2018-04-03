function data = osc2psi(t,y,plot_flag)
    Ts = t(2)-t(1);
    Fs = 1/Ts;
    
    results1 = osc2wn(t,y,plot_flag);
    Fd = results1(1);
    [pks,locs] = findpeaks(y,Fs,'MinPeakDistance',(1/Fd)*0.75);

    peaks = 0;
    n  = 1;
    for i = 1:size(pks,1)
        if(pks(i)>0)
            peaks(n,1) = pks(i);
            peaks(n,2) = locs(i);
            n = n + 1;
        end
    end
    
    for i = 2:size(peaks,1)
        dpks(i) = log(peaks(i-1)/peaks(i));
        dwidth(i) = locs(i) - locs(i-1);
        
        chpks(i) = dpks(i)-dpks(i-1);
        chwidth(i) = dwidth(i)-dwidth(i-1);
    end

    dpks_ave = mean(dpks);
    dwidth_ave = mean(dwidth);
    
    chpks_ave = mean(abs(chpks));
    chwidth_ave = mean(abs(chwidth));
    
    psi = 1  /  sqrt( 1 + ( (2*pi)/dpks_ave )^2 );
    
    wd = (2*pi)/dwidth_ave;
    wn = wd/sqrt(1-psi^2);
    wd_fft = (2*pi)*results1(1);
    
    Tdev = std(dwidth);
    Tmax = max(dwidth);
    
    %data = [ psi, wd, wd_fft, wn, Tdev, Tmax, chpks_ave, chwidth_ave];
    data = [ psi, wn, Tdev];
    
    if(plot_flag)
        figure(21)
            plot(t,y);
            hold on;
            plot(locs,pks,'o')
            hold off;
        figure(22)
            plot(dwidth);
            hold on;
            %plot(dpks);
            %hold off;
        figure(23)
            plot(chwidth);
            hold on;
            plot(chpks);
            hold off;
    end
end

