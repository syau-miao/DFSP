function [ output_args ] = show_density( points,density )
%SHOW_DENSITY 此处显示有关此函数的摘要
%   此处显示详细说明
   figure('Name','show_density','NumberTitle','off');set(gcf,'color','white');movegui('southwest');
   jet_id=density2jet(density);
   XX=jet(length(points));  
   scatter3(points(:,1),points(:,2),points(:,3),2,XX(jet_id,:), 'filled'); 
    %scatter3(points(:,1),points(:,2),points(:,3),5,[density' density' density'], 'filled'); 
   %hold on;
  %  scatter3(mp(:,1),mp(:,2),mp(:,3),50,[1 0 0], 'filled'); 
   camorbit(90,0,'camera');  view(0,0);
  axis off; axis equal;  camzoom(0.5);camorbit(0,0,'camera'); axis vis3d; view(180,0);view3d ZOOM;
end

