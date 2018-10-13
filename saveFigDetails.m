function saveFigDetails(saveTitle)



fontSize = 16;
folderName = 'figDescriptors2';
if ~exist(folderName, 'dir')
    mkdir(folderName);
end

% Defaults for this blog post
width = 3;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 11;      % Fontsize
lw = 1.5;      % LineWidth
msz = 8;       % MarkerSize

ax = gca;
set(ax,'defaulttextinterpreter','latex')
set(ax,'FontSize',fontSize)
ax.TickLabelInterpreter ='LaTeX';
ax.FontName = 'LaTeX';
ax.Title.Interpreter = 'LaTeX';
ax.XLabel.Interpreter = 'LaTeX';
ax.YLabel.Interpreter = 'LaTeX';

title(saveTitle); 

saveTitle_ = saveTitle(~isspace(saveTitle));


% set(ax,'TickLabelInterpreter', 'latex');
fname = [folderName, '/' saveTitle_];
saveas(gcf,fname ,'jpeg')
print(fname, '-dpng', '-r300'); %<-Save as PNG with 300 DPI
saveas(gcf, fname,'epsc')
saveas(gcf, fname,'fig')