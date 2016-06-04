function [ data_train, labels_train, data_test, labels_test ] = load_letter(filename)

percentage_train = 0.75;
fileID = fopen(filename);

possible_labels = {'A'};
for i=66:66+24
    possible_labels(i-64) = {char(i)};
end
possible_labels = possible_labels';
[n,d] = size(possible_labels);

formatSpec = '%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
%formatSpec = '%s,%n,%n,%n,%n,%n,%n,%n,%n,%n,%n,%n,%n,%n,%n,%n,%n';
%              T , 2, 8, 3, 5, 1, 8,13, 0, 6, 6, 10,8,0 ,8 , 0,8
C = textscan(fileID,formatSpec,'delimiter',',');
data = [C{2},C{3},C{4},C{5},C{6},C{7},C{8},C{9},C{10},C{11},C{12},C{13},C{14},C{15},C{16}];
%data = csvread(filename,0,1);
raw_labels = C{1};
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



