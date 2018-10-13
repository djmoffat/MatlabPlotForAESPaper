clear; clc;
readDescriptors;

% mkdir('fig')

% diary('descriptorStats.txt')
%%
s1 = categorical(T.descriptor(strcmp(T.style,'EDM')));
s2 = categorical(T.descriptor(strcmp(T.style,'HipHop')));
s3 = categorical(T.descriptor(strcmp(T.style,'Jazz')));
s4 = categorical(T.descriptor(strcmp(T.style,'Rock')));


yl = 'Times Descriptor was Selected';
t_ = ' Style, All Compressor Settings';

fileName = ['EDM',t_];
figure; histogram(s1); ylabel(yl);
saveFigDetails(fileName)

fileName = ['HipHop',t_];
figure; histogram(s2); ylabel(yl)
saveFigDetails(fileName)

fileName = ['Jazz',t_];
figure; histogram(s3); title(fileName); ylabel(yl)
saveFigDetails(fileName)

fileName = ['Rock',t_];
figure; histogram(s4); title(fileName); ylabel(yl)
saveFigDetails(fileName)



%% Single Timing
attackFast = categorical(T.descriptor(strcmp(T.attack,'F')));
attackSlow = categorical(T.descriptor(strcmp(T.attack,'S')));
releaseFast = categorical(T.descriptor(strcmp(T.release,'F')));
releaseSlow = categorical(T.descriptor(strcmp(T.release,'S')));

t_ = ' All Styles';


figure;
fileName = ['Fast Attack',t_];
histogram(attackFast); title(fileName); ylabel(yl);
saveFigDetails(fileName)

figure;
fileName = ['Slow Attack',t_];
histogram(attackSlow); title(fileName);ylabel(yl);
saveFigDetails(fileName)

figure;
fileName = ['Fast Release',t_];
histogram(releaseFast); title(fileName);ylabel(yl);
saveFigDetails(fileName)

figure;
fileName = ['Slow Release',t_];
histogram(releaseSlow); title(fileName);ylabel(yl);
saveFigDetails(fileName)


%% STATS

[tbl,chi2,p,labels] = crosstab(T.attack, T.descriptor)
[tbl,chi2,p,labels] = crosstab(T.release, T.descriptor)

%%
[tbl,chi2,p,labels] = crosstab(T.style, T.descriptor)
% [h,p,stats] = fishertest(tbl)



%% Multiple Timing
FF = categorical(T.descriptor(strcmp(T.attack,'F') & strcmp(T.release,'F')));
FS = categorical(T.descriptor(strcmp(T.attack,'F') & strcmp(T.release,'S')));
SF = categorical(T.descriptor(strcmp(T.attack,'S') & strcmp(T.release,'F')));
SS = categorical(T.descriptor(strcmp(T.attack,'S') & strcmp(T.release,'S')));
figure;
fileName = ['Fast Attack, Fast Release',t_];
histogram(FF); ylabel(yl);
saveFigDetails(fileName)

figure;
fileName = ['Fast Attack, Slow Release',t_];
histogram(FS); title(fileName);ylabel(yl);
saveFigDetails(fileName)

figure;
fileName = ['Slow Attack, Fast Release',t_];
histogram(SF); title(fileName);ylabel(yl);
saveFigDetails(fileName)

figure;
fileName = ['Slow Attack, Slow Release',t_];
histogram(SS); title(fileName);ylabel(yl);
saveFigDetails(fileName)


%% Per Style
T_ = T;
styleList = unique(T.style);
for ii = 1:size(styleList,1)
    curStyle = styleList{ii};
    T = T_(strcmp(styleList{ii},T_.style),:);
    
    attackFast = categorical(T.descriptor(strcmp(T.attack,'F')));
    attackSlow = categorical(T.descriptor(strcmp(T.attack,'S')));
    releaseFast = categorical(T.descriptor(strcmp(T.release,'F')));
    releaseSlow = categorical(T.descriptor(strcmp(T.release,'S')));

    figure;
    fileName = [curStyle ' Fast Attack'];
    histogram(attackFast); title(fileName);ylabel(yl);
    saveFigDetails(fileName)
    
    figure;
    fileName = [curStyle ' Slow Attack'];
    histogram(attackSlow); title(fileName);ylabel(yl);
    saveFigDetails(fileName)
    
    figure;
    fileName = [curStyle ' Fast Release'];
    histogram(releaseFast); title(fileName);ylabel(yl);
    saveFigDetails(fileName)
    
    figure;
    fileName = [curStyle ' Fast Release'];
    histogram(releaseSlow); title(fileName);ylabel(yl);
    saveFigDetails(fileName)

    FF = categorical(T.descriptor(strcmp(T.attack,'F') & strcmp(T.release,'F')));
    FS = categorical(T.descriptor(strcmp(T.attack,'F') & strcmp(T.release,'S')));
    SF = categorical(T.descriptor(strcmp(T.attack,'S') & strcmp(T.release,'F')));
    SS = categorical(T.descriptor(strcmp(T.attack,'S') & strcmp(T.release,'S')));
    figure;
    fileName = [curStyle ' Fast Attack, Fast Release'];
    histogram(FF); title(fileName);ylabel(yl);
    saveFigDetails(fileName)

    figure;
    fileName = [curStyle ' Fast Attack, Slow Release'];
    histogram(FS); title(fileName);ylabel(yl);
    saveFigDetails(fileName)
    
    figure;
    fileName = [curStyle ' Slow Attack, Fast Release'];
    histogram(SF); title(fileName);ylabel(yl);
    saveFigDetails(fileName)
    
    figure;
    fileName = [curStyle ' Slow Attack, Slow Release'];
    histogram(SS); title(fileName);ylabel(yl);
    saveFigDetails(fileName)
end
T = T_;

%% Stats per style

styleList = unique(T.style);
for ii = 1:size(styleList,1)
    curStyle = styleList{ii};
    T_ = T(strcmp(styleList{ii},T.style),:);
    disp(curStyle)
    [tbl,chi2,attackp] = crosstab(T_.attack, T_.descriptor)
    [tbl,chi2,releasep] = crosstab(T_.release, T_.descriptor)

    %%
%     [tbl,chi2,p] = crosstab(T_.style, T_.descriptor)
end

diary off
