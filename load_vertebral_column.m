function [ data_train, labels_train, data_test, labels_test ] = load_vertebral_column(filename)

percentage_train = 0.75;
fileID = fopen(filename);

possible_labels = {'AB';'NO'};
[n,d] = size(possible_labels);

formatSpec = '%f%f%f%f%f%f%s';
C = textscan(fileID,formatSpec,'delimiter',' ');

data = [C{1},C{2},C{3},C{4},C{5},C{6}];
raw_labels = C{7};
labels = zeros(n,1);

data_train = []; labels_train = [];
data_test  = []; labels_test = [];

[n_data,d] = size(data);

for i=1:n
    indexes = strmatch(possible_labels(i), raw_labels);    
    [n_i, d] = size(indexes);
    labels(indexes) = ones(n_i,1)*i;
        
    n_train = floor(n_i * percentage_train);
    n_test = n_i - n_train;
    
    temp = data(indexes,:);
    data_train = [data_train;temp(1:n_train,:)];
    data_test  = [data_test;temp(n_train:n_train+n_test,:)];
    
    temp = labels(indexes);
    labels_train = [labels_train;temp(1:n_train,:)];
    labels_test = [labels_test;temp(n_train:n_train+n_test,:)] ;
    
end



