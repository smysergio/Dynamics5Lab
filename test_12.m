clear all;

ploting = false;

down_name = {"5.2", "5.3", "5.4", "5.5", "5.6", "5.7", "5.8", "5.9", "6.0", "6.1", "6.2", "6.3", "6.4", "6.5", "6.6"};
up_name = {"5", "5.1", "5.2", "5.3", "5.4", "5.5", "5.6", "5.7", "5.8", "5.9", "6.0", "6.1", "6.2", "6.3", "6.4", "6.5", "6.6", "6.7"};

freq_up = str2double(up_name);
freq_down = str2double(down_name);

for i = 1:size(up_name,2)
    
    load("Data/7/Test_1/increasing "+up_name{i}+"Hz.mat");
    dataT2(i).T1up = nirawdata;
    
    t = dataT2(i).T1up(:,1);
    y = dataT2(i).T1up(:,2);
    up(i,:) = osc2wn(t,y,ploting);
end

for i = 1:size(down_name,2)
    
    load("Data/7/Test_1/decreasing "+down_name{i}+"Hz.mat");
    dataT2(i).T1down = nirawdata;
    
    t = dataT2(i).T1down(:,1);
    y = dataT2(i).T1down(:,2);
    down(i,:) = osc2wn(t,y,ploting);
end

for i = 1:size(up(:,1),1)
    diff_up(i) = up(i,1) - freq_up(i);
end

for i = 1:size(down(:,1),1)
    diff_down(i) = down(i,1) - freq_down(i);
end
figure(4)
subplot(1,2,1);
plot(diff_up);
subplot(1,2,2);
plot(diff_down);

Fdev = (std(abs(diff_down)) + std(abs(diff_up))) / 2;
Favg = (mean(abs(diff_down)) + mean(abs(diff_up))) / 2;

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
legend("sweep up", "sweep down");
xlabel('forcing frequency (Hz)') % x-axis label
ylabel('response amplitude (V)') % y-axis label
title('Frequency Response of oscillation')