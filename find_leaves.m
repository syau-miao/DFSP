function [ clusters ] = find_leaves(points,start_point,stem_ids,c_knn,c_alpha,c_beta,show_debug)
%FIND_LEAVES 此处显示有关此函数的摘要
%   此处显示详细说明
all_ids=1:length(points);
leaf_ids=setdiff(all_ids,stem_ids);
if(isempty(leaf_ids))
  clusters{1}=stem_ids;
  return;
end
leaf_points=points(leaf_ids,:);
ns = createns(leaf_points,'NSMethod','kdtree');
[idx, dist] = knnsearch(ns,leaf_points,'k',c_knn);
idx(:,1)=[];
dist(:,1)=[];
dist=dist(:,end); 
radii=zeros(length(dist),1);
rad_=leaf_points-start_point;
rad_2=rad_.*rad_;
rad_3=sum(rad_2,2);
for i=1:length(dist)
  radii(i)=(1.0/rad_3(i)).^c_alpha;
end
dataset=leaf_points'; neigh=idx'-1; radii=radii';
[mc_result]=mccore(dataset,neigh,radii,c_beta,0.0);
[result]=quickshiftpp(dataset,neigh,radii,0.0,0.0,mc_result);
result=result+1;
cn=max(result);
clusters=cell(cn+1,1);
leaf_clusters=cell(cn,1);
clusters{1}=stem_ids;
for i=1:cn
   ids= result==i;
   clusters{i+1}=leaf_ids(ids);
end
for i=1:cn
   ids= result==i;
   leaf_clusters{i}=find(ids==1);
end
if(~show_debug)return;end
%%%%%%%%%%%%%%显示分割结果
g_c = ones(size(leaf_points)).*[1 1 1];
%color=rand(cn+1,3);
color=MyGS.MYCOLOR;
for i=1:length(leaf_clusters)
   ids=leaf_clusters{i};
   if(i<length(color))
   c_=color(i+1,:);  
   else
   c_=[rand(1,1) rand(1,1) rand(1,1)];    
   end
   c_m=repmat(c_,length(ids),1);
   g_c(ids,:)=c_m;  
end
pts_rgb = pointCloud(leaf_points,'Color',g_c);
figure;
pcshow(pts_rgb); 
axis off;camorbit(90,0,'camera');  view(0,0);
show_density(leaf_points,rad_3);
%%%%%%%%%%%%%%显示分割结果
g_c = ones(size(points)).*[1 1 1];
%color=rand(cn+1,3);
color=MyGS.MYCOLOR;
for i=1:length(clusters)
   ids=clusters{i};
   if(i<length(color))
   c_=color(i,:);  
   else
   c_=[rand(1,1) rand(1,1) rand(1,1)];    
   end
   c_m=repmat(c_,length(ids),1);
   g_c(ids,:)=c_m;  
end
pts_rgb = pointCloud(points,'Color',g_c);
figure;
pcshow(pts_rgb); 
axis off;camorbit(90,0,'camera');  view(0,0);

mc_result=mc_result+1;
cn=max(mc_result);
mc_clusters=cell(cn,1);
mc_clusters=cell(cn,1);
for i=1:cn
   ids= mc_result==i;
   mc_clusters{i}=find(ids==1);
end
g_c = ones(size(leaf_points)).*[0 0 0];
%color=rand(cn+1,3);
color=MyGS.MYCOLOR;
for i=1:length(mc_clusters)
   ids=mc_clusters{i};
   if(i<length(color))
   c_=color(i+1,:);  
   else
   c_=[rand(1,1) rand(1,1) rand(1,1)];    
   end
   c_m=repmat(c_,length(ids),1);
   g_c(ids,:)=c_m;  
end
pts_rgb = pointCloud(leaf_points,'Color',g_c);
figure;
pcshow(pts_rgb); 
axis off;camorbit(90,0,'camera');  view(0,0);


end

