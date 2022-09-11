function [ stem_ids ] = median_seg_align( seed_pt,points,z_t,s_r)
%SEG_STEM 此处显示有关此函数的摘要
%   此处显示详细说明
   kdtreeobj= KDTreeSearcher(points,'distance','euclidean');
   stem_ids=[];
   is_seg=zeros(length(points),1);
   pre_dir=[0 0 0];
   iter_num=0;
   while(true)
      if(seed_pt(3)>z_t)
         break;
      end
      [adj,~] =rangesearch(kdtreeobj,seed_pt,s_r);%%%adj_为sort_leaf的索引
      adj=adj{1};
      nn_adj=adj(is_seg(adj)==0); %%nn_adj为sort_leaf索引  
      if(isempty(nn_adj))
          dir=[0 0 1];
          seed_pt=seed_pt+s_r*dir;
          continue;
      end
      nn_pts=points(nn_adj,:);
      dirs=nn_pts-seed_pt;
      norm_=sum(abs(dirs).^2,2).^(1/2);
      dirs=dirs./norm_;
      med_x=median(dirs(:,1)); med_y=median(dirs(:,2));med_z=median(dirs(:,3));
      dir=[med_x med_y med_z]; 
      if(norm(dir)~=0)dir=dir./norm(dir);end
      dir=0.2*dir+0.8*pre_dir;  dir=dir./norm(dir);
      pre_dir=dir;
      seed_pt=seed_pt+s_r*dir;
      stem_ids=[stem_ids;nn_adj'];   
      is_seg(nn_adj)=1; 
      iter_num=iter_num+1;
      if(iter_num>50)break;end
   end
   
end

