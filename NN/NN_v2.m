
[inputall,outputall] = load_data_V3();

% Solve a Pattern Recognition Problem with a Neural Network
% Script generated by NPRTOOL
%
% This script assumes these variables are defined:
%
%   cancerInputs - input data.
%   cancerTargets - target data.

%convert the row to colmun
inputs = inputall';
targets = outputall';

% Create a Pattern Recognition Network
hiddenLayerSize = 10;
%trainFcn = 'trainbr';
trainFcn = 'trainlm';
net = patternnet(hiddenLayerSize,trainFcn);
%net = feedforwardnet(hiddenLayerSize,trainFcn);

% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio =15/100;
net.divideParam.testRatio = 15/100;
% net.layers{1}.transferFcn = 'logsig';
% net.layers{2}.transferFcn = 'elliotsig';

% for i=1:net.numLayers
%   if strcmp(net.layers{i}.transferFcn,'tansig')
%     net.layers{i}.transferFcn = 'elliotsig';
%   end
% end

% Train the Network
[net,tr] = train(net,inputs,targets,'useParallel','yes','showResources','yes');

% Test the Network
outputs = net(inputs,'useParallel','yes','showResources','yes');
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);

% trInput = inputs(:,tr.trainInd);
% trOut = net(trInput);
% trTarget = targets(:,tr.trainInd);
% figure, plotconfusion(trgTarget,trOut);
% 
% tsInput = inputs(:,tr.testInd);
% tsOut = net(tsInput);
% tsTarget = targets(:,tr.testInd);
% 
% figure, plotconfusion(tsTarget,tsOut);
trOut = outputs(:,tr.trainInd);
vOut = outputs(:,tr.valInd);
tsOut = outputs(:,tr.testInd);
trTarg = targets(:,tr.trainInd);
vTarg = targets(:,tr.valInd);
tsTarg = targets(:,tr.testInd);
figure, plotconfusion(trTarg,trOut);
figure, plotconfusion(tsTarg,tsOut);
TsT = vec2ind(tsTarg);
TsO = vec2ind(tsOut);
% View the Network
%view(net)
 mat = confusionmat(TsT,TsO);
 accuracy = mean(diag(mat));
 xlswrite('zzh_CF_trainlm.xls',mat);
 save zzh_CF_trainlm.mat
% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure,title('all'),  plotconfusion(targets,outputs);
 
 t = vec2ind(targets);
 o = vec2ind(outputs);

 %figure;
% confusion_matrix(t,o);
% figure, ploterrhist(errors)