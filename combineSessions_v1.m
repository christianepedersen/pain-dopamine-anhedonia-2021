% code by Christian Pedersen
% Michael Bruchas Lab

clear all
close all
clc

%%

% press stacks
sessID{1} = 'P062_PR1_presses.mat'; % n = 149
sessID{2} = 'P062_PR2_presses.mat'; % n = 54
sessID{3} = 'P063_PR1_presses.mat'; % n = 535
sessID{4} = 'P063_PR2_presses.mat'; % n = 387

sessID{5} = 'P101_PR1_presses.mat'; % n = 480
sessID{6} = 'P101_PR2_presses.mat'; % n = 57
sessID{7} = 'P101_PR3_presses.mat'; % n = 49
sessID{8} = 'P111_PR1_presses.mat'; % n = 268
sessID{9} = 'P111_PR2_presses.mat'; % n = 81
sessID{10} = 'P111_PR3_presses.mat'; % n = 31

%%%%% Did not demotivate %%%%%
sessID{11} = 'P122_PR1_presses.mat'; % n = 542
sessID{12} = 'P122_PR2_presses.mat'; % n = 599
sessID{13} = 'P123_PR1_presses.mat'; % n = 755
sessID{14} = 'P123_PR2_presses.mat'; % n = 565
sessID{15} = 'P151_PR1_presses.mat'; % n = 658
sessID{16} = 'P151_PR2_presses.mat'; % n = 869

sessID{17} = 'P162_PR1_presses.mat'; % n = 427
sessID{18} = 'P162_PR2_presses.mat'; % n = 303
sessID{19} = 'P171_PR1_presses.mat'; % n = 232
sessID{20} = 'P171_PR2_presses.mat'; % n = 65
sessID{21} = 'P192_PR1_presses.mat'; % n = 364
sessID{22} = 'P192_PR2_presses.mat'; % n = 99

% saline control
sessID{23} = 'P201_PR1_test_presses.mat'; % n = 525
sessID{24} = 'P201_PR2_test_presses.mat'; % n = 443
sessID{25} = 'P202_PR1_test_presses.mat'; % n = 403
sessID{26} = 'P202_PR2_test_presses.mat'; % n = 587
sessID{27} = 'P482_PR1_test_presses.mat'; % n = 1256
sessID{28} = 'P482_PR2_test_presses.mat'; % n = 866

% cfa week out
sessID{29} = 'P201_PR3_test_presses.mat'; % n = 692
sessID{30} = 'P201_PR5_test_presses.mat'; % n = 313
sessID{31} = 'P202_PR3_test_presses.mat'; % n = 518
sessID{32} = 'P202_PR5_test_presses.mat'; % n = 90

% saline control
sessID{33} = 'P472_PR1_test_presses.mat'; % n =
sessID{34} = 'P472_PR2_test_presses.mat'; % n =
sessID{35} = 'P481_PR1_test_presses.mat'; % n =
sessID{36} = 'P481_PR2_test_presses.mat'; % n =

% cfa week out
sessID{37} = 'P472_PR3_test_presses.mat'; % n =
sessID{38} = 'P472_PR5_test_presses.mat'; % n =



%% reward stacks

sessID{101} = 'P062_PR1_rewards.mat'; % n = 12
sessID{102} = 'P062_PR2_rewards.mat'; % n = 7
sessID{103} = 'P063_PR1_rewards.mat'; % n = 18
sessID{104} = 'P063_PR2_rewards.mat'; % n = 15

sessID{105} = 'P101_PR1_rewards.mat'; % n = 14
sessID{106} = 'P101_PR2_rewards.mat'; % n = 6
sessID{107} = 'P101_PR3_rewards.mat'; % n = 6
sessID{108} = 'P111_PR1_rewards.mat'; % n = 15
sessID{109} = 'P111_PR2_rewards.mat'; % n = 10
sessID{110} = 'P111_PR3_rewards.mat'; % n = 6

%%%%% Did not demotivate %%%%%
sessID{111} = 'P122_PR1_rewards.mat'; % n = 16
sessID{112} = 'P122_PR2_rewards.mat'; % n = 16
sessID{113} = 'P123_PR1_rewards.mat'; % n = 18
sessID{114} = 'P123_PR2_rewards.mat'; % n = 16
sessID{115} = 'P151_PR1_rewards.mat'; % n = 19
sessID{116} = 'P151_PR2_rewards.mat'; % n = 21

sessID{117} = 'P162_PR1_rewards.mat'; % n = 15
sessID{118} = 'P162_PR2_rewards.mat'; % n = 13
sessID{119} = 'P171_PR1_rewards.mat'; % n = 13
sessID{120} = 'P171_PR2_rewards.mat'; % n = 7
sessID{121} = 'P192_PR1_rewards.mat'; % n = 13
sessID{122} = 'P192_PR2_rewards.mat'; % n = 8

% saline control
sessID{123} = 'P201_PR1_test_rewards.mat'; % n = 14
sessID{124} = 'P201_PR2_test_rewards.mat'; % n = 13
sessID{125} = 'P202_PR1_test_rewards.mat'; % n = 13
sessID{126} = 'P202_PR2_test_rewards.mat'; % n = 15
sessID{127} = 'P482_PR1_test_rewards.mat'; % n = 18
sessID{128} = 'P482_PR2_test_rewards.mat'; % n = 16

% cfa week out
sessID{129} = 'P201_PR3_test_rewards.mat'; % n = 15
sessID{130} = 'P201_PR5_test_rewards.mat'; % n = 12
sessID{131} = 'P202_PR3_test_rewards.mat'; % n = 14
sessID{132} = 'P202_PR5_test_rewards.mat'; % n = 7

% saline control
sessID{133} = 'P472_PR1_test_rewards.mat'; % n =
sessID{134} = 'P472_PR2_test_rewards.mat'; % n =
sessID{135} = 'P481_PR1_test_rewards.mat'; % n =
sessID{136} = 'P481_PR2_test_rewards.mat'; % n =

% cfa week out
sessID{137} = 'P472_PR3_test_rewards.mat'; % n =
sessID{138} = 'P472_PR5_test_rewards.mat'; % n =



%% combine event stacks

combMat = [];
combFlag = [];
sessMark = [];
 
% CFA
% PR1 = [1 3 5 8 13 17 19]
% PR2 = [2 4 6 9 14 18 20]

% Saline 48 hr
% PR1 = [23,25,27,33,35]
% PR2 = [24,26,28,34,36]   %higher peri-Reward

% week after cfa
% PR3 = [5,8,29,31,37]
% PR5 = [7,10,30,32,38]    % same peri-Reward
 
sessMark = [];
% rep heatmaps: saline = 25,26    weekCFA = 37,38

for p = 38

load(sessID{p})

% if analyzing all pokes or all presses
tempMat = LickTrig;

%combFlag = cat(1,combFlag,pressIndex);

numbEvents = size(tempMat,1)

combMat = cat(1,combMat,tempMat);
%sessMark = cat(1,sessMark,(p-22)*ones(size(tempMat,1),1));

%sessMark = cat(1,sessMark,repmat(p-100,size(tempMat,1),1));

end


%%

timewindow = 20;

photoPerLick = mean(combMat,1);
%

sem = std(combMat,0,1)./sqrt(size(combMat,1)); % sem = std/sqrt(n)

% event triggered average
figure(15)

hold on
%eb1 = errorbar(linspace(-timewindow,timewindow,length(photoPerLick)),photoPerLick,sem,'Color',[0.2,0.2,0.5]);
x = decimate(linspace(-timewindow,timewindow,length(photoPerLick)),300);
y = decimate(photoPerLick,300);
eb = decimate(sem,300);
lineProps.col{1} = 'b';
mseb(x,y,eb,lineProps,1);
%plot(linspace(-timewindow,timewindow,length(photoPerLick)),photoPerLick,'b')%,linspace(-timewindow,timewindow,length(photoPerLick)),combMat,'y')
%legend('SEM','Mean')
%L = line([0 0],[-4 4]);
xlim([-timewindow timewindow])
%set(L,'Color','black')
xlabel('Time aligned to press (s)')
ylabel('deltaF/F')
axis([-20 20 -3 3])
hold off

%print -painters -depsc PR1_presses_saline.eps

%% heat map (x dim: time, ydim: event, zdim: deltaF/F)

% resample to 5 Hz effectively
resampFactor = 200;

for nk = 1:size(combMat,1)
    
    temp33 = combMat(nk,:);
    smolMat(nk,:) = resample(temp33,1,resampFactor);
    
end


%[~,idx33] = sort(mean(smolMat(:,25:100),2),'ascend');
%smolMat = smolMat(idx33,:);

figure(p+1000)

hold on
imagesc(linspace(-timewindow,timewindow,size(smolMat,2)),1:size(smolMat,1),smolMat)
L = line([0 0],[0 size(smolMat,1)+1]);
set(L,'Color','black')
xlabel('Time aligned to press (s)')
ylabel('Bout Number')
cb = colorbar;
title(cb,'deltaF/F')
caxis([-10 10])
%colormap(autumn)
%colormap(flipud(brewermap([],'YlGnBu')))
colormap(flipud(brewermap([],'RdBu')))
%brewermap_view
xlim([-10 2])
%xlim([-timewindow timewindow])
ylim([0 size(combMat,1)+1])
hold off

%print(gcf,'foo.png','-dpng','-r300'); 

%print -painters -depsc press_heatmap_cfa_1week.eps


 %% Event counting

 % set true for peak counting analysis
if false
 
% load every data1 file

% 2019 cfa treated animals
seriesID{1} = 'P062_PR1.mat'; % n = 149
seriesID{2} = 'P062_PR2.mat'; % n = 54
seriesID{3} = 'P063_PR1.mat'; % n = 535
seriesID{4} = 'P063_PR2.mat'; % n = 387
seriesID{5} = 'P101_PR1.mat'; % n = 480
seriesID{6} = 'P101_PR2.mat'; % n = 57
seriesID{7} = 'P101_PR3.mat'; % n = 49
seriesID{8} = 'P111_PR1.mat'; % n = 268
seriesID{9} = 'P111_PR2.mat'; % n = 81
seriesID{10} = 'P111_PR3.mat'; % n = 31
seriesID{11} = 'P123_PR1.mat'; % n = 
seriesID{12} = 'P123_PR2.mat'; % n = 
seriesID{13} = 'P162_PR1.mat'; % n = 
seriesID{14} = 'P162_PR2.mat'; % n = 
seriesID{15} = 'P171_PR1.mat'; % n = 
seriesID{16} = 'P171_PR2.mat'; % n = 

% 2020 saline controls
seriesID{17} = 'P201_PR1_test.mat'; % n = 
seriesID{18} = 'P201_PR2_test.mat'; % n = 
seriesID{19} = 'P202_PR1_test.mat'; % n = 
seriesID{20} = 'P202_PR2_test.mat'; % n = 
seriesID{21} = 'P482_PR1_test.mat'; % n =
seriesID{22} = 'P482_PR2_test.mat'; % n =

% cfa 1 week out
seriesID{23} = 'P201_PR3_test.mat'; % n =
seriesID{24} = 'P201_PR5_test.mat'; % n =
seriesID{25} = 'P202_PR3_test.mat'; % n =
seriesID{26} = 'P202_PR5_test.mat'; % n =

% saline controls
seriesID{27} = 'P472_PR1_test.mat'; % n =
seriesID{28} = 'P472_PR2_test.mat'; % n =
seriesID{29} = 'P481_PR1_test.mat'; % n =
seriesID{30} = 'P481_PR2_test.mat'; % n =

% cfa 1 week out
seriesID{31} = 'P472_PR3_test.mat'; % n =
seriesID{32} = 'P472_PR5_test.mat'; % n =




%% FIND PEAKS

for n =  1:32 % 1:length(wholeSess)
    
load(seriesID{n})

wholeSess{n} = data1;

clear data1

[pks,locs,w,p] = findpeaks(wholeSess{n});

locs(w<150) = [];
pks(w<150) = [];
p(w<150) = []; 

locs(p<1.2) = [];
pks(p<1.2) = [];

sessDur = length(wholeSess{n})./1017.25;

cntPeaks(n) = length(pks)/120; %/sessDur*60;

   if n == 6
       figure(69)
       plot(Dts,wholeSess{n},'b' ...
        ,locs./1017.25,pks,'or')
       xlabel('Time (s)')
       ylabel('deltaF/F')
       xlim([5175 5230])
       ylim([-10 10])
       %print -painters -depsc pain_peakz.eps
       
   end

end


diffPeaks = cntPeaks([1 3 5 8 11 13 15 17 19 21 23 25 27 29 31])...
           -cntPeaks([2 4 6 9 12 14 16 18 20 22 24 26 28 30 32]);

figure(68)
plot(linspace(0,7200,length(wholeSess{5})),wholeSess{5}+100,'b',...
     linspace(0,7200,length(wholeSess{6})),wholeSess{6}+50,'r',...
     linspace(0,7200,length(wholeSess{7})),wholeSess{7},'k')
xlabel('Time (s)')
ylabel('deltaF/F')

%print -painters -depsc rep_traces.eps

%% 17:30 (not 23:26)

%SALINE 

figure()
plot(linspace(0,7200,length(wholeSess{19})),wholeSess{19}+100,'b',...
     linspace(0,7200,length(wholeSess{20})),wholeSess{20}+50,'r')
xlabel('Time (s)')
ylabel('deltaF/F')

%print -painters -depsc rep_traces_saline.eps

%%

categor = [0 1 0 1 0 1 2 0 1 2 0 1 0 1 0 1 0 1 0 1 0 1 0 2 0 2 0 1 0 1 0 2];

avg0 = mean(cntPeaks(categor==0));
avg1 = mean(cntPeaks(categor==1));
avg2 = mean(cntPeaks(categor==2));

figure(70)
hold on
%bar([0 1 2],[avg0 avg1 avg2])
plot(categor,cntPeaks,'ok')
xlim([-1 3])
plot(categor(1:2),cntPeaks(1:2),categor(3:4),cntPeaks(3:4),...
    categor(5:7),cntPeaks(5:7),categor(8:10),cntPeaks(8:10),...
    categor(11:12),cntPeaks(11:12),categor(13:14),cntPeaks(13:14),...
    categor(15:16),cntPeaks(15:16),categor(17:18),cntPeaks(17:18),...
    categor(19:20),cntPeaks(19:20),categor(21:22),cntPeaks(21:22),...
    categor(23:24),cntPeaks(23:24),categor(25:26),cntPeaks(25:26),...
    categor(27:28),cntPeaks(27:28),categor(29:30),cntPeaks(29:30),...
    categor(31:32),cntPeaks(31:32))
catz = {'Baseline','Pain','Recovery'};
set(gca,'XTick',0:2,'XTickLabel',catz)
ylabel('Events per minute')
hold off


%print -painters -depsc cntPeaks_new_animals.eps


end












