function [ ids1] = find_stem(points, startPoint,t_ratio,s_r,show_debug)
%FIND_STEM 此处显示有关此函数的摘要
%   此处显示详细说明
   minz= min(points(:,3));  maxz=max(points(:,3)); 
   height=maxz-minz;  
   zt=minz+t_ratio*height;
   ids1=median_seg_align(startPoint,points,zt,s_r);
 if(~show_debug)return;end
 figure('Name','debug_stems','NumberTitle','off');set(gcf,'color','white');movegui('southwest');
 cla;
 scatter3(points(:,1),points(:,2),points(:,3),2,[0 0 0], 'filled');
 hold on;
 hold on;
 camorbit(90,0,'camera');  view(0,0);

view3d ZOOM;axis off; axis equal;axis vis3d;
end

