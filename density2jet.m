function [ jet ] = density2jet( density )
%DENSITY2JET �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
     num=length(density); 
     [~,ids]=sort(density);
     jet=zeros(1,num);
     for i=1:num
        id=ids(i);
        jet(id)=i;
     end
end

