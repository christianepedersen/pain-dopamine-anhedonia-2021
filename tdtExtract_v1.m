     

%% Extract photometry data from TDT Data Tank

clear all;
close all;
clc

% step 1: go through and comment co de + appropriately title things


%%


% representative baseline fitting plots 
%sessID{3} = 'P063_PR1_presses.mat'; % n = 535
%sessID{4} = 'P063_PR2_presses.mat'; % n = 387


% point to tanks
path_to_data = 'C:\Users\ceped\Documents\MATLAB\Tami DA pain 2020';

% set up Tank name, variables to extract
tankdir = [path_to_data];
tankname = 'Noci_Operant-180409-164606'; % name of your tank

% pick save file name
filename = 'P472_PR5_test.mat';

blockname = 'p47-2pr5111920-201119-083604'; % name of your file   12-2 okay 11-1 great



storenames = {'470A'}; % name of stores to extract from TDT (usu. 4-letter code) 
%LMag is the demodulated data, may also have other timestamps etc

storenames2 = {'405A'};



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extract

for k = 1:numel(storenames)
  storename = storenames{k};
  S{k} = tdt2mat(tankdir, tankname, blockname, storename);
end

for k = 1:numel(storenames2)
  storename2 = storenames2{k};
  S2{k} = tdt2mat(tankdir, tankname, blockname, storename2);
end

%% Massage data and get time stamps

LMag = S{1}; %add more if you extracted more stores above
% LMag2 = S{2};
% For 2-color rig, LMag data is on channels 1 and 2, channel 1 = 470nm, channel 2 = 405nm
chani1 = LMag.channels==1;
chani2 = LMag.channels==2;

LMag2 = S2{1}; %add more if you extracted more stores above
% LMag2 = S{2};
% For 2-color rig, LMag data is on channels 1 and 2, channel 1 = 470nm, channel 2 = 405nm
chani21 = LMag2.channels==1;
chani22 = LMag2.channels==2;
% chani21 = LMag2.channels==1;
% chani22 = LMag2.channels==2;

% Get LMag data as a vector (repeat for each channel)
rawdat1 = LMag.data(chani1,:);
rawdat1 = reshape(rawdat1', [],1); % unwrap data from m x 256 array
% dat2 = LMag.data(chani21,:);
% dat2 = reshape(dat2', [],1); % unwrap data from m x 256 array

% Get LMag timestamps (use chani1 - timestamps should be the same for all Wpht channels
ts = LMag.timestamps(chani1);
t_rec_start = ts(1);

ts = ts-ts(1); % convert from Unix time to 'seconds from block start'
ts = bsxfun(@plus, ts(:), (0:LMag.npoints-1)*(1./LMag.sampling_rate));
ts = reshape(ts',[],1);

%%%%%%%%%%%%%%%%%%


dat2 = LMag2.data(chani21,:);
dat2 = reshape(dat2', [],1); % unwrap data from m x 256 array
% dat2 = LMag.data(chani21,:);
% dat2 = reshape(dat2', [],1); % unwrap data from m x 256 array

% Get LMag timestamps (use chani1 - timestamps should be the same for all Wpht channels
ts2 = LMag2.timestamps(chani21);
t_rec_start2 = ts2(1);

ts2 = ts2-ts2(1); % convert from Unix time to 'seconds from block start'
ts2 = bsxfun(@plus, ts2(:), (0:LMag2.npoints-1)*(1./LMag2.sampling_rate));
ts2 = reshape(ts2',[],1);


%% %%%%%%%%% plot figure%%%%%%%%%%%

% subtracted signal % raw final signal
rawdat1 = rawdat1(1:length(dat2));

subdat=rawdat1(1:length(dat2))-dat2;

ts = ts(1:length(subdat));

figure(2)
hold on
plot(ts,rawdat1,'b');
plot(ts2,dat2,'r');
title('both signals')
plot(ts,subdat,'g');
xlabel('time(s)')
ylabel('amplitude')
hold off

%print -painters -depsc 470and405.eps

Dts=ts;

%% Bandpass filter data 
Fs = round(1/(max(Dts)/length(Dts))); %sample frequency Hz

%% instead of HPF: fit 2nd order exponential and subtract

f2 = fit(Dts,subdat,'exp2');

fitcurve= f2(Dts);

datatemp1 = subdat - fitcurve;

dataFilt = datatemp1;

%%

normDat1 = (dataFilt - median(dataFilt))./abs(median(rawdat1)); %this gives deltaF/F
normDat = normDat1.*100; % get %

median(rawdat1)

data1 = normDat;

% 
%  data1 = normDat;

figure(6);
plot(Dts,subdat,Dts,fitcurve);
title('Subtracted signal')
xlabel('time(s)')
ylabel('raw F')


%print -painters -depsc curve_fit.eps

figure(7);
plot(Dts,data1);
title('Signal with corrected baseline')
xlabel('time(s)')
ylabel('deltaF/F')
%ylim([-20 20])

%print -painters -depsc corrected_deltaFoverF.eps

save(filename,'data1','Dts');
