function [start_point,s_r,tip_points] = find_stem_bottom_pt(points,f_knn,c_knn,c_alpha,c_beta,c_min,isAlign,show_debug)
%FIND_STEM_BOTTOMPT 此处显示有关此函数的摘要
%此处显示详细说明
if(isAlign)
   minz= min(points(:,3));  maxz=max(points(:,3)); 
   height=maxz-minz;   zt=minz+0.05*height;
   ids1= find(points(:,3)<zt);
   start_point=median(points(ids1,:),1);
   s_r=points(ids1,:)-start_point;
   s_r=s_r.*s_r;
   s_r=median(sqrt(sum(s_r,2)));
   tip_points=[];
   %%%%可视化
   g_c = ones(size(points)).*[0 0 0];
   c_=[1 0 0];
   c_m=repmat(c_,length(ids1),1);
   g_c(ids1,:)=c_m;  
   pts_rgb = pointCloud(points,'Color',g_c);
   figure;
   pcshow(pts_rgb); 
   return; 
end
%%%%%%%%%%%%%%%%%find the end regions of the organs%%%%%%%%%%%%%%%%
startPoint=mean(points,1);
ns = createns(points,'NSMethod','kdtree');
[idx, dist] = knnsearch(ns,points,'k',c_knn);
idx(:,1)=[];
dist(:,1)=[];
dist=dist(:,end); 
radii=zeros(length(dist),1);
rad_=points-startPoint;
rad_2=rad_.*rad_;
rad_3=sum(rad_2,2);
for i=1:length(dist)
  radii(i)=(1.0/rad_3(i)).^c_alpha;
end
dataset=points'; neigh=idx'-1; radii=radii';
[result]=mccore(dataset,neigh,radii,c_beta,0.0);
result=result+1;
cn=max(result);
mcnum=length(find(result>0));
avenum=mcnum/cn;
if(c_min>avenum)c_min=avenum;end
clusters=cell(0,1);
for i=1:cn
   ids=find(result==i);
   if(length(ids)<c_min)continue;end
   clusters{end+1}=ids;
end

cn=length(clusters);
tip_points=zeros(cn,3);
for i=1:cn
   tpts=points(clusters{i},:); 
   tip_points(i,:)=median(tpts,1);
end
%%%%%%%%%%%%%%find the bottom points of the stem
[cluster_features]=get_cluster_features(points,clusters,f_knn);
[~,min_id]=max(cluster_features(:,1).^1./cluster_features(:,2).^(1));
tip_points(min_id,:)=[];
bpts=points(clusters{min_id},:);
start_point=median(bpts,1);
s_r=bpts-start_point;
s_r=s_r.*s_r;
s_r=max(sqrt(sum(s_r,2)));
if(s_r==0)
   rad_3(rad_3==0)=inf;
   s_r=min(rad_3);
end

%%%%%%%%show results
if(~show_debug)return;end
show_density( points,1.0./radii);
g_c = ones(size(points)).*[0 0 0];
%color=rand(cn+1,3);
color=MyGS.MYCOLOR;
for i=1:length(clusters)
   ids=clusters{i};
   c_=cluster_features(i,:);
   if(i==min_id)
       c_=[1 0 0];
   else
      c_=[rand(1,1) rand(1,1) rand(1,1) ];
   end
   c_m=repmat(c_,length(ids),1);
   g_c(ids,:)=c_m;  
end
pts_rgb = pointCloud(points,'Color',g_c);
figure;
%showLine( xyz0,direction);
pcshow(pts_rgb); 
 axis off;
end

