% MedAss Moron-Concepcion --> Bruchas Lab conversion

clear all
clc
close all


%% call in behavioral data
%dlmread('C2_M3_062917.txt'); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sessCode = 'P472_PR5_test';

% !!!!!!!!!!!!!
fileID1 = fopen([sessCode '.txt']);
photoname = [sessCode '.mat'];

% choose behavior state to align photom trace to
% 1 = right is active,   2 = left is active,    3 =  reward dispensed
chooseState = 2;

% P6-2 left lever is rewarded
% P6-3 left lever is rewarded
% P10-1 left lever is rewarded
% P11-1 right lever is rewarded
% P12-3 left lever is rewarded
% P16-2 left lever is rewarded
% P17-1 right lever is rewarded

% P20-1 right lever is rewarded
% P20-2 right lever is rewarded

% P48-2 left lever is rewarded

% P48-1 left lever is rewarded
% P47-2 left lever is rewarded

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% !!!!!!!!!!!!!

C1 = textscan(fileID1,'%s');
fclose(fileID1);

% Get rid of non numerical values and turn strings into doubles
raw1 = C1{1};
raw1(1:6:length(raw1)) = [];
rawMat1 = str2double(raw1);


%% Identify timestamp type

% NOTE: time stamps are non-cumulative
% need to check MedAss file to see if left or right lever is active
%1 X.100 right lever pressed
%2 X.600 left lever pressed
%3 0.200 reward dispensed
%4 0.500 left lever returns to active position after being pressed for reward
%5 0.300 session end

state = NaN(size(rawMat1));

% make sure decimals are precise

decimals = rawMat1-floor(rawMat1);
decimals = round(decimals.*10);

state(decimals==1) = 1;
state(decimals==6) = 2;
state(decimals==2) = 3;
state(decimals==5) = 4;
state(decimals==3) = 5;


rawMat1 = floor(rawMat1); % correct cumulative time error

% convert from centiseconds to seconds
rawMat1 = rawMat1./100;

timestamps = cumsum(rawMat1);


%% Photometry + Behavior Analysis

% Code by Christian Pedersen

%%

clearvars -except state chooseState timestamps photoname experDuration rawMat1 sessCode
close all
clc

%%

% C1 = dlmread('C159_M1_072517.txt');

% get photometry trace
Fs = 1017.25;


load(photoname)

experDuration = floor(max(Dts))-21; %seconds


%% demark index of lever press in each trial (pre reward)

pressIndex = zeros(size(state));

cntr = 1;

for kp = 1:length(pressIndex)
    
   if state(kp) == chooseState  
    
       pressIndex(kp) = cntr;
       
       cntr = cntr + 1;
       
   end
   
   if state(kp) == 3
      
       cntr = 1;
       
   end
   
end


%% specify event (states) for analysis

% NOTE: time stamps are non-cumulative
% need to check MedAss file to see if left or right lever is active
%1 X.100 right lever pressed
%2 X.600 left lever pressed
%3 0.200 reward dispensed
%4 0.500 left lever returns to active position after being pressed for reward
%5 0.300 session end


rewTimes = round(timestamps(state==chooseState));
pressIndex = pressIndex(state==chooseState);


pressIndex(rewTimes>experDuration) = [];
rewTimes(rewTimes>experDuration) = [];


%%

 



C1 = zeros(experDuration,1);
%C1(dropTimes) = 1;
C1(rewTimes) = 1;

startdelay = 20;
load(photoname)
max(Dts)

photom1 = data1(round(Fs*startdelay)+1:round(Fs*(experDuration+startdelay)));
time = linspace(1/Fs,experDuration,experDuration*Fs);

behavior = C1;
timeBehav = linspace(0,experDuration,length(behavior));
 
    % Z score photometry data
   %photom1 = (photom1-mean(photom1))./std(photom1);
   
   % photom1 = photom1.*-1;

for n =1
    
    figure(n+100)
    
    plot(timeBehav,behavior+10,'g',...
        decimate(time,1000),decimate(photom1,1000));
    
    ylabel('Z score                       Events per second')
    xlabel('Time (sec)')
    %yticks([-10 -5 0 5 10 15 20 25 30 35 40])
    %yticklabels({'-10','-5','0','5','0','5','10','15','20','25','30'})
    
    windtop = 20;
    % handle shading for 20 second rewards 
%     shadeindex = floor(Cgrouped{4,n});
%     for p = 1:length(shadeindex)
%         q = p - 1;
%         
%     x(1:4,p) = shadeindex(p)+[0 20 20 0];
%     y(1:4,p) = [windtop windtop -10 -10];
%     end
     axis([0 experDuration -5 windtop])
%     patch(x,y,'red','EdgeColor','none')
%     alpha(0.15)
%     
%     legend(strcat('ANP =  ', num2str(sum(Cbinned{2,n}))),strcat('INP =  ', num2str(sum(Cbinned{3,n}))),...
%     strcat('Rewards =  ', num2str(sum(Cbinned{4,n}))),strcat('Licks =  ', num2str(sum(Cbinned{5,n}))));
%    

end


%%

% n = 1;
% for p = 2:length(behavior)
% 
%     if behavior(p-1) == 0
%         if behavior(p) == 1
%         
%            licks1(n) = timeBehav(p);
%            n = n + 1; 
%            
%         end
%     end
%     
% end

licks1 = rewTimes;


  %licks1 = Cgrouped{eventnumb,1};
  
  timewindow = 20; % +/- seconds from event

%% Lick triggered averaging (of photom trace)

decifactor = 1;

photom1 = decimate(photom1,decifactor);
time = decimate(time,decifactor);
% 
Fs = 1017.25/decifactor;


samplewindow = round(timewindow*Fs); % samples per time period


pressIndex = pressIndex(licks1<(experDuration-timewindow));
licks2 = licks1(licks1<(experDuration-timewindow));

pressIndex = pressIndex(licks2>timewindow);
licks = licks2(licks2>timewindow);


LickTrig = zeros(length(licks),2*samplewindow);

% Change lick times to random times for a control
%licks = max(licks).*rand(length(licks),1);

for p = 1:length(licks)
    
    trigindex = zeros(1,length(photom1));
    
    [~,startidx] = min(abs(time-(licks(p)-timewindow)));
    trigindex(startidx:(startidx+size(LickTrig,2)-1)) = 1;
    
    LickTrig(p,:) = photom1(trigindex==1);
    
end

photoPerLick = mean(LickTrig,1);
%

sem = std(LickTrig,0,1)./sqrt(size(LickTrig,1)); % sem = std/sqrt(n)

% event triggered average
figure(15)

hold on
%eb1 = errorbar(linspace(-timewindow,timewindow,length(photoPerLick)),photoPerLick,sem,'Color',[0.2,0.2,0.5]);
x = decimate(linspace(-timewindow,timewindow,length(photoPerLick)),300);
y = decimate(photoPerLick,300);
eb = decimate(sem,300);
mseb(x,y,eb,[],1);
%plot(linspace(-timewindow,timewindow,length(photoPerLick)),photoPerLick,'b')%,linspace(-timewindow,timewindow,length(photoPerLick)),LickTrig,'y')
%legend('SEM','Mean')
%L = line([0 0],[-4 4]);
xlim([-timewindow timewindow])
%set(L,'Color','black')
xlabel('Time aligned to reward (s)')
ylabel('deltaF/F')
hold off

%% heat map (x dim: time, ydim: event, zdim: deltaF/F)
figure(16)

hold on
imagesc(linspace(-timewindow,timewindow,length(photoPerLick)),1:size(LickTrig,1),LickTrig)
L = line([0 0],[0 length(licks)+1]);
set(L,'Color','black')
xlabel('Time aligned to reward (s)')
ylabel('Bout Number')
cb = colorbar;
title(cb,'Z score')
%caxis([-3 3])
%colormap(autumn)
xlim([-timewindow timewindow])
ylim([0 length(licks)+1])
hold off

%%

photom10hz = resample(photom1,1,floor(length(photom1)/length(behavior)));

photom10hz = photom10hz(1:length(timeBehav));

% photom10hz = photom10hz(1500:end);
% behavior = behavior(1500:end);

% % Standard deviation
% photom10hz = (photom10hz-mean(photom10hz))./std(photom10hz);

baseAVG = mean(photom10hz(behavior~=1)); 
eatAVG = mean(photom10hz(behavior==1));

baseSEM = std(photom10hz(behavior~=1))/sqrt(length(photom10hz(behavior~=1)));
eatSEM = std(photom10hz(behavior==1))/sqrt(length(photom10hz(behavior==1)));

[~,p] = ttest2(photom10hz(behavior~=1),photom10hz(behavior==1));

figure(17)
hold on
bar([0 1],[baseAVG eatAVG])
errorbar([0 1],[baseAVG eatAVG],[baseSEM eatSEM],'.')
ylabel('Z score')
specs = {'control','treatment'};
xlim([-0.5 1.5])
set(gca,'xtick',[0 1],'xticklabel',specs)
title(['p = ' num2str(p)])
hold off

%%

% save reward-locked data
%save([sessCode '_rewards.mat'],'LickTrig')

% save active pressing data
%save([sessCode '_presses.mat'],'LickTrig','pressIndex')


























