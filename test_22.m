clear all;

ploting = false;

load 'data/8/Test_2.mat'
variableName = who;

n = 1;
m = 1;
for i = 1:size(variableName)
    
    name = variableName{i};
    
    if strcmp(name(1:2),"HZ")
        eval(['dataset = ',name,';']);
        
        freq = str2double(name(3:end));
        if(size(name,2) == 4)
            freq = freq / 10;    
        end
        freq_up(n) = freq;
        
        dataT1(n).T1up = dataset;
        
        t = dataT1(n).T1up(:,1);
        y = dataT1(n).T1up(:,2);
        up(n,:) = osc2wn(t,y,ploting);
        n = n + 1;
    end
    
    if strcmp(name(1:3),"IHZ")
        eval(['dataset = ',name,';']);
        
        freq = str2double(name(4:end));
        if(size(name,2) == 5)
            freq = freq / 10;    
        end
        freq_down(m) = freq;
        
        dataT1(m).T1down = dataset;
        
        t = dataT1(m).T1down(:,1);
        y = dataT1(m).T1down(:,2);
        down(m,:) = osc2wn(t,y,ploting);
        m = m + 1;
    end
end

for i = 1:size(up(:,1),1)
    diff_up(i) = up(i,1) - freq_up(i);
end

for i = 1:size(down(:,1),1)
    diff_down(i) = down(i,1) - freq_down(i);
end

Fdev = (std(abs(diff_down(3:end))) + std(abs(diff_up(3:end)))) / 2;
Favg = (mean(abs(diff_down(3:end))) + mean(abs(diff_up(3:end)))) / 2;

figure(1);
    plot(up(:,1),up(:,3));
    hold on;
    plot(down(:,1),down(:,3));
    hold off;
figure(2);
    plot(freq_up,up(:,3));
    hold on;
    plot(freq_down,down(:,3));
    hold off;
figure(3)
    subplot(1,2,1);
    plot(diff_up(3:end));
    subplot(1,2,2);
    plot(diff_down(3:end));