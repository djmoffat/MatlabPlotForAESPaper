%% readRatings

ratingsFL = listFilesInDir('../data/comments/','csv');

cellSize = 147;
participant = cell(cellSize,1);
style = cell(cellSize,1);
attack = cell(cellSize,1);
release = cell(cellSize,1);
trackName = cell(cellSize,1);
descriptor = cell(cellSize,1);
cellCount = 1;

for i = 1:length(ratingsFL)
    curFile = ratingsFL(i);
    readFilePath = [curFile.folder, '/' ,curFile.name];
    M = readtable(readFilePath);
    for ii = 1:size(M,1)
        A = split(M.trackName(ii),'-');
        participant(cellCount) = M.save_id(ii);
        style(cellCount) = A(1);
        attack(cellCount) = {A{2}(1)};
        release(cellCount) = {A{2}(2)};
        descriptor(cellCount)= M.value(ii);
        trackName(cellCount)= M.trackName(ii);
        cellCount = cellCount+1;
    end
end

T = table(participant, style, attack, release, descriptor, trackName);

clearvars -except 'T'

