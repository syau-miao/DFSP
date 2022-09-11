function [ points_label ] = sl_seg(points,Parameters,show_debug)
%SL_SEG 此处显示有关此函数的摘要
%   此处显示详细说明
spoints=points;
labels=zeros(length(points),1);
isAlign=false;
f_knn=Parameters.f_knn;
c_knn=Parameters.c_knn1;
c_beta=Parameters.c_beta1;
c_alpha=Parameters.c_alpha1;
r_scale=Parameters.r_scale;
z_t=Parameters.z_t;
c_min_pt_num=10;
[start_point, s_r,tip_points] = find_stem_bottom_pt(points,f_knn,c_knn,c_alpha,c_beta,c_min_pt_num,isAlign,show_debug);
if(~isAlign)
[points,start_point]=align_plant(points,start_point,tip_points);
end
[stem_ids] = find_stem(points,start_point,z_t,r_scale*s_r,show_debug); 
c_knn=Parameters.c_knn2;
c_beta=Parameters.c_beta2;
c_alpha=Parameters.c_alpha2;
clusters=find_leaves(points,start_point,stem_ids,c_knn,c_alpha,c_beta,show_debug); 
for i=1:length(clusters)
  ids=clusters{i};
  labels(ids)=i;
end
points_label=[points labels];

end

