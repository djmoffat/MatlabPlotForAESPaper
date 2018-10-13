clear; clc;
readDescriptors;

% mkdir('fig')

diary('descriptorStats.txt')
%%
s1 = categorical(T.descriptor(strcmp(T.style,'EDM')));
s2 = categorical(T.descriptor(strcmp(T.style,'HipHop')));
s3 = categorical(T.descriptor(strcmp(T.style,'Jazz')));
s4 = categorical(T.descriptor(strcmp(T.style,'Rock')));

figure;
histogram(s1); title('EDM');
figure;
histogram(s2); title('HipHop');
figure;
histogram(s3); title('Jazz');
figure;
histogram(s4); title('Rock');



%% Single Timing
attackFast = categorical(T.descriptor(strcmp(T.attack,'F')));
attackSlow = categorical(T.descriptor(strcmp(T.attack,'S')));
releaseFast = categorical(T.descriptor(strcmp(T.release,'F')));
releaseSlow = categorical(T.descriptor(strcmp(T.release,'S')));

figure;
histogram(attackFast); title('Fast Attack');
figure;
histogram(attackSlow); title('Slow Attack');
figure;
histogram(releaseFast); title('Fast Release');
figure;
histogram(releaseSlow); title('Fast Release');


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
histogram(FF); title('Fast Fast');
figure;
histogram(FS); title('Fast Slow');
figure;
histogram(SF); title('Slow Fast');
figure;
histogram(SS); title('Slow Slow');


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
    histogram(attackFast); title([curStyle ' Fast Attack']);
    figure;
    histogram(attackSlow); title([curStyle ' Slow Attack']);
    figure;
    histogram(releaseFast); title([curStyle ' Fast Release']);
    figure;
    histogram(releaseSlow); title([curStyle ' Fast Release']);

    FF = categorical(T.descriptor(strcmp(T.attack,'F') & strcmp(T.release,'F')));
    FS = categorical(T.descriptor(strcmp(T.attack,'F') & strcmp(T.release,'S')));
    SF = categorical(T.descriptor(strcmp(T.attack,'S') & strcmp(T.release,'F')));
    SS = categorical(T.descriptor(strcmp(T.attack,'S') & strcmp(T.release,'S')));
    figure;
    histogram(FF); title([curStyle ' Fast Fast']);
    figure;
    histogram(FS); title([curStyle ' Fast Slow']);
    figure;
    histogram(SF); title([curStyle ' Slow Fast']);
    figure;
    histogram(SS); title([curStyle ' Slow Slow']);
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

% %% Release
% % disp('Release')
% FS_ = strcmp(T.releaseA,'F') & strcmp(T.releaseB,'S');
% SF_ = strcmp(T.releaseA,'S') & strcmp(T.releaseB,'F');
% releaseValue = [cell2mat(T.pref(FS_)); ~cell2mat(T.pref(SF_))];
% [h,p] = chi2gof(releaseValue,'CDF',pd);
% if(h)
%     starDict{2} = [3,4];
%     starP(2) = p;
% end
% %% Graph
% % c = categorical({'Attack Fast','Attack Slow','Release Fast','Release Slow'});
% valueTable = [mean(attackValue), 1-mean(attackValue),mean(releaseValue), 1-mean(releaseValue)];
% figure; 
% 
% bar(valueTable);
% 
% if ~isempty(starP)
%    sigstar(starDict,starP);
% end
% % xticklabels({'Attack Fast','Attack Slow','','Release Fast','Release Slow'})
% xticklabels({'Fast','Slow','Fast','Slow'})
% depth = get(gca, 'YLim') - 0.07;
% label = {'Attack','Release'};
% for i = 1:2
%     xpos = ((i-1)*2) + 1.5;
%     text('Units', 'Data', 'Position', [xpos, depth], 'HorizontalAlignment', 'center', 'String', label{i});
% end
% title('All Styles')
% 
% saveas(gcf, 'fig/AllStyles','epsc')
% saveas(gcf, 'fig/AllStyles','fig')
% 
% %% Attack and Release per style
% styleList = unique(T.style);
% d.VT = [];
% d.AT = [];
% d.RT = [];
% d.starDict = {};
% d.starP = [];
% for ii = 1:size(styleList,1)
%     curStyle = styleList{ii};
%     d.(curStyle).starDict = {};
%     d.(curStyle).starP = [];
%     
%     T_ = T(strcmp(styleList{ii},T.style),:);
% %     disp([styleList{ii} ' Attack'])
%     FS_ = strcmp(T_.attackA,'F') & strcmp(T_.attackB,'S');
%     SF_ = strcmp(T_.attackA,'S') & strcmp(T_.attackB,'F');
%     d.(curStyle).attackValue = [cell2mat(T_.pref(FS_)); ~cell2mat(T_.pref(SF_))];
%     [d.(curStyle).h,d.(curStyle).p] = chi2gof(d.(curStyle).attackValue,'CDF',pd);
%     if(d.(curStyle).h)
%         d.(curStyle).starDict{1} = [1,2];
%         d.(curStyle).starP(1) = d.(curStyle).p;
%         d.starDict(numel(d.starDict)+1) = {[1:2]+numel(d.VT)};
%         d.starP(numel(d.starP)+1) = d.(curStyle).p;
%     end
%     
% %     disp([styleList{ii} ' Release'])
%     FS_ = strcmp(T_.releaseA,'F') & strcmp(T_.releaseB,'S');
%     SF_ = strcmp(T_.releaseA,'S') & strcmp(T_.releaseB,'F');
%     d.(curStyle).releaseValue = [cell2mat(T_.pref(FS_)); ~cell2mat(T_.pref(SF_))];
%     [d.(curStyle).h,d.(curStyle).p] = chi2gof(d.(curStyle).releaseValue,'CDF',pd);
%     if(d.(curStyle).h)
%         d.(curStyle).starDict{2} = [3,4];
%         d.(curStyle).starP(2) = d.(curStyle).p;
%         d.starDict(numel(d.starDict)+1) = {[3:4]+numel(d.VT)};
%         d.starP(numel(d.starP)+1) = d.(curStyle).p;
%     end
%     
%     % Graph
%     d.(curStyle).valueTable = [mean(d.(curStyle).attackValue), 1-mean(d.(curStyle).attackValue) ,mean(d.(curStyle).releaseValue), 1-mean(d.(curStyle).releaseValue)];
%     d.VT = [d.VT,d.(curStyle).valueTable];
%     d.AT = [d.AT,mean(d.(curStyle).attackValue), 1-mean(d.(curStyle).attackValue)];
%     d.RT = [d.RT,mean(d.(curStyle).releaseValue), 1-mean(d.(curStyle).releaseValue)];
%     
%     figure;
%     bar(d.(curStyle).valueTable);
%     if ~isempty(d.(curStyle).starP)
%        sigstar(d.(curStyle).starDict,d.(curStyle).starP);
%     end
%     xticklabels({'Attack Fast','Attack Slow','Release Fast','Release Slow'})
%     title([styleList{ii} ' Style'])
%     saveas(gcf, ['fig/' styleList{ii} ' Style'],'epsc')
%     saveas(gcf, ['fig/' styleList{ii} ' Style'],'fig')
% end
% 
% %%
%    
% figure; 
% bar(d.VT);
% if ~isempty(d.starP)
%    SH = sigstar(d.starDict,d.starP);
% end
% 
% xticklabels({})
% 
% depth = get(gca, 'YLim')-0.02;
% FSLab = {'Fast','Slow'};
% 
% for ii = 1:16
%     text('Units', 'Data', 'Position', [ii, depth], 'HorizontalAlignment', 'center', 'String', FSLab{mod(ii-1,2)+1});
% end
% 
% depth = get(gca, 'YLim') - 0.06;
% ARLab = {'Attack','Release'};
% 
% for ii = 1:8
%     xpos = ((ii-1)*2) + 1.5;
%     text('Units', 'Data', 'Position', [xpos, depth], 'HorizontalAlignment', 'center', 'String', ARLab{mod(ii-1,2)+1});
% end
% 
% depth = get(gca, 'YLim') - 0.1;
% for ii = 1:4
%     xpos = ((ii-1)*4) + 2.5;
%     text('Units', 'Data', 'Position', [xpos, depth], 'HorizontalAlignment', 'center', 'String', styleList{ii});
% end
% title('All Styles')
% 
% saveas(gcf, 'fig/AllStyles-Independant','epsc')
% saveas(gcf, 'fig/AllStyles-Independant','fig')
% 
% % 