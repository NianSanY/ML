function [y,v_2,x_mean] = PCA(x)
% clc,clear
% x = [1,1,2,4,2;1,3,3,4,4]';
% 中心化
x_mean=mean(x,1);
x=x-x_mean;
%协方差矩阵
M=cov(x);
[v, ~] = eig(M); % W是特征向量组成的矩阵（4×4），一列为一个特征向量
% 取第二个特征
v_2=v(:,2)';
y = v_2*x';

end
