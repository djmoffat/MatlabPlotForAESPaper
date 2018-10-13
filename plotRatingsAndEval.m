clc;
clearvars -except 'T';

pd = makedist('Binomial')
mkdir('fig')

fontSize = 14;

diary('writeDiary.txt')
%% Attack
disp('Attack')
FS_ = strcmp(T.attackA,'F') & strcmp(T.attackB,'S');
SF_ = strcmp(T.attackA,'S') & strcmp(T.attackB,'F');
attackValue = [(T.pref(FS_)); ~(T.pref(SF_))];
[h,p] = chi2gof(attackValue,'CDF',pd);

if(h)
    starDict{1} = [1,2];
    starP(1) = p;
end

%% Release
disp('Release')
FS_ = strcmp(T.releaseA,'F') & strcmp(T.releaseB,'S');
SF_ = strcmp(T.releaseA,'S') & strcmp(T.releaseB,'F');
releaseValue = [(T.pref(FS_)); ~(T.pref(SF_))];
[h,p] = chi2gof(releaseValue,'CDF',pd);
if(h)
    starDict{2} = [3,4];
    starP(2) = p;
end
%% Graph
% c = categorical({'Attack Fast','Attack Slow','Release Fast','Release Slow'});
valueTable = [mean(attackValue), 1-mean(attackValue),mean(releaseValue), 1-mean(releaseValue)];
figure; 

bar(valueTable);

if ~isempty(starP)
   SH = sigstar(starDict,starP);
   set(SH(:,1),'LineWidth',2)
   set(SH(:,2),'FontSize',fontSize)
end
% xticklabels({'Attack Fast','Attack Slow','','Release Fast','Release Slow'})
xticklabels({'Fast','Slow','Fast','Slow'})
depth = get(gca, 'YLim') - 0.07;
label = {'Attack','Release'};
for i = 1:2
    xpos = ((i-1)*2) + 1.5;
    text('Units', 'Data', 'Position', [xpos, depth], 'HorizontalAlignment', 'center', 'String', label{i},'FontSize',fontSize,'FontName','LaTeX','Interpreter','LaTeX');
end
yticks([0:0.1:1])
yticklabels([0:10:100])
ylabel('Percentage Preference Rating', 'Interpreter','latex')
title('All Styles')

ax = gca;
ax.FontName = 'LaTeX';
ax.Title.Interpreter = 'LaTeX';
ax.XLabel.Interpreter = 'LaTeX';
ax.YLabel.Interpreter = 'LaTeX';
ax.TickLabelInterpreter = 'LaTeX';

set(gca,'defaulttextinterpreter','latex')
% set(gca,'TickLabelInterpreter', 'latex');
% % set(gca,'TickLabelFontSize',fontSize);
set(gca,'FontSize',fontSize)

saveas(gcf, 'fig/AllStyles','jpeg')
saveas(gcf, 'fig/AllStyles','fig')
print('fig/AllStyles', '-dpng','-r300');


%% Attack and Release per style
styleList = unique(T.style);
d.VT = [];
d.AT = [];
d.RT = [];
d.starDict = {};
d.starP = [];
for ii = 1:size(styleList,1)
    ii
    curStyle = styleList{ii};
    d.(curStyle).starDict = {};
    d.(curStyle).starP = [];
    
    T_ = T(strcmp(styleList{ii},T.style),:);
    disp([styleList{ii} ' Attack'])
    FS_ = strcmp(T_.attackA,'F') & strcmp(T_.attackB,'S');
    SF_ = strcmp(T_.attackA,'S') & strcmp(T_.attackB,'F');
    d.(curStyle).attackValue = [(T_.pref(FS_)); ~(T_.pref(SF_))];
    [d.(curStyle).h,d.(curStyle).p] = chi2gof(d.(curStyle).attackValue,'CDF',pd);
    if(d.(curStyle).h)
        d.(curStyle).starDict{1} = [1,2];
        d.(curStyle).starP(1) = d.(curStyle).p;
        d.starDict(numel(d.starDict)+1) = {[1:2]+numel(d.VT)};
        d.starP(numel(d.starP)+1) = d.(curStyle).p;
    end
    
    disp([styleList{ii} ' Release'])
    FS_ = strcmp(T_.releaseA,'F') & strcmp(T_.releaseB,'S');
    SF_ = strcmp(T_.releaseA,'S') & strcmp(T_.releaseB,'F');
    d.(curStyle).releaseValue = [((T_.pref(FS_))); ~(T_.pref(SF_))];
    [d.(curStyle).h,d.(curStyle).p] = chi2gof(d.(curStyle).releaseValue,'CDF',pd);
    if(d.(curStyle).h)
        d.(curStyle).starDict{2} = [3,4];
        d.(curStyle).starP(2) = d.(curStyle).p;
        d.starDict(numel(d.starDict)+1) = {[3:4]+numel(d.VT)};
        d.starP(numel(d.starP)+1) = d.(curStyle).p;
    end
    
    % Graph
    d.(curStyle).valueTable = [mean(d.(curStyle).attackValue), 1-mean(d.(curStyle).attackValue) ,mean(d.(curStyle).releaseValue), 1-mean(d.(curStyle).releaseValue)];
    d.VT = [d.VT,d.(curStyle).valueTable];
    d.AT = [d.AT,mean(d.(curStyle).attackValue), 1-mean(d.(curStyle).attackValue)];
    d.RT = [d.RT,mean(d.(curStyle).releaseValue), 1-mean(d.(curStyle).releaseValue)];
    
    figure;
    bar(d.(curStyle).valueTable);
    if ~isempty(d.(curStyle).starP)
       SH = sigstar(d.(curStyle).starDict,d.(curStyle).starP);
       for ii_ = 1:size(SH,1)
           set(SH(ii_,1),'LineWidth',2)
           set(SH(ii_,2),'FontSize',fontSize)
       end
    end
    xticklabels({'Attack Fast','Attack Slow','Release Fast','Release Slow'})
    yticks([0:0.1:1])
    yticklabels([0:10:100])
    ylabel('Percentage Preference Rating', 'Interpreter','latex')
    title([styleList{ii} ' Style'], 'FontSize',fontSize)
    ax = gca;
    ax.FontName = 'LaTeX';
    ax.Title.Interpreter = 'LaTeX';
    ax.XLabel.Interpreter = 'LaTeX';
    ax.YLabel.Interpreter = 'LaTeX';
    ax.TickLabelInterpreter = 'LaTeX';

    set(gca,'defaulttextinterpreter','latex')
    set(gca,'TickLabelInterpreter', 'latex');
    set(gca,'FontSize',fontSize)
    saveas(gcf, ['fig/' styleList{ii} ' Style'],'jpeg')
    saveas(gcf, ['fig/' styleList{ii} ' Style'],'fig')
    print(['fig/' styleList{ii} ' Style'], '-dpng','-r300');
end

%%
   
figure; 
% set(0,'defaulttextinterpreter','latex')
% set(gca,'FontSize',fontSize)
colormap(gray);

grouping = zeros(size(d.VT,2),1);
grouping(1:2:end) = 1;

b = bar(d.VT);
b.FaceColor = 'flat';
groupList = 2:2:size(d.VT,2);
b.CData(groupList,:) = repmat([0.2,0,1],size(groupList,2),1);

if ~isempty(d.starP)
   SH = sigstar(d.starDict,d.starP);
   for ii = 1:size(SH,1)
       set(SH(ii,1),'LineWidth',2)
       set(SH(ii,2),'FontSize',fontSize)
   end
end

xticklabels({})
yticks([0:0.1:1])
yticklabels([0:10:100])


depth = get(gca, 'YLim')-0.02;
FSLab = {'Fast','Slow'};

for ii = 1:16
    text('Units', 'Data', 'Position', [ii, depth], 'HorizontalAlignment', 'center', 'String', FSLab{mod(ii-1,2)+1}, 'FontSize',fontSize,'FontName','LaTeX','Interpreter','LaTeX');
end

depth = get(gca, 'YLim') - 0.06;
ARLab = {'Attack','Release'};

for ii = 1:8
    xpos = ((ii-1)*2) + 1.5;
    text('Units', 'Data', 'Position', [xpos, depth], 'HorizontalAlignment', 'center', 'String', ARLab{mod(ii-1,2)+1}, 'FontSize',fontSize,'FontName','LaTeX','Interpreter','LaTeX');
end

depth = get(gca, 'YLim') - 0.1;
for ii = 1:4
    xpos = ((ii-1)*4) + 2.5;
    text('Units', 'Data', 'Position', [xpos, depth], 'HorizontalAlignment', 'center', 'String', styleList{ii}, 'FontWeight','bold','FontSize',fontSize+4,'FontName','LaTeX','Interpreter','LaTeX');
end
title('All Styles', 'Interpreter','latex')
ylabel('Percentage Preference Rating', 'Interpreter','latex')

set(gca,'defaulttextinterpreter','tex')
% set(gca,'TickLabelInterpreter', 'latex');
set(gca,'FontSize',fontSize)

ax = gca;
ax.FontName = 'LaTeX';
ax.Title.Interpreter = 'LaTeX';
ax.XLabel.Interpreter = 'LaTeX';
ax.YLabel.Interpreter = 'LaTeX';
ax.TickLabelInterpreter = 'LaTeX';
% set(gcf,'Position',[0.1300 0.1100 1 0.8150]);
% ax.Position(1) = ax.Position(1) * 0.6;
ax_ = gcf;
% ax.Position(1) = ax.Position(1) * 0.6;
ax_.Position(3) = ax_.Position(3) * 1.6;
% ax.OuterPosition(3) = ax.OuterPosition(3) * 1.6;
% ax.InnerPosition(3) = ax.InnerPosition(3) * 1.6;
    
saveas(gcf, 'fig/AllStyles-Independant','jpeg')
saveas(gcf, 'fig/AllStyles-Independant','fig')
print('fig/AllStyles-Independant', '-dpng','-r300');

diary off
%%
close all