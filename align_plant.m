function [ points,start_point ] = align_plant(points,start_point,tip_points)
%ALIGN_PLANT 此处显示有关此函数的摘要
%   此处显示详细说明
dirs=tip_points-start_point;
dir_2=dirs.*dirs;
dir_3=sqrt(sum(dir_2,2));
dirs=dirs./dir_3;
direction=mean(dirs,1);
xyz0=start_point;
if(isempty(dirs))
 direction=[0 0 1];   
end
XYZ_Axis= find_AxisByPrincipalDir_mt(points,direction,xyz0,0);
points = Transfer_XYZ2AXIS_mt([points;start_point],XYZ_Axis);
start_point=points(end,:);
start_point=[0.01 0.01 0.01];
points(end,:)=[];
end

