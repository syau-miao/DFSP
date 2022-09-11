function [ samplePC ] = fps( Data, pointNum )
%FPS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%ʹ��FPS�����в���
tic
%pointNum = 5000;
n = size(Data,1);
idx = randperm(n,1);
samplePC = Data(idx,:);
Data(idx,:) = [];       %ɾ���õ�
 %��ȡ�㵽�㼯�ľ��룬�������ڶ�����
sampleKD = KDTreeSearcher(samplePC);        %����һ��kdtree
[~,dist] = knnsearch(sampleKD,Data,'K',1);
[~,maxIndex] = max(dist);
samplePC = [samplePC;Data(maxIndex,:)];
Data(maxIndex,:) = [];
dist(maxIndex) = [];        %ɾ���þ���
for i=1:pointNum-2
    endPoint = samplePC(end,:);
    diff = endPoint - Data;     %������һ����������ʣ���֮��ľ���
    lastDist = sqrt(sum(diff.^2,2));
    dist(dist>lastDist) = lastDist(dist>lastDist);
    [~,maxIndex] = max(dist);
    samplePC = [samplePC;Data(maxIndex,:)];
    Data(maxIndex,:) = [];
    dist(maxIndex) = [];        %ɾ���þ���
end
toc
end

