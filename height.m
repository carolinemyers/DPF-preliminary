%% Hello 
%Written by Caroline Myers (contact: cfm304@nyu.edu) 
%Carrasco Lab
%July 19th, 2019. 
%Version history: none
%This script was developed from the age analysis section of the DPF
%analysis script, written and conceptualized by Caroline Myers. 
%Assumptions: in order for this segment to run, the
%DPFAnalysisScriptFinalCM.m file must be run and no variables cleared from the
%workspace. 
%Input: the workspace from DPFAnalysisScriptFINALCM.m and both marisize and
%setText fxns
%Output: a polar plot of accuracies across cardinal locations by height.
%It's dope. 
%% Now, let's look at height 
minheight = min(allCleanedData.HeightInInches); %just wondering... what are we looking at here?
maxheight = max(allCleanedData.HeightInInches); %just wondering... what are we looking at here?

lowerheight = array2table(nan(size(allCleanedData)));%preallocate a table of nans to be filled with data from 60-62 inches (lower height)
middleheight = array2table(nan(size(allCleanedData)));%preallocate a table of nans to be filled with data from 63-65 inches (middle height)
upperheight = array2table(nan(size(allCleanedData)));%preallocate a table of nans to be filled with data from 66-69 inches (upper height)

for ii = firstPart:numPartPruned; %go through all participants
        if allCleanedData.HeightInInches(ii) >= 60 && allCleanedData.HeightInInches(ii) < 63; %60-63 in 4 3 3
        lowerheight(ii,:) = allCleanedData(ii,:);%copy them into lowerheight
        
        elseif allCleanedData.HeightInInches(ii) >= 63 && allCleanedData.HeightInInches(ii) < 66; %If subjects are 14 or over AND less than 15 years old
        middleheight(ii,:) = allCleanedData(ii,:);%copy them into middleheight

        elseif allCleanedData.HeightInInches(ii) >= 66 && allCleanedData.HeightInInches(ii) < 70; %if subjects are 15 or over AND less than 16 years old
        upperheight(ii,:) = allCleanedData(ii,:);%copy them into upperheight
    end
end
lowerheight.Properties.VariableNames = allCleanedData.Properties.VariableNames;%{'vUVMWeighted','vTemporalWeighted','vLVMWeighted','vNasalWeighted','nUVMWeighted','nTemporalWeighted','nLVMWeighted','nNasalWeighted','PARTICIPANTID','DATE','NUMTOTALTESTBLOCKS','VALIDUVM','VALIDTemporal','VALIDLVM','VALIDNasal','NEUTRALUVM','NEUTRALTemporal','NEUTRALLVM','NEUTRALNasal','Notes','Included','Excluded','Name','Sex','Dateofbirthmmddyyyy','age','Handedness','Height','HeightInInches','AreyouHispanicorLatino','Race','Educationlevelyouareinrightnow','Areyouwillingtobecontactedtoparticipateinfutureexperiments','Ifyouansweredyesormaybetothepreviousquestionpleaseprovideyourph','Doyouuseanytypeofvisualcorrectioniecontactlensesorglasses','Ifyestotheabovequestionwhattypeofimpairmentdoyoucorrectfor','Ifyoucheckedtheboxforamblyopiawereyouevertreated','Iftreatedforamblyopiawithwhat','Doyouplayvideogamesoften','Ifyoudoplayhowmanyyearshaveyoubeenplaying','Ifyoudoplaywhatkind','Ifyouhaveplayedregularlyinthelast5yearsapproximatelyhowmanyhour','Isthereanythingelseregardingyourvisualabilitiesandorhistorythat'};
middleheight.Properties.VariableNames = allCleanedData.Properties.VariableNames;%{'vUVMWeighted','vTemporalWeighted','vLVMWeighted','vNasalWeighted','nUVMWeighted','nTemporalWeighted','nLVMWeighted','nNasalWeighted','PARTICIPANTID','DATE','NUMTOTALTESTBLOCKS','VALIDUVM','VALIDTemporal','VALIDLVM','VALIDNasal','NEUTRALUVM','NEUTRALTemporal','NEUTRALLVM','NEUTRALNasal','Notes','Included','Excluded','Name','Sex','Dateofbirthmmddyyyy','age','Handedness','Height','HeightInInches','AreyouHispanicorLatino','Race','Educationlevelyouareinrightnow','Areyouwillingtobecontactedtoparticipateinfutureexperiments','Ifyouansweredyesormaybetothepreviousquestionpleaseprovideyourph','Doyouuseanytypeofvisualcorrectioniecontactlensesorglasses','Ifyestotheabovequestionwhattypeofimpairmentdoyoucorrectfor','Ifyoucheckedtheboxforamblyopiawereyouevertreated','Iftreatedforamblyopiawithwhat','Doyouplayvideogamesoften','Ifyoudoplayhowmanyyearshaveyoubeenplaying','Ifyoudoplaywhatkind','Ifyouhaveplayedregularlyinthelast5yearsapproximatelyhowmanyhour','Isthereanythingelseregardingyourvisualabilitiesandorhistorythat'};
upperheight.Properties.VariableNames = allCleanedData.Properties.VariableNames;%{'vUVMWeighted','vTemporalWeighted','vLVMWeighted','vNasalWeighted','nUVMWeighted','nTemporalWeighted','nLVMWeighted','nNasalWeighted','PARTICIPANTID','DATE','NUMTOTALTESTBLOCKS','VALIDUVM','VALIDTemporal','VALIDLVM','VALIDNasal','NEUTRALUVM','NEUTRALTemporal','NEUTRALLVM','NEUTRALNasal','Notes','Included','Excluded','Name','Sex','Dateofbirthmmddyyyy','age','Handedness','Height','HeightInInches','AreyouHispanicorLatino','Race','Educationlevelyouareinrightnow','Areyouwillingtobecontactedtoparticipateinfutureexperiments','Ifyouansweredyesormaybetothepreviousquestionpleaseprovideyourph','Doyouuseanytypeofvisualcorrectioniecontactlensesorglasses','Ifyestotheabovequestionwhattypeofimpairmentdoyoucorrectfor','Ifyoucheckedtheboxforamblyopiawereyouevertreated','Iftreatedforamblyopiawithwhat','Doyouplayvideogamesoften','Ifyoudoplayhowmanyyearshaveyoubeenplaying','Ifyoudoplaywhatkind','Ifyouhaveplayedregularlyinthelast5yearsapproximatelyhowmanyhour','Isthereanythingelseregardingyourvisualabilitiesandorhistorythat'};
lowerheight = rmmissing(lowerheight,'DataVariables','vUVMWeighted'); %remove empty rows based on a variable we know they should all have (UVM accuracy)
middleheight = rmmissing(middleheight,'DataVariables','vUVMWeighted');%remove empty rows based on a variable we know they should all have (UVM accuracy)
upperheight = rmmissing(upperheight,'DataVariables','vUVMWeighted');%remove empty rows based on a variable we know they should all have (UVM accuracy)
%% Now get the means per location 
%LowerHeight Valid
weightedMeanvUVMlowerheight = (sum(lowerheight.vUVMWeighted(:)))/sum(lowerheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at upper location (valid cued)
weightedMeanvTemporallowerheight = (sum(lowerheight.vTemporalWeighted(:)))/sum(lowerheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at temporal location (valid cued)
weightedMeanvLVMlowerheight = (sum(lowerheight.vLVMWeighted(:)))/sum(lowerheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at lower location (valid cued)
weightedMeanvNasallowerheight = (sum(lowerheight.vNasalWeighted(:)))/sum(lowerheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at nasal location (valid cued)
%LowerHeight Neutral
weightedMeannUVMlowerheight = (sum(lowerheight.nUVMWeighted(:)))/sum(lowerheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at upper location(neutral cued)
weightedMeannTemporallowerheight = (sum(lowerheight.nTemporalWeighted(:)))/sum(lowerheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at temporal location (neutral cued)
weightedMeannLVMlowerheight = (sum(lowerheight.nLVMWeighted(:)))/sum(lowerheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at lower location (neutral cued)
weightedMeannNasallowerheight = (sum(lowerheight.nNasalWeighted(:)))/sum(lowerheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at nasal location (neutral cued)

%MiddleHeight Valid
weightedMeanvUVMmiddleheight = (sum(middleheight.vUVMWeighted(:)))/sum(middleheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at upper location (valid cued)
weightedMeanvTemporalmiddleheight = (sum(middleheight.vTemporalWeighted(:)))/sum(middleheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at temporal location (valid cued)
weightedMeanvLVMmiddleheight = (sum(middleheight.vLVMWeighted(:)))/sum(middleheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at lower location (valid cued)
weightedMeanvNasalmiddleheight = (sum(middleheight.vNasalWeighted(:)))/sum(middleheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at nasal location (valid cued)
%MiddleHeight Neutral
weightedMeannUVMmiddleheight = (sum(middleheight.nUVMWeighted(:)))/sum(middleheight.NUMTOTALTESTBLOCKS); %divide the weighted value for each subject by the total number of test blocks completed at upper location (neutral cued)
weightedMeannTemporalmiddleheight = (sum(middleheight.nTemporalWeighted(:)))/sum(middleheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at temporal location (neutral cued)
weightedMeannLVMmiddleheight = (sum(middleheight.nLVMWeighted(:)))/sum(middleheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at lower location (neutral cued)
weightedMeannNasalmiddleheight = (sum(middleheight.nNasalWeighted(:)))/sum(middleheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at nasal location (neutral cued)

%UpperHeight Valid
weightedMeanvUVMupperheight = (sum(upperheight.vUVMWeighted(:)))/sum(upperheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at upper location (valid cued)
weightedMeanvTemporalupperheight = (sum(upperheight.vTemporalWeighted(:)))/sum(upperheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at temporal location (valid cued)
weightedMeanvLVMupperheight = (sum(upperheight.vLVMWeighted(:)))/sum(upperheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at lower location (valid cued)
weightedMeanvNasalupperheight = (sum(upperheight.vNasalWeighted(:)))/sum(upperheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at nasal location (valid cued)
%UpperHeight Neutral
weightedMeannUVMupperheight = (sum(upperheight.nUVMWeighted(:)))/sum(upperheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at upper location (neutral cued)
weightedMeannTemporalupperheight = (sum(upperheight.nTemporalWeighted(:)))/sum(upperheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at temporal location (neutral cued)
weightedMeannLVMupperheight = (sum(upperheight.nLVMWeighted(:)))/sum(upperheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at lower location (neutral cued)
weightedMeannNasalupperheight = (sum(upperheight.nNasalWeighted(:)))/sum(upperheight.NUMTOTALTESTBLOCKS);%divide the weighted value for each subject by the total number of test blocks completed at nasal location (neutral cued)
%% Now plot
ageFigure = figure;%opens fig
polarPlotFigure1 = subplot(1,3,1);%opens new figure specifying subplot locations
%%%%%%%%%%%%%%%%VALID%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thetaVlowerheight = [cardinalLocations]; %The cardinal locations we want, in radians. Use deg2rad to convert degree angles to radians. Or just do it yourself. 
rhoVlowerheight = [weightedMeanvTemporallowerheight,weightedMeanvUVMlowerheight,weightedMeanvNasallowerheight,weightedMeanvLVMlowerheight,weightedMeanvTemporallowerheight]; %Starting from the right horizontal location (RHM) and moving counterclockwise. So, input order should be [RHM, UVM,LHM,LVM,RHM]. %Last value should be the RHM radius again, to connect figure
validHandlelowerheight = polarplot(thetaVlowerheight,rhoVlowerheight);%get a handle on that thing!
validHandlelowerheight.LineWidth = desiredLinewidth; %set desired linewidth
rlim([specifiedRhoLim]);
hold on %hold on to that
%%%%%%%%%%%%%%%%NEUTRAL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thetaNlowerheight = [cardinalLocations];%The cardinal locations for neutral trials (should match input for valid trials here)
rhoNlowerheight = [weightedMeannTemporallowerheight,weightedMeannUVMlowerheight,weightedMeannNasallowerheight,weightedMeannLVMlowerheight,weightedMeannTemporallowerheight]; %The radii (accuracies) for neutral trials. Remember to start with RHM and progress counterclockwise
neutralHandlelowerheight = polarplot(thetaNlowerheight,rhoNlowerheight);%get a handle on that thing!
neutralHandlelowerheight.LineWidth = desiredLinewidth; %set desired linewidth
rlim([specifiedRhoLim]);
%%%%%%add location labels using fxn 'setText'%%%%%%%
validHandlelowerheight = gca;%gets current axes
setText(TemporalLocationRad,weightedMeanvTemporallowerheight); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(UVMLocationRad,weightedMeanvUVMlowerheight); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(NasalLocationRad,weightedMeanvNasallowerheight); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(LVMLocationRad,weightedMeanvLVMlowerheight); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
validHandlelowerheight.RLim = [specifiedRhoLim]; %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
%neutralHandlelowerheight = gca; %gets current axes
setText(TemporalLocationRad,weightedMeannTemporallowerheight -.02); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(UVMLocationRad,weightedMeannUVMlowerheight); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(NasalLocationRad,weightedMeannNasallowerheight - .02); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(LVMLocationRad,weightedMeannLVMlowerheight); %uses setText fxn, which places a text box containing the accuracy value at each cardinal location
%neutralHandlelowerheight.RLim = [specifiedRhoLim];%imposes specified axes limits on polar plot

% add group n
annotation(gcf,'textbox',[nLoc13],'String',['n = ',num2str(height(lowerheight))],'FitBoxToText','on','LineStyle','none','FontSize',14,'FontName','Arial','FontAngle','italic');
title('60-62 inches','FontName','Arial','FontSize',13);%add title
hold off %hold off on that
%%Middle Height
polarPlotFigure2 = subplot(1,3,2); %opens subplot 2: The middle heights
%%%%%%%%%%%%%%%%VALID%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thetaVmiddleheight = [cardinalLocations]; %The cardinal locations we want, in radians. Use deg2rad to convert degree angles to radians. Or just do it yourself. 
rhoVmiddleheight = [weightedMeanvTemporalmiddleheight,weightedMeanvUVMmiddleheight,weightedMeanvNasalmiddleheight,weightedMeanvLVMmiddleheight,weightedMeanvTemporalmiddleheight]; %Starting from the right horizontal location (RHM) and moving counterclockwise. So, input order should be [RHM, UVM,LHM,LVM,RHM]. %Last value should be the RHM radius again, to connect figure
validHandlemiddleheight = polarplot(thetaVmiddleheight,rhoVmiddleheight);%get a handle on that thing!
validHandlemiddleheight.LineWidth = desiredLinewidth; %set desired linewidth
rlim([specifiedRhoLim]);
hold on %hold on to that
%%%%%%%%%%%%%%%%NEUTRAL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thetaNmiddleheight = [cardinalLocations];%The cardinal locations for neutral trials (should match input for valid trials here)
rhoNmiddleheight = [weightedMeannTemporalmiddleheight,weightedMeannUVMmiddleheight,weightedMeannNasalmiddleheight,weightedMeannLVMmiddleheight,weightedMeannTemporalmiddleheight]; %The radii (accuracies) for neutral trials. Remember to start with RHM and progress counterclockwise
neutralHandlemiddleheight = polarplot(thetaNmiddleheight,rhoNmiddleheight);%get a handle on that thing!
neutralHandlemiddleheight.LineWidth = desiredLinewidth; %set desired linewidth
rlim([specifiedRhoLim]);
title('63-65 inches','FontName','Arial','FontSize',13);% adds title
%%%%%%%%add location labels using fxn 'setText'%%%%%%%
validHandlemiddleheight = gca;
setText(TemporalLocationRad,weightedMeanvTemporalmiddleheight);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(UVMLocationRad,weightedMeanvUVMmiddleheight);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(NasalLocationRad,weightedMeanvNasalmiddleheight);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(LVMLocationRad,weightedMeanvLVMmiddleheight);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
%validHandlemiddleheight.RLim = [specifiedRhoLim];%imposes specified axes limits on polar plot

neutralHandlemiddleheight = gca;%gets current axes
setText(TemporalLocationRad,weightedMeannTemporalmiddleheight - .02);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(UVMLocationRad,weightedMeannUVMmiddleheight);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(NasalLocationRad,weightedMeannNasalmiddleheight-.02);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(LVMLocationRad,weightedMeannLVMmiddleheight);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
%neutralHandlemiddleheight.RLim = [specifiedRhoLim];%imposes specified axes limits on polar plot

% Add group n
annotation(gcf,'textbox',[nLoc14],'String',['n = ',num2str(height(middleheight))],'FitBoxToText','on','LineStyle','none','FontSize',14,'FontName','Arial','FontAngle','italic');
hold off %hold off on that

%%Upper heights
polarPlotFigure3 = subplot(1,3,3); %specifies locations of third subplot
%%%%%%%%%%%%%%%%VALID%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thetaVupperheight = [cardinalLocations]; %The cardinal locations we want, in radians. Use deg2rad to convert degree angles to radians. Or just do it yourself. 
rhoVupperheight = [weightedMeanvTemporalupperheight,weightedMeanvUVMupperheight,weightedMeanvNasalupperheight,weightedMeanvLVMupperheight,weightedMeanvTemporalupperheight]; %Starting from the right horizontal location (RHM) and moving counterclockwise. So, input order should be [RHM, UVM,LHM,LVM,RHM] 
%Importantly, the last value should be the RHM radius again, to connect the
%figure. 
validHandleupperheight = polarplot(thetaVupperheight,rhoVupperheight);%get a handle on that thing!
validHandleupperheight.LineWidth = desiredLinewidth; %set desired linewidth
rlim([specifiedRhoLim]);
hold on %hold on to that
%%%%%%%%%%%%%%%%NEUTRAL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thetaNupperheight = [cardinalLocations];%The cardinal locations for neutral trials (should match input for valid trials here)
rhoNupperheight = [weightedMeannTemporalupperheight,weightedMeannUVMupperheight,weightedMeannNasalupperheight,weightedMeannLVMupperheight,weightedMeannTemporalupperheight]; %The radii (accuracies) for neutral trials. Remember to start with RHM and progress counterclockwise
neutralHandleupperheight = polarplot(thetaNupperheight,rhoNupperheight);%get a handle on that thing!
neutralHandleupperheight.LineWidth = desiredLinewidth; %set desired linewidth
rlim([specifiedRhoLim]);
%%%% add text
validHandleupperheight = gca;
setText(TemporalLocationRad,weightedMeanvTemporalupperheight);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(UVMLocationRad,weightedMeanvUVMupperheight);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(NasalLocationRad,weightedMeanvNasalupperheight);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(LVMLocationRad,weightedMeanvLVMupperheight);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
%validHandleupperheight.RLim = [specifiedRhoLim];%imposes specified axes limits on polar plot
neutralHandleupperheight = gca;%handle axes
setText(TemporalLocationRad,weightedMeannTemporalupperheight - .02);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(UVMLocationRad,weightedMeannUVMupperheight);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(NasalLocationRad,weightedMeannNasalupperheight - .02);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
setText(LVMLocationRad,weightedMeannLVMupperheight);%uses setText fxn, which places a text box containing the accuracy value at each cardinal location
%validHandleupperheight.RLim = [specifiedRhoLim];%imposes specified axes limits on polar plot
title('66-69 inches','FontName','Arial','FontSize',13);%add title
% Add group n
annotation(gcf,'textbox',[nLoc15],'String',['n = ',num2str(height(upperheight))],'FitBoxToText','on','LineStyle','none','FontSize',14,'FontName','Arial','FontAngle','italic');
shg %show me the money
%% Scatterplot
