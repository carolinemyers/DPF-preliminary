%% Hello 
%Written by Caroline Myers (contact: cfm304@nyu.edu) 
%Carrasco Lab
%July 19th, 2019. 
%Version history: D3

%This script was written to import, prune, sort, and plot DPF_exo
%experimental data. The experimental design consisted of a 2-AFC task during which
%participants were asked to discriminate the orientation of a post-cued
%stimulus, presented at one of four cardinal isoeccentric locations (UVM,
%Temporal, LVM, Nasal) while maintaining fixation. Attention was
%manipulated by the presence of either a neutral or valid exogenous
%attentional cue: valid cues were comprised of dot-placeholders presented
%at the cued location, while neutral cues consisted of four lines
%indicating that the target was equally likely to appear at all four
%potential locations. Valid cues were always indicative of the target
%location (100% validity). An EYELINK eyetracker was employed throughout
%the duration of the task to ensure fixation. For more information regarding 
%experimental design, stimulus presentation, or task protocol, please contact 
%the author.  

%The purpose of this code is to:
%   1. Prune the data (remove participants according to pre-established
%   exclusion protocol agreed upon by the author of this code and PI.)
%   This protocol outlines exclusion of participants that had completed 3 or
%   fewer experimental blocks, participants that incorrectly or partially
%   completed 'critical' components of the particpant questionnaire (age,
%   height, sex) and participants for whom data was lost, destroyed, or
%   otherwise unsalvageable. This is reflected in the 'Included' column of the
%   original data file. Contact the author regarding further questions. 
%2. Calculate weighted performance accuracy means for each cardinal
%   location in both conditions (valid exo cued, neutral cued)
%3. Output polar plots reflecting performance accuracies by location to visualize
%   VMA (vertical meridian asymmetry) and HVMA (horizontal-vertical meridian
%   asymmetry) and investigate the extent to which such asymmetries are present 
%   (or absent) in an adolescent sample.
%   4. Age-sort participants to investigate age-related differences in
%   VMA/HVMA magnitude and output 3 polar plots to visualize performance-field differences 
%   at 13, 14, and 15 years of age. 
%   5. Calculate an r value and output a scatterplot to examine the correlation between age and VMA
%   magnitude
%   6. Calculate the correlation between height and extent of the VMA, and
%   output a scatterplot figure to visualize the relationship
%   7. Calculate the correlation between age and height in our sample
%   8. Next steps: use the script titled 'Height' to create polar plots
%   based on height

%Assumptions: This code resides within a folder containing the original data 
%file, 'dataDPFCM.xlsx.' as well as both the 'setText' and 'Marisize' functions.
%If changes are made to the original dataset column-wise, the import section of 
%this program may need to be altered. However, the addition of new
%participants should not affect program function. 
%% 00 Init
close all
clear all
clc
%% Import the data
[~, ~, raw] = xlsread('/Volumes/purplab/EXPERIMENTS/1_Current_Experiments/Caroline/DPF ANALYSIS/dataDPFCM082019.xlsx','values 4 cpd');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
stringVectors = string(raw(:,[1,2,33,36,39,40,42,43,44,45,46,47,48,49,50,51,52,53,55,56,57,58,59]));
stringVectors(ismissing(stringVectors)) = '';
raw = raw(:,[3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,35,37,38,41,54]);

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
data = reshape([raw{:}],size(raw));

%% Create table
dataDPFCM082019 = table;

%% Allocate imported array to column variable names
dataDPFCM082019.PARTICIPANTID = stringVectors(:,1);
dataDPFCM082019.Name = stringVectors(:,2);
dataDPFCM082019.DAY = data(:,1);
dataDPFCM082019.DATE = data(:,2);
dataDPFCM082019.NUMTOTALTESTBLOCKS = data(:,3);
dataDPFCM082019.MeanContrast = data(:,4);
dataDPFCM082019.ECC = data(:,5);
dataDPFCM082019.SF = data(:,6);
dataDPFCM082019.VALIDUVM = data(:,7);
dataDPFCM082019.VALIDTemporal = data(:,8);
dataDPFCM082019.VALIDLVM = data(:,9);
dataDPFCM082019.VALIDNasal = data(:,10);
dataDPFCM082019.NEUTRALUVM = data(:,11);
dataDPFCM082019.NEUTRALTemporal = data(:,12);
dataDPFCM082019.NEUTRALLVM = data(:,13);
dataDPFCM082019.NEUTRALNasal = data(:,14);
dataDPFCM082019.RTVALIDUVM = data(:,15);
dataDPFCM082019.RTVALIDTemporal = data(:,16);
dataDPFCM082019.RTVALIDLVM = data(:,17);
dataDPFCM082019.RTVALIDNasal = data(:,18);
dataDPFCM082019.RTNEUTRALUVM = data(:,19);
dataDPFCM082019.RTNEUTRALTemporal = data(:,20);
dataDPFCM082019.RTNEUTRALLVM = data(:,21);
dataDPFCM082019.RTNEUTRALNasal = data(:,22);
dataDPFCM082019.HVAAccuracy_Valid = data(:,23);
dataDPFCM082019.HVAAccuracy_Neutral = data(:,24);
dataDPFCM082019.HVART_Valid = data(:,25);
dataDPFCM082019.HVART_Neutral = data(:,26);
dataDPFCM082019.VMAAccuracy_Valid = data(:,27);
dataDPFCM082019.VMAAccuracy_Neutral = data(:,28);
dataDPFCM082019.VMART_Valid = data(:,29);
dataDPFCM082019.VMART_Neutral = data(:,30);
dataDPFCM082019.Notes = categorical(stringVectors(:,3));
dataDPFCM082019.Included = data(:,31);
dataDPFCM082019.Excluded = data(:,32);
dataDPFCM082019.Sex = categorical(stringVectors(:,4));
dataDPFCM082019.DOBmmddyy = data(:,33);
dataDPFCM082019.age = data(:,34);
dataDPFCM082019.Handedness = categorical(stringVectors(:,5));
dataDPFCM082019.Height = categorical(stringVectors(:,6));
dataDPFCM082019.HeightInInches = data(:,35);
dataDPFCM082019.HispanicLatino = categorical(stringVectors(:,7));
dataDPFCM082019.Race = categorical(stringVectors(:,8));
dataDPFCM082019.CurrentGradeLevel = categorical(stringVectors(:,9));
dataDPFCM082019.ParticipateInFutureExperiments = categorical(stringVectors(:,10));
dataDPFCM082019.ContactInfo = stringVectors(:,11);
dataDPFCM082019.VisualCorrection = categorical(stringVectors(:,12));
dataDPFCM082019.TypeOfVisualImpairmentCorrected = categorical(stringVectors(:,13));
dataDPFCM082019.TreatedForAmblyopia = stringVectors(:,14);
dataDPFCM082019.TypeOfAmblyopiaTreatment = stringVectors(:,15);
dataDPFCM082019.PlayVideogames = categorical(stringVectors(:,16));
dataDPFCM082019.HowManyYearsGaming = categorical(stringVectors(:,17));
dataDPFCM082019.TypeOfVideogamePlay = stringVectors(:,18);
dataDPFCM082019.HoursSpentRegularlyGaming = data(:,36);
dataDPFCM082019.AnythingElseWeShouldKnow = stringVectors(:,19);
dataDPFCM082019.Association = categorical(stringVectors(:,20));
dataDPFCM082019.School = stringVectors(:,21);
dataDPFCM082019.Experimenter = stringVectors(:,22);
dataDPFCM082019.Room = stringVectors(:,23);

clearvars data raw stringVectors R;
%% Variables and Constants 
rawData = (dataDPFCM082019);%copy
CleanedData = rmmissing(rawData,'DataVariables','Included');%remove participants row wise based on exclusion criterion
totalBlocks = sum(CleanedData.NUMTOTALTESTBLOCKS); %These are the total number of 
sizeofCleaned = size(CleanedData);%size of table
numPartPruned = sizeofCleaned(1,1);%The length of rows. AKA number of subjects. 
firstPart = 1; %First SS starts at 1
specifiedRhoLim = [.5 1];%These are the specified min and max axes limits we want to impose on our polar plots
desiredLinewidth = 2.2; %This is the linewidth for the figure
hair = .054; %adds hair for fig
smallerHair = .02;
cardinalLocations = [0, 0.5*pi, pi, 1.5*pi,0]; %These are the cardinal locations, in radians. This will be fed into theta when we create the polar plots
TemporalLocationRad = cardinalLocations(1,1); %This is the temporal location (in rad)
UVMLocationRad = cardinalLocations(1,2);%This is the UVM location (in rad)
NasalLocationRad = cardinalLocations(1,3);%This is the nasal location (in rad)
LVMLocationRad = cardinalLocations(1,4);%This is the LVM location (in rad)
royalBlueRGB = [65/255 105/255 225/255];%the RGB value for royal blue, will be used for figures later
desiredScatterLinewidth = 1.2; %this is the linewidth I want for my scatter plots. It looks nice. 
desiredPointSize = 30; %how big do we want our scatterplot points?
nLocAll = [0.79892857142857 0.371904761904764 0.109821428571429 0.0619047619047619];
nLoc13 = [.22 0.23 0.029 0.028]; 
nLoc14 = [0.505 0.23 0.029 0.028];
nLoc15 = [0.79 0.23 0.029 0.028];
stepSize = 2; %This is the stepsize for the 3D plot
%% Preallocate
%pre-allocating for valid locations
vUVMWeighted = nan(numPartPruned,2); %pre-allocates a matrix to store the weighted valid UVM values
vTemporalWeighted = nan(numPartPruned,2);%pre-allocates a matrix to store the weighted valid temporal values
vLVMWeighted = nan(numPartPruned,2);%pre-allocates a matrix to store the weighted valid LVM values
vNasalWeighted = nan(numPartPruned,2);%pre-allocates a matrix to store the weighted valid Nasal values
%pre-allocating for neutral locations
nUVMWeighted = nan(numPartPruned,2);%pre-allocates a matrix to store the weighted neutral UVM values
nTemporalWeighted = nan(numPartPruned,2);%pre-allocates a matrix to store the weighted neutral temporal values
nLVMWeighted = nan(numPartPruned,2);%pre-allocates a matrix to store the weighted neutral LVM loc values
nNasalWeighted = nan(numPartPruned,2);%pre-allocates a matrix to store the weighted neutral nasal loc values

%% Get weights
for ii = firstPart:numPartPruned; %go through all participants
  %Valid locations: 
  vUVMWeighted(ii,1) = (CleanedData.VALIDUVM(ii).*CleanedData.NUMTOTALTESTBLOCKS(ii));%multiply each participant's accuracy by the number of blocks they completed, to weight participants' accuracy
  vUVMWeighted(ii,2) = vUVMWeighted(ii,1)/totalBlocks; %This really means nothing, but a useful sanity check
  
 vTemporalWeighted(ii,1) = (CleanedData.VALIDTemporal(ii).*CleanedData.NUMTOTALTESTBLOCKS(ii));%multiply each participant's accuracy by the number of blocks they completed, to weight participants' accuracy
  vTemporalWeighted(ii,2) = vTemporalWeighted(ii,1)/totalBlocks;%This really means nothing, but a useful sanity check
  
  vLVMWeighted(ii,1) = (CleanedData.VALIDLVM(ii).*CleanedData.NUMTOTALTESTBLOCKS(ii));%multiply each participant's accuracy by the number of blocks they completed, to weight participants' accuracy
  vLVMWeighted(ii,2) = vLVMWeighted(ii,1)/totalBlocks;%This really means nothing, but a useful sanity check
  
  vNasalWeighted(ii,1) = (CleanedData.VALIDNasal(ii).*CleanedData.NUMTOTALTESTBLOCKS(ii));
  vNasalWeighted(ii,2) = vNasalWeighted(ii,1)/totalBlocks;%This really means nothing, but a useful sanity check
  %Neutral locations
  nUVMWeighted(ii,1) = (CleanedData.NEUTRALUVM(ii).*CleanedData.NUMTOTALTESTBLOCKS(ii));%multiply each participant's accuracy by the number of blocks they completed, to weight participants' accuracy
  nUVMWeighted(ii,2) = nUVMWeighted(ii,1)/totalBlocks;%This really means nothing, but a useful sanity check
  
  nTemporalWeighted(ii,1) = (CleanedData.NEUTRALTemporal(ii).*CleanedData.NUMTOTALTESTBLOCKS(ii));%multiply each participant's accuracy by the number of blocks they completed, to weight participants' accuracy
  nTemporalWeighted(ii,2) = nTemporalWeighted(ii,1)/totalBlocks;%This really means nothing, but a useful sanity check
  
  nLVMWeighted(ii,1) = (CleanedData.NEUTRALLVM(ii).*CleanedData.NUMTOTALTESTBLOCKS(ii));%multiply each participant's accuracy by the number of blocks they completed, to weight participants' accuracy
  nLVMWeighted(ii,2) = nLVMWeighted(ii,1)/totalBlocks;%This really means nothing, but a useful sanity check
  
  nNasalWeighted(ii,1) = (CleanedData.NEUTRALNasal(ii).*CleanedData.NUMTOTALTESTBLOCKS(ii));%multiply each participant's accuracy by the number of blocks they completed, to weight participants' accuracy
  nNasalWeighted(ii,2) = nNasalWeighted(ii,1)/totalBlocks;%This really means nothing, but a useful sanity check
end
%% Create final output table
allWeighted = table(vUVMWeighted(:,1),vTemporalWeighted(:,1),vLVMWeighted(:,1),vNasalWeighted(:,1),nUVMWeighted(:,1),nTemporalWeighted(:,1),nLVMWeighted(:,1),nNasalWeighted(:,1));%Throw the weights into a table
allWeighted.Properties.VariableNames = {'vUVMWeighted','vTemporalWeighted','vLVMWeighted','vNasalWeighted','nUVMWeighted','nTemporalWeighted','nLVMWeighted','nNasalWeighted'};%Label them
allCleanedData = [CleanedData(:,1:11) allWeighted CleanedData(:,12:width(CleanedData))];%Throw it all in one big table. For consistency
cleanSize = size(allCleanedData);%how big is it? Sanity check
numPartPruned = cleanSize(1,1);%This is the number of participants after pruning. 
%allData = [allWeighted allCleanedData]
%% Get weighted means by location
%%%%%%%%%%%%%valid%%%%%%%%%%%%%%%%%%%%%%%%
weightedMeanvUVM = (sum(allCleanedData.vUVMWeighted(:)))/totalBlocks; %Add up all the weighted accuracies and divide by total number of test blocks to get the weighted avg
weightedMeanvTemporal = (sum(allCleanedData.vTemporalWeighted(:)))/totalBlocks; %Add up all the weighted accuracies and divide by total number of test blocks to get the weighted avg
weightedMeanvLVM = (sum(allCleanedData.vLVMWeighted(:)))/totalBlocks; %Add up all the weighted accuracies and divide by total number of test blocks to get the weighted avg
weightedMeanvNasal = (sum(allCleanedData.vNasalWeighted(:)))/totalBlocks; %Add up all the weighted accuracies and divide by total number of test blocks to get the weighted avg
%%%%%%%%%%%%%neutral%%%%%%%%%%%%%%%%%%%%%%%%
weightedMeannUVM = (sum(allCleanedData.nUVMWeighted(:)))/totalBlocks; %Add up all the weighted accuracies and divide by total number of test blocks to get the weighted avg
weightedMeannTemporal = (sum(allCleanedData.nTemporalWeighted(:)))/totalBlocks; %Add up all the weighted accuracies and divide by total number of test blocks to get the weighted avg
weightedMeannLVM = (sum(allCleanedData.nLVMWeighted(:)))/totalBlocks; %Add up all the weighted accuracies and divide by total number of test blocks to get the weighted avg
weightedMeannNasal = (sum(allCleanedData.nNasalWeighted(:)))/totalBlocks; %Add up all the weighted accuracies and divide by total number of test blocks to get the weighted avg

%% Now plot ALL mean accuracies in a polar plot
polarPlotFigure = figure; %opens new fig 'polarPlotFigure'
%Theta contains location around the circle. AKA the angle. In radians. 
%Rho contains the legnth of the radii 
thetaV = [cardinalLocations]; %The cardinal locations we want, in radians. Use deg2rad to convert degree angles to radians. Or just do it yourself. 
rhoV = [weightedMeanvTemporal,weightedMeanvUVM,weightedMeanvNasal,weightedMeanvLVM, weightedMeanvTemporal]; %Starting from the right horizontal location (RHM) and moving counterclockwise. So, input order should be [RHM, UVM,LHM,LVM,RHM] 
validHandle = polarplot(thetaV,rhoV);%get a handle on that thing!
validHandle.LineWidth = desiredLinewidth; %set desired linewidth
rlim([specifiedRhoLim]);
hold on %hold on to that

thetaN = [cardinalLocations];%The cardinal locations for neutral trials (should match input for valid trials here)
rhoN = [weightedMeannTemporal,weightedMeannUVM,weightedMeannNasal,weightedMeannLVM,weightedMeannTemporal]; %The radii (accuracies) for neutral trials. Remember to start with RHM and progress counterclockwise
neutralHandleAll = polarplot(thetaN,rhoN);%get a handle on that thing!
neutralHandleAll.LineWidth = desiredLinewidth; %set desired linewidth
rlim([specifiedRhoLim]);
title('Weighted performance accuracy at cardinal locations: all ages');%add a title
leg = legend('Valid','Neutral');
%%%%%%%%add text
%validHandleAll = gca; %gets current axes
setText(TemporalLocationRad,weightedMeanvTemporal); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(UVMLocationRad,weightedMeanvUVM); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(NasalLocationRad,weightedMeanvNasal); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(LVMLocationRad,weightedMeanvLVM); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location

%neutralHandleAll = gca;%gets current axes
setText(TemporalLocationRad,weightedMeannTemporal); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(UVMLocationRad,weightedMeannUVM); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(NasalLocationRad,weightedMeannNasal); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(LVMLocationRad,weightedMeannLVM); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location


% add group n
annotation(gcf,'textbox',[nLocAll],'String',['n = ',num2str(height(allCleanedData))],'FitBoxToText','on','LineStyle','none','FontSize',14,'FontName','Arial','FontAngle','italic');
hold off %hold off on that
shg %show me the money
%% Does age matter?
minage = min(allCleanedData.age); %just wondering... what are we looking at here?
maxage = max(allCleanedData.age); %just wondering... what are we looking at here?

thirteen = array2table(nan(size(allCleanedData)));%preallocate a table of nans to be filled with data from 13 year olds
fourteen = array2table(nan(size(allCleanedData)));%preallocate a table of nans to be filled with data from 14 year olds
fifteen = array2table(nan(size(allCleanedData)));%preallocate a table of nans to be filled with data from 15 year olds

for ii = firstPart:numPartPruned; %go through all participants
        if allCleanedData.age(ii) >= 13 && allCleanedData.age(ii) < 14; %If subjects are 13 or over AND less than 14 years old
        thirteen(ii,:) = allCleanedData(ii,:);%copy them into thirteen
        
        elseif allCleanedData.age(ii) >= 14 && allCleanedData.age(ii) < 15; %If subjects are 14 or over AND less than 15 years old
        fourteen(ii,:) = allCleanedData(ii,:);%copy them into fourteen

        elseif allCleanedData.age(ii) >= 15 && allCleanedData.age(ii) < 16; %if subjects are 15 or over AND less than 16 years old
        fifteen(ii,:) = allCleanedData(ii,:);%copy them into fifteen
    end
end
VarNamesss = allCleanedData.Properties.VariableNames %gets variable names
thirteen.Properties.VariableNames = VarNamesss;
fourteen.Properties.VariableNames = VarNamesss;
fifteen.Properties.VariableNames = VarNamesss;
thirteen = rmmissing(thirteen,'DataVariables','vUVMWeighted'); %remove empty rows based on a variable we know they should all have (UVM accuracy)
fourteen = rmmissing(fourteen,'DataVariables','vUVMWeighted');%remove empty rows based on a variable we know they should all have (UVM accuracy)
fifteen = rmmissing(fifteen,'DataVariables','vUVMWeighted');%remove empty rows based on a variable we know they should all have (UVM accuracy)
%% Now get the means per location 
%13 Y/O Valid
weightedMeanvUVM13 = (sum(thirteen.vUVMWeighted(:)))/sum(thirteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at upper location (valid cued)
weightedMeanvTemporal13 = (sum(thirteen.vTemporalWeighted(:)))/sum(thirteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at temporal location (valid cued)
weightedMeanvLVM13 = (sum(thirteen.vLVMWeighted(:)))/sum(thirteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at lower location (valid cued)
weightedMeanvNasal13 = (sum(thirteen.vNasalWeighted(:)))/sum(thirteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at nasal location (valid cued)
%13 Y/O Neutral
weightedMeannUVM13 = (sum(thirteen.nUVMWeighted(:)))/sum(thirteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at upper location(neutral cued)
weightedMeannTemporal13 = (sum(thirteen.nTemporalWeighted(:)))/sum(thirteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at temporal location (neutral cued)
weightedMeannLVM13 = (sum(thirteen.nLVMWeighted(:)))/sum(thirteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at lower location (neutral cued)
weightedMeannNasal13 = (sum(thirteen.nNasalWeighted(:)))/sum(thirteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at nasal location (neutral cued)

%14 Y/O Valid
weightedMeanvUVM14 = (sum(fourteen.vUVMWeighted(:)))/sum(fourteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at upper location (valid cued)
weightedMeanvTemporal14 = (sum(fourteen.vTemporalWeighted(:)))/sum(fourteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at temporal location (valid cued)
weightedMeanvLVM14 = (sum(fourteen.vLVMWeighted(:)))/sum(fourteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at lower location (valid cued)
weightedMeanvNasal14 = (sum(fourteen.vNasalWeighted(:)))/sum(fourteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at nasal location (valid cued)
%14 Y/O Neutral
weightedMeannUVM14 = (sum(fourteen.nUVMWeighted(:)))/sum(fourteen.NUMTOTALTESTBLOCKS); %divide the weighted value for each subject by the total number of test blocks completed at upper location (neutral cued)
weightedMeannTemporal14 = (sum(fourteen.nTemporalWeighted(:)))/sum(fourteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at temporal location (neutral cued)
weightedMeannLVM14 = (sum(fourteen.nLVMWeighted(:)))/sum(fourteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at lower location (neutral cued)
weightedMeannNasal14 = (sum(fourteen.nNasalWeighted(:)))/sum(fourteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at nasal location (neutral cued)

%15 Y/O Valid
weightedMeanvUVM15 = (sum(fifteen.vUVMWeighted(:)))/sum(fifteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at upper location (valid cued)
weightedMeanvTemporal15 = (sum(fifteen.vTemporalWeighted(:)))/sum(fifteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at temporal location (valid cued)
weightedMeanvLVM15 = (sum(fifteen.vLVMWeighted(:)))/sum(fifteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at lower location (valid cued)
weightedMeanvNasal15 = (sum(fifteen.vNasalWeighted(:)))/sum(fifteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at nasal location (valid cued)
%15 Y/O Neutral
weightedMeannUVM15 = (sum(fifteen.nUVMWeighted(:)))/sum(fifteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at upper location (neutral cued)
weightedMeannTemporal15 = (sum(fifteen.nTemporalWeighted(:)))/sum(fifteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at temporal location (neutral cued)
weightedMeannLVM15 = (sum(fifteen.nLVMWeighted(:)))/sum(fifteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at lower location (neutral cued)
weightedMeannNasal15 = (sum(fifteen.nNasalWeighted(:)))/sum(fifteen.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at nasal location (neutral cued)
%% Now plot
ageFigure = figure;%opens fig
polarPlotFigure1 = subplot(1,3,1);%opens new figure specifying subplot locations
%%%%%%%%%%%%%%%%VALID%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thetaV13 = [cardinalLocations]; %The cardinal locations we want, in radians. Use deg2rad to convert degree angles to radians. Or just do it yourself. 
rhoV13 = [weightedMeanvTemporal13,weightedMeanvUVM13,weightedMeanvNasal13,weightedMeanvLVM13,weightedMeanvTemporal13]; %Starting from the right horizontal location (RHM) and moving counterclockwise. So, input order should be [RHM, UVM,LHM,LVM,RHM]. %Last value should be the RHM radius again, to connect figure
validHandle13 = polarplot(thetaV13,rhoV13);%get a handle on that thing!
validHandle13.LineWidth = desiredLinewidth; %set desired linewidth
hold on %hold on to that
%%%%%%%%%%%%%%%%NEUTRAL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thetaN13 = [cardinalLocations];%The cardinal locations for neutral trials (should match input for valid trials here)
rhoN13 = [weightedMeannTemporal13,weightedMeannUVM13,weightedMeannNasal13,weightedMeannLVM13,weightedMeannTemporal13]; %The radii (accuracies) for neutral trials. Remember to start with RHM and progress counterclockwise
neutralHandle13 = polarplot(thetaN13,rhoN13);%get a handle on that thing!
neutralHandle13.LineWidth = desiredLinewidth; %set desired linewidth

%%%%%%add location labels using fxn 'setText'%%%%%%%
validHandle13 = gca;%gets current axes
setText(TemporalLocationRad,weightedMeanvTemporal13); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(UVMLocationRad,weightedMeanvUVM13); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(NasalLocationRad,weightedMeanvNasal13); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(LVMLocationRad,weightedMeanvLVM13); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
validHandle13.RLim = [specifiedRhoLim]; %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
neutralHandle13 = gca; %gets current axes
setText(TemporalLocationRad,weightedMeannTemporal13 - hair); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(UVMLocationRad,weightedMeannUVM13); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(NasalLocationRad,weightedMeannNasal13); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(LVMLocationRad,weightedMeannLVM13); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
neutralHandle13.RLim = [specifiedRhoLim];%imposes specified axes limits on polar plot

% add group n
annotation(gcf,'textbox',[nLoc13],'String',['n = ',num2str(height(thirteen))],'FitBoxToText','on','LineStyle','none','FontSize',14,'FontName','Arial','FontAngle','italic');
title('13 Year-Olds','FontName','Arial','FontSize',13);%add title
hold off %hold off on that
%%14 year olds
polarPlotFigure2 = subplot(1,3,2); %opens subplot 2: The 14 y/os
%%%%%%%%%%%%%%%%VALID%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thetaV14 = [cardinalLocations]; %The cardinal locations we want, in radians. Use deg2rad to convert degree angles to radians. Or just do it yourself. 
rhoV14 = [weightedMeanvTemporal14,weightedMeanvUVM14,weightedMeanvNasal14,weightedMeanvLVM14,weightedMeanvTemporal14]; %Starting from the right horizontal location (RHM) and moving counterclockwise. So, input order should be [RHM, UVM,LHM,LVM,RHM]. %Last value should be the RHM radius again, to connect figure
validHandle14 = polarplot(thetaV14,rhoV14);%get a handle on that thing!
validHandle14.LineWidth = desiredLinewidth; %set desired linewidth
rlim([specifiedRhoLim]);
hold on %hold on to that
%%%%%%%%%%%%%%%%NEUTRAL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thetaN14 = [cardinalLocations];%The cardinal locations for neutral trials (should match input for valid trials here)
rhoN14 = [weightedMeannTemporal14,weightedMeannUVM14,weightedMeannNasal14,weightedMeannLVM14,weightedMeannTemporal14]; %The radii (accuracies) for neutral trials. Remember to start with RHM and progress counterclockwise
neutralHandle14 = polarplot(thetaN14,rhoN14);%get a handle on that thing!
neutralHandle14.LineWidth = desiredLinewidth; %set desired linewidth
rlim([specifiedRhoLim]);
title('14 Year-Olds','FontName','Arial','FontSize',13);% adds title
%%%%%%%%add location labels using fxn 'setText'%%%%%%%
%validHandle14 = gca
setText(TemporalLocationRad,weightedMeanvTemporal14);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(UVMLocationRad,weightedMeanvUVM14);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(NasalLocationRad,weightedMeanvNasal14);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(LVMLocationRad,weightedMeanvLVM14);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
%validHandle14.RLim = [specifiedRhoLim];%imposes specified axes limits on polar plot

%neutralHandle14 = gca;%gets current axes
setText(TemporalLocationRad,weightedMeannTemporal14 - hair);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(UVMLocationRad,weightedMeannUVM14);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(NasalLocationRad,weightedMeannNasal14);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(LVMLocationRad,weightedMeannLVM14);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
%neutralHandle14.RLim = [specifiedRhoLim];%imposes specified axes limits on polar plot

% Add group n
annotation(gcf,'textbox',[nLoc14],'String',['n = ',num2str(height(fourteen))],'FitBoxToText','on','LineStyle','none','FontSize',14,'FontName','Arial','FontAngle','italic');
hold off %hold off on that

%%The 15 year olds
polarPlotFigure3 = subplot(1,3,3); %specifies locations of third subplot
%%%%%%%%%%%%%%%%VALID%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thetaV15 = [cardinalLocations]; %The cardinal locations we want, in radians. Use deg2rad to convert degree angles to radians. Or just do it yourself. 
rhoV15 = [weightedMeanvTemporal15,weightedMeanvUVM15,weightedMeanvNasal15,weightedMeanvLVM15,weightedMeanvTemporal15]; %Starting from the right horizontal location (RHM) and moving counterclockwise. So, input order should be [RHM, UVM,LHM,LVM,RHM] 
%Importantly, the last value should be the RHM radius again, to connect the
%figure. 
validHandle15 = polarplot(thetaV15,rhoV15);%get a handle on that thing!
validHandle15.LineWidth = desiredLinewidth; %set desired linewidth
rlim([specifiedRhoLim]);
hold on %hold on to that
%%%%%%%%%%%%%%%%NEUTRAL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thetaN15 = [cardinalLocations];%The cardinal locations for neutral trials (should match input for valid trials here)
rhoN15 = [weightedMeannTemporal15,weightedMeannUVM15,weightedMeannNasal15,weightedMeannLVM15,weightedMeannTemporal15]; %The radii (accuracies) for neutral trials. Remember to start with RHM and progress counterclockwise
neutralHandle15 = polarplot(thetaN15,rhoN15);%get a handle on that thing!
neutralHandle15.LineWidth = desiredLinewidth; %set desired linewidth
rlim([specifiedRhoLim]);
%%%% add text
validHandle15 = gca
setText(TemporalLocationRad,weightedMeanvTemporal15);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(UVMLocationRad,weightedMeanvUVM15);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(NasalLocationRad,weightedMeanvNasal15 + .02);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(LVMLocationRad,weightedMeanvLVM15);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
%validHandle15.RLim = [specifiedRhoLim];%imposes specified axes limits on polar plot
neutralHandle15 = gca;%handle axes
setText(TemporalLocationRad,weightedMeannTemporal15 - hair);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(UVMLocationRad,weightedMeannUVM15);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(NasalLocationRad,weightedMeannNasal15 -.02);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(LVMLocationRad,weightedMeannLVM15);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
%validHandle15.RLim = [specifiedRhoLim];%imposes specified axes limits on polar plot
title('15 Year-Olds','FontName','Arial','FontSize',13);%add title
% Add group n
annotation(gcf,'textbox',[nLoc15],'String',['n = ',num2str(height(fifteen))],'FitBoxToText','on','LineStyle','none','FontSize',14,'FontName','Arial','FontAngle','italic');
shg %show me the money
%% Weird. Not what we were expecting to see. Let's look at it a different way?
%%%%%valid

VMADifferenceValid = nan(numPartPruned,1);%preallocate an array of nans the size of our participants to store VMA difference values
for ii = firstPart:numPartPruned; %go through all participants
        VMADifferenceValid(ii) = (allCleanedData.VALIDLVM(ii)) / (allCleanedData.VALIDUVM(ii)); %Subtract UVM accuracy from LVM accuracy. The bigger this value, the more pronounced the asymmetry. 
end%end
[ValidRAge,ValidPValueAge] = corrcoef(allCleanedData.age,VMADifferenceValid);%get R and p values for age vs. vma correlation
VMAfig = figure %opens new figure
VMAValid = subplot(1,2,1); %specifies locations of third subplot
VMAplot = scatter(allCleanedData.age,VMADifferenceValid,desiredPointSize,'k');
ageLine = lsline(gca);%add line
set(ageLine,'LineWidth',desiredScatterLinewidth,'Color',[royalBlueRGB]);%change line width and color
xlabel('Age in years');%add x label
ylabel('VMA - Valid (LVM/UVM)');%label the y axis. we all know what this means and it's getting annoying
title('Age vs. extent of VMA - Valid');%This is a title. Freaking obviously. come on 
str1V=[' R = ',num2str(ValidRAge(1,2))];%create a new string converting the r value into a string
T1V = text(min(get(gca, 'xlim')), max(get(gca,'ylim')), str1V); %make it a text box
set(T1V,'verticalalignment','top','horizontalalignment','left');%set it where you want

str2VA=[' P = ',num2str(ValidPValueAge(1,2))];%R value converted to string to place on fig
T2VA = text(max(get(gca,'xlim')), max(get(gca,'ylim')), str2VA); %get axes to place text
set(T2VA,'verticalalignment','top','horizontalalignment','right','LineStyle','none','FontSize',11,'FontName','Arial','FontAngle','italic');%set text location

Marisize(12,1);%make it pretty. Fontsize 12. apply to whole fig. 

hold on
%Now neutral!
VMADifferenceNeutral = nan(numPartPruned,1);%preallocate an array of nans the size of our participants to store VMA difference values
for ii = firstPart:numPartPruned; %go through all participants
        VMADifferenceNeutral(ii) = (allCleanedData.NEUTRALLVM(ii)) / (allCleanedData.NEUTRALUVM(ii)); %Subtract UVM accuracy from LVM accuracy. The bigger this value, the more pronounced the asymmetry. 
end%end
[NeutralRAge,NeutralPValueAge] = corrcoef(allCleanedData.age,VMADifferenceNeutral);%get R and p values for age vs. vma correlation
gcf %opens new figure
VMANeutral = subplot(1,2,2); %specifies locations of third subplot

VMAplot = scatter(allCleanedData.age,VMADifferenceNeutral,desiredPointSize,'k');
ageLine = lsline(gca);%add line
set(ageLine,'LineWidth',desiredScatterLinewidth,'Color',[royalBlueRGB]);%change line width and color
xlabel('Age in years');%add x label
ylabel('VMA - Neutral (LVM/UVM)');%label the y axis. we all know what this means and it's getting annoying
title('Age vs. extent of VMA - Neutral');%This is a title. Freaking obviously. come on 
str1N=[' R = ',num2str(NeutralRAge(1,2))];%create a new string converting the r value into a string
T1N = text(min(get(gca, 'xlim')), max(get(gca,'ylim')), str1N); %make it a text box
set(T1N,'verticalalignment','top','horizontalalignment','left');%set it where you want

str2NA=[' P = ',num2str(NeutralPValueAge(1,2))];%R value converted to string to place on fig
T2NA = text(max(get(gca,'xlim')), max(get(gca,'ylim')), str2NA); %get axes to place text
set(T2NA,'verticalalignment','top','horizontalalignment','right','LineStyle','none','FontSize',11,'FontName','Arial','FontAngle','italic');%set text location

Marisize(12,1);%make it pretty. Fontsize 12. apply to whole fig. 


hold off
shg;%show me the money

%% Height

%%%%%valid
VMADifferenceValid = nan(numPartPruned,1);%preallocate an array of nans the size of our participants to store VMA difference values
for ii = firstPart:numPartPruned; %go through all participants
        VMADifferenceValid(ii) = (allCleanedData.VALIDLVM(ii)) / (allCleanedData.VALIDUVM(ii)); %Subtract UVM accuracy from LVM accuracy. The bigger this value, the more pronounced the asymmetry. 
end%end
[ValidRHeight,ValidPValueHeight] = corrcoef(allCleanedData.HeightInInches,VMADifferenceValid);%get R and p values for age vs. vma correlation
VMAfig = figure %opens new figure
VMAValid = subplot(1,2,1); %specifies locations of third subplot
VMAplot = scatter(allCleanedData.HeightInInches,VMADifferenceValid,desiredPointSize,'k');
heightLine = lsline(gca);%add line
set(heightLine,'LineWidth',desiredScatterLinewidth,'Color',[royalBlueRGB]);%change line width and color
xlabel('Height in inches');%add x label
ylabel('VMA - Valid (LVM/UVM)');%label the y axis. we all know what this means and it's getting annoying
title('Height vs. extent of VMA - Valid');%This is a title. Freaking obviously. come on 
str1VH=[' R = ',num2str(ValidRHeight(1,2))];%create a new string converting the r value into a string
T1VH = text(min(get(gca, 'xlim')), max(get(gca,'ylim')), str1VH); %make it a text box
set(T1VH,'verticalalignment','top','horizontalalignment','left');%set it where you want

str2VH=[' P = ',num2str(ValidPValueHeight(1,2))];%R value converted to string to place on fig
T2VH = text(max(get(gca,'xlim')), max(get(gca,'ylim')), str2VH); %get axes to place text
set(T2VH,'verticalalignment','top','horizontalalignment','right','LineStyle','none','FontSize',11,'FontName','Arial','FontAngle','italic');%set text location


Marisize(12,1);%make it pretty. Fontsize 12. apply to whole fig. 

hold on
%Now neutral!
VMADifferenceNeutral = nan(numPartPruned,1);%preallocate an array of nans the size of our participants to store VMA difference values
for ii = firstPart:numPartPruned; %go through all participants
        VMADifferenceNeutral(ii) = (allCleanedData.NEUTRALLVM(ii)) / (allCleanedData.NEUTRALUVM(ii)); %Subtract UVM accuracy from LVM accuracy. The bigger this value, the more pronounced the asymmetry. 
end%end
[NeutralRHeight,NeutralPValueHeight] = corrcoef(allCleanedData.HeightInInches,VMADifferenceNeutral);%get R and p values for age vs. vma correlation
gcf %opens new figure
VMANeutral = subplot(1,2,2); %specifies locations of third subplot

VMAplot = scatter(allCleanedData.HeightInInches,VMADifferenceNeutral,desiredPointSize,'k');
ageLine = lsline(gca);%add line
set(ageLine,'LineWidth',desiredScatterLinewidth,'Color',[royalBlueRGB]);%change line width and color
xlabel('Height in Inches');%add x label
ylabel('VMA - Neutral (LVM/UVM)');%label the y axis. we all know what this means and it's getting annoying
title('Height vs. extent of VMA - Neutral');%This is a title. Freaking obviously. come on 
str1NH=[' R = ',num2str(NeutralRHeight(1,2))];%create a new string converting the r value into a string
T1NH = text(min(get(gca, 'xlim')), max(get(gca,'ylim')), str1NH); %make it a text box
set(T1NH,'verticalalignment','top','horizontalalignment','left');%set it where you want

str2NH=[' P = ',num2str(NeutralPValueHeight(1,2))];%R value converted to string to place on fig
T2NH = text(max(get(gca,'xlim')), max(get(gca,'ylim')), str2NH); %get axes to place text
set(T2NH,'verticalalignment','top','horizontalalignment','right','LineStyle','none','FontSize',11,'FontName','Arial','FontAngle','italic');%set text location



Marisize(12,1);%make it pretty. Fontsize 12. apply to whole fig. 


hold off
shg;%show me the money

% %% Ok... what about height? 
% [RHeight,PValueHeight] = corrcoef(allCleanedData.HeightInInches,VMADifferenceNeutral);%get the r value and p values 
% Heightfig = figure;%open new fig
% VMAplot = scatter(allCleanedData.HeightInInches,VMADifferenceNeutral,desiredPointSize,'k');%output a scatterplot of height vs. VMA and make the points black.
% heightLine = lsline(gca);%add best fit
% set(heightLine,'LineWidth',desiredScatterLinewidth,'Color',[royalBlueRGB]);
% xlabel('Height in Inches');%add x label
% ylabel('Accuracy Difference: LVM-UVM (magnitude of asymmetry)');%add y label
% title('Height vs. extent of VMA');%add title
% str2=[' R= ',num2str(RHeight(1,2))];%R value converted to string to place on fig
% T2 = text(min(get(gca, 'xlim')), max(get(gca,'ylim')), str2); %get axes to place text
% set(T2,'verticalalignment','top','horizontalalignment','left');%set text location
% Marisize(12,1);%applies fxn to make figure pretty. 
% shg;%show me the money
% %% Oh. my. god. That was cool. What about all 3? Let's visualize it! 
% ageHeightVMAFig = figure;
% ageHeightVMAplot = plot3(allCleanedData.age,allCleanedData.HeightInInches,VMADifferenceNeutral,'o');
% xlabel('Age in years');
% ylabel('Height in Inches');
% zlabel('Accuracy Difference: LVM-UVM (magnitude of asymmetry)');
% title('Age and height impact on VMA');
% Marisize(12,1);%applies fxn to make the figure prettier, fontsize 12, whole figure 
% box on;% turns on box
% grid on; %turn grid on
% ax = gca; %get current axes
% ax.BoxStyle = 'back';%this is the default 
% ax.LineWidth = 1;%This is the linewidth of the axes marks
% ax.YTick = [60:stepSize:70];%these are the tickmarks we want. informative. 
% rotate3d on;%let's rotate that shit
% shg%show me the money

%% So are height and age inversely related?
C = cov(allCleanedData.age,allCleanedData.HeightInInches);
AgeXHeightFig = figure
AgeXHeight = myplot(allCleanedData.age,allCleanedData.HeightInInches);
xlabel('Age in years');
ylabel('Height in Inches');

title('Age x Height');
Marisize(12,1);
shg;


%% Now, let's look at height 
meanContrastAll = mean(allCleanedData.MeanContrast);
maxContrastAll= max(allCleanedData.MeanContrast);
minContrastAll = min(allCleanedData.MeanContrast);

meanContrastAll
maxContrastAll
minContrastAll

%histogram(allCleanedData.MeanContrast)
