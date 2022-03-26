function [y1, y2, w] = LDA(x1, x2)
% 列为样本， 行为特征
% 求均值
u1 = mean(x1,2);
u2 = mean(x2,2);
% 求散列矩阵
s1 = (x1-u1)*(x1-u1)';
s2 = (x2-u2)*(x2-u2)';
% 类内散度矩阵
Sw = s1+s2;
w = Sw\(u1-u2);
y1 = w'* x1;
y2 = w'* x2;

end