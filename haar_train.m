%% m-script for trainging Haar detector

clc
clear
close all

load('Training_Dataset\Task_2_Training_Dataset.mat');
DatasetStruct = Task_2_Training_Data;

DatasetTable = table({DatasetStruct(:).Image}', {DatasetStruct(:).BoundingBox}', 'VariableNames', ["imageFilename", "sign"]);
DatasetTable.imageFilename = fullfile(strcat(pwd, "\Training_Dataset"), DatasetTable.imageFilename);

imds = imageDatastore(DatasetTable.imageFilename);
blds = boxLabelDatastore(DatasetTable(:, 2:end));
positiveInstances = combine(imds, blds);

negativeImages = imageDatastore(...); % insert name of the dir with negative instnces

%%
trainCascadeObjectDetector('signHaarDetector.xml', ...
                           positiveInstances, ...
                           negativeImages, ...
                           ObjectTrainingSize=[64,64], ...
                           NegativeSamplesFactor=2, ...
                           FalseAlarmRate=0.01, ...
                           NumCascadeStages=4, ...
                           FeatureType='HOG');
