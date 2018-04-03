function fout = mfilter(fin,fcut,plot_flag)
    Ts = fin(2,1)-fin(1,1);
    Fs = 1/Ts;
    N =  size(fin,1);
    
    XF = fft(fin(:,2));
    F = linspace(0,Fs,N);   %F = (0: Fs/(N-1) : Fs)
    
    if(plot_flag)
        figure(31)
        plot(F,abs(XF));
        hold on;
    end
    
    fI = round( (fcut/Fs)*(N+1) )+1;           % Index of frequency
    fend = N-1-fI;
    XF( fI : fend ) = 0;          % +eve freq filtering 
    if(plot_flag) 
        plot(F,abs(XF));
        hold off;
    end
    fout(:,2) = real(ifft(XF));
    fout(:,1) = fin(:,1);
end

