close all;
[filename,pathname] = uigetfile('.ply','Select the ply point cloud file');  
if(filename==0)
   return; 
end
Points=pcread([pathname filename]);
count=-1;
grid=6;
tic;
 while(count<15000)
   ptCloudAve = pcdownsample(Points, 'gridAverage', grid);
   count=ptCloudAve.Count;
   if(count>15000)
     sample=fps(ptCloudAve.Location,15000);
     ptCloudA=pointCloud(sample);
     break;
   end
   grid=grid-1;
   if(grid==0)
     sample=fps(ptCloudAve.Location,15000);
     ptCloudA=pointCloud(sample);
     break;
   end
 end 
toc;
pcwrite(ptCloudA,'paper.ply');


%%%%%%%%%%only use fps
% tic;
% sample=fps(Points.Location,15000);
% ptCloudA=pointCloud(sample);
% pcwrite(ptCloudA,'fps.ply');
% toc;
  