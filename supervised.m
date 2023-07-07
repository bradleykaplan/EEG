%clear all;
%supervised learning testing
sesh2 = readmatrix("");%insert CSV names here
sesh3 = readmatrix("");
sesh4 = readmatrix("");
sesh5 = readmatrix("");
sesh2_2 = readmatrix("");
sesh3_2 = readmatrix("");
sesh4_2 = readmatrix("");
sesh5_2 = readmatrix("");
sesh2_3 = readmatrix("");
sesh3_3 = readmatrix("");
sesh4_3 = readmatrix("");
sesh5_3 = readmatrix("");
currentvar = sesh4;
psize = floor(size(currentvar, 1)/4);%get partition size for later checks
buffersize = 50;
categorylocation = size(currentvar, 2) + 1;

currentvar(1:buffersize, categorylocation) = nan;
currentvar(buffersize+1:psize-buffersize, categorylocation) = -1;
currentvar(psize-buffersize+1:psize+buffersize, categorylocation) = nan;
currentvar(psize+buffersize+1:2*psize-buffersize, categorylocation) = 1;%1
currentvar(2*psize-buffersize+1:2*psize+buffersize, categorylocation) = nan;
currentvar(2*psize+buffersize+1:3*psize-buffersize, categorylocation) = -1;%-1
currentvar(3*psize-buffersize+1:3*psize+buffersize, categorylocation) = nan;
currentvar(3*psize+buffersize+1:4*psize-buffersize, categorylocation) = 1;%1
currentvar(4*psize-buffersize+1:size(currentvar, 1), categorylocation) = nan;

bmodel = fitcensemble(currentvar(:,1:20), currentvar(:,21));
sesh2predict = predict(bmodel, sesh2);
sesh3predict = predict(bmodel, sesh3);
sesh4predict = predict(bmodel, sesh4);
sesh5predict = predict(bmodel, sesh5);
sesh2predict_2 = predict(bmodel, sesh2_2);
sesh3predict_2 = predict(bmodel, sesh3_2);
sesh4predict_2 = predict(bmodel, sesh4_2);
sesh5predict_2 = predict(bmodel, sesh5_2);
sesh2predict_3 = predict(bmodel, sesh2_3);
sesh3predict_3 = predict(bmodel, sesh3_3);
sesh4predict_3 = predict(bmodel, sesh4_3);
sesh5predict_3 = predict(bmodel, sesh5_3);

%plot(sesh2predict,"+") %use this syntax to plot predictions