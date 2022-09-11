function [ samplePC ] = fps( Data, pointNum )
%FPS 此处显示有关此函数的摘要
%   此处显示详细说明
%使用FPS来进行采样
tic
%pointNum = 5000;
n = size(Data,1);
idx = randperm(n,1);
samplePC = Data(idx,:);
Data(idx,:) = [];       %删除该点
 %获取点到点集的距离，并采样第二个点
sampleKD = KDTreeSearcher(samplePC);        %创建一个kdtree
[~,dist] = knnsearch(sampleKD,Data,'K',1);
[~,maxIndex] = max(dist);
samplePC = [samplePC;Data(maxIndex,:)];
Data(maxIndex,:) = [];
dist(maxIndex) = [];        %删除该距离
for i=1:pointNum-2
    endPoint = samplePC(end,:);
    diff = endPoint - Data;     %计算上一个采样点与剩余点之间的距离
    lastDist = sqrt(sum(diff.^2,2));
    dist(dist>lastDist) = lastDist(dist>lastDist);
    [~,maxIndex] = max(dist);
    samplePC = [samplePC;Data(maxIndex,:)];
    Data(maxIndex,:) = [];
    dist(maxIndex) = [];        %删除该距离
end
toc
end

