clear all;
close all;
%%%%%%%%%%%%%%read ply%%%%%%%%%%%%%%%%
[filename,pathname] = uigetfile('.ply','Select the ply point cloud file');  
if(filename==0)
   return; 
end
Points=pcread([pathname filename]);
Points=double(Points.Location);
points=Points(:,1:3);
Parameters.f_knn=64;
Parameters.c_knn1=32;
Parameters.c_beta1=0.85;
Parameters.c_alpha1=5;  
Parameters.c_knn2=32;
Parameters.c_beta2=0.85;
Parameters.c_alpha2=9;
%%this parameter can adjust the radius of the stem
Parameters.r_scale=1.0;
%%parameter gama in paper;  
%%this parameter can adjust the length of the stem
Parameters.z_t=0.3; 
pointlabel=sl_seg(points,Parameters,true);
ptCloud=pointCloud(pointlabel(:,1:3),'Intensity',pointlabel(:,4));
pcwrite(ptCloud,[pathname 'seg_' filename]);
