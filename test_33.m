clear all;

printing = true;

dataT3 = struct;
load 'data/7/Test_1/Free responce attached.mat'
dataT3(1).Test1 = nirawdata;
figure(1)
plot(nirawdata(:,2));
load 'data/7/Test_1/Free responce not attached.mat'
dataT3(2).Test1 = nirawdata;
figure(1)
plot(nirawdata(:,2));

s1 = [700, 7640; 100, 13635;];
for i = 1:2
    
    figure(1);
    plot(dataT3(i).Test1(:,2));
    hold on;
    
    dataT3(i).Test1 = mfilter(dataT3(i).Test1,50,printing);

    figure(1);
    plot(dataT3(i).Test1(:,2));
    legend('filtered', 'unfiltered');
    hold off;
    
    t = dataT3(i).Test1(s1(i,1):s1(i,2),1);
    t = t - t(1);
    y = dataT3(i).Test1(s1(i,1):s1(i,2),2);

    data(i,:) = osc2psi(t,y,printing);
end

name = {"attached", "dettached"};
s2 = [5054, 18085; 4245, 19960;];

for i = 1:2
    
    str = 'data/7/Test_2/'+ name{i}+ '.csv';
    M = csvread(str,4,0);
    dataT3(i).Test2 = M;
    
    figure(1);
    plot(dataT3(i).Test2(:,2));
    hold on;
    
    dataT3(i).Test2 = mfilter(dataT3(i).Test2,50,printing);

    figure(1);
    plot(dataT3(i).Test2(:,2));
    hold off;
    
    t = dataT3(i).Test2(s2(i,1):s2(i,2),1);
    t = t - t(1);
    y = dataT3(i).Test2(s2(i,1):s2(i,2),2);

    data(i+2,:) = osc2psi(t,y,printing);
end

data