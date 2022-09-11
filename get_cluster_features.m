function [cluster_features ] = get_cluster_features(pts_,clusters,knn)
%GETORGANFEATURES 此处显示有关此函数的摘要
%   此处显示详细说明
    kdtreeobj= KDTreeSearcher(pts_,'distance','euclidean');
    [adj_,dis_] = knnsearch(pts_,pts_,'dist','euclidean','k',knn+1);
    cluster_features=zeros(length(clusters),3);
    for i=1:length(clusters)
      ids=clusters{i};
      num=0;
      features=[0 0 0];
      for j=1:length(ids)
        id=ids(j);  
        indices=adj_(id,:);  
        n_pts=pts_(indices,:);
        [COEFF, ~,SCORE]= pca(n_pts,'Algorithm','eig');
       % if(length(SCORE)==3)
        features=features+[SCORE(3)/sum(SCORE) (SCORE(1)-SCORE(2))/SCORE(1) 0];
        num=num+1;
       % end  
      end
      cluster_features(i,:)=features./num;
    end
%   figure('Name','debug_local_feature','NumberTitle','off');set(gcf,'color','white');movegui('southwest');
% cla;
% scatter3(points(:,1),points(:,2),points(:,3),5,pt_features, 'filled');
% camorbit(90,0,'camera');  view(0,0);view3d ZOOM;axis on; axis equal;axis vis3d;
end

