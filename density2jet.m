function [ jet ] = density2jet( density )
%DENSITY2JET 此处显示有关此函数的摘要
%   此处显示详细说明
     num=length(density); 
     [~,ids]=sort(density);
     jet=zeros(1,num);
     for i=1:num
        id=ids(i);
        jet(id)=i;
     end
end

