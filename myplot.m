function [fig,h1,h2] = myplot(var1,var2)



[RVal,PVal] = corrcoef(var1,var2); 
RValue = RVal(1,2);
PValue = PVal(1,2);
fig = figure

h1 = scatter(var1,var2,'k');
%gca.title = 'XXX';
RLine = lsline(gca);%add best fit
set(RLine,'LineWidth',1.2,'Color',[65/255 105/255 225/255]);%royal bue
hold on
xLabel = num2str(var1);
yLabel = num2str(var2);
  %set('yLim', num2str(var2));

str1=[' R = ',num2str(RValue)];%R value converted to string to place on fig
T1 = text(min(get(gca,'xlim')), max(get(gca,'ylim')), str1); %get axes to place text
set(T1,'verticalalignment','top','horizontalalignment','left','LineStyle','none','FontSize',11,'FontName','Arial','FontAngle','italic');%set text location

str2=[' P = ',num2str(PValue)];%R value converted to string to place on fig
T2 = text(max(get(gca,'xlim')), max(get(gca,'ylim')), str2); %get axes to place text
set(T2,'verticalalignment','top','horizontalalignment','right','LineStyle','none','FontSize',11,'FontName','Arial','FontAngle','italic');%set text location

txt1 = [num2str(var1)];
txt2 = [num2str(var2)];


hold on
ax_handle.XLabel = ([txt1])
ax_handle.YLabel = ([txt2])
  
%myplot(allCleanedData.age,allCleanedData.heightininches)
fig = gcf
end