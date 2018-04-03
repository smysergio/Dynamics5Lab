function data = osc2wn(t,y,plot_flag)
    if(size(t,1)>size(t,2))
        N = size(t,1);
    else
        N = size(t,2);
    end
    Ts = t(N)/N;
    Fs = 1/Ts;

    %take the Fast Fourier Transform of audio.
    XF = fft(y);

    %Spectrum: only need the magnitude & +eve freq (0 -> N/2)
    Fspec(:,1) = linspace(0,Fs/2, N/2);
    Fspec(:,2) = abs( XF(1:length(XF)/2) );

    val = [ 0, 0; 0, 0; ]; % [freq,amplitude]
    for i = 1:(N/2)
        x = Fspec(i,:);
        if(x(2) > val(2,2))
            val(1,:) = val(2,:);
            val(2,:) = x;

        elseif(x(2) > val(1,2))
            val(1,:) = x;
        end
    end
    
    % Compare to see if there is more than one significant peak.
    if(  (val(1,2)>val(2,2)*0.8) && ( (val(1,1)-val(2,1) > 1) )  )
        "error"
        val
    end
    
    
    [pks,locs,w,p] = findpeaks(y,Fs,'MinPeakDistance',0.1);
    
    amp = 0;
    n = 0;
    for i = 1:size(pks)
        if(pks(i)>0)
            amp = amp + pks(i);
            n = n + 1;
            %t1 = locs(i);
            %width(n) = t1-t0;
            %t0 = t1;
        end
    end
    
    amp = amp/n;
    data = val(2,:);
    data(3) = amp;
       
    if (plot_flag)
        figure(11)
            plot(Fspec(:,1),Fspec(:,2))
            axis([-1 100 0 inf])
        figure(12)
            plot(t,y)
            axis([-inf inf -inf inf])
            hold on;
            plot(locs,pks,'o')
            hold off;
    end
end

