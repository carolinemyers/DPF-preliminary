function [] = setText(location,accuracy)
%UNTITLED24 Summary of this function goes here
%   Detailed explanation goes here
label = [num2str(accuracy,3)];
t = text(location,accuracy,label);
s = t.BackgroundColor;
t.BackgroundColor = 'w';
s = t.EdgeColor;
t.EdgeColor = 'k';
s = t.FontSize;
t.FontSize = 8;


end

