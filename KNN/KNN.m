clear;
clc;
K=3;
trainData = [4.0, 2.0;
             2.0, 4.0;
             2.0, 3.0;
             9.0, 11.0;
             9.0, 8.0;
             10.0, 8.0];
trainClass = [0, 0, 0, 1, 1, 1];
testData = [5, 4;
            9, 10];

% [y1, y2, w]=LDA(trainData(1:3,:)', trainData(4:6,:)');
% disp('LDA降维w：');
% disp(w)
% trainData_LDA = [y1,y2];
% testData_LDA = w'*testData';
% disp('LDA降维后的训练样本：');
% disp(trainData_LDA)
% disp('LDA降维后的测试样本：');
% disp(testData_LDA)

[y, v, x_mean]=PCA(trainData);
disp('PCA降维所使用v：');
disp(v)
trainData_PCA = y;
testData_PCA = v*(testData-x_mean)';
disp('PCA降维后的训练样本：');
disp(trainData_PCA)
disp('PCA降维后的测试样本：');
disp(testData_PCA)


[N_test, M_test]=size(testData_PCA);
[N_train, M_train]=size(trainData_PCA);
%计算训练数据集与测试数据之间的欧氏距离dist
dist=zeros(M_train,M_test);
for i=1:M_test
    for j=1:M_train
        dist(j,i)=norm(trainData_PCA(j)-testData_PCA(i));
    end
end
for i=1:M_test
    %将dist从小到大进行排序
    [Y,I]=sort(dist(:,i),1);
    %将训练数据对应的类别与训练数据排序结果对应
    trainClass_=trainClass(I);
    %确定前K个点所在类别的出现频率
    classNum=length(unique(trainClass_));%取集合中的单值元素的个数
    labels=zeros(1,classNum);
    for j=1:K
        class=trainClass_(j);
        labels(class+1)=labels(class+1)+1;
    end
    %返回前K个点中出现频率最高的类别作为测试数据的预测分类
    [~,idx]=max(labels);
    fprintf('测试数据%d属于类 %d\n',i,idx-1);
end
