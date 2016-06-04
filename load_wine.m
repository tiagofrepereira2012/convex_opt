function [ data_train, labels_train, data_test, labels_test ] = load_wine(filename)

percentage_train = 0.75;
fileID = fopen(filename);

%possible_labels = {'Iris-virginica';'Iris-setosa';'Iris-versicolor'};
%[n,d] = size(possible_labels);
n = 3;

               
formatSpec = '%n%f%f%f%f%f%f%f%f%f%f%f%f%f';
C = textscan(fileID,formatSpec,'delimiter',',');

data = [C{2},C{3},C{4},C{5},C{6},C{7},C{8},C{9},C{10},C{11},C{12},C{13},C{14}];
labels = C{1};

data_train = []; labels_train = [];
data_test  = []; labels_test = [];

[n_data,d] = size(data);

for i=1:n
    indexes = find(labels == i);
    [n_i, d] = size(indexes);
        
    n_train = floor(n_i * percentage_train);
    n_test = n_i - n_train;
    
    temp = data(indexes,:);
    data_train = [data_train;temp(1:n_train,:)];
    data_test  = [data_test;temp(n_train:n_train+n_test,:)];
    
    temp = labels(indexes);
    labels_train = [labels_train;temp(1:n_train,:)];
    labels_test = [labels_test;temp(n_train:n_train+n_test,:)] ;
    
end



