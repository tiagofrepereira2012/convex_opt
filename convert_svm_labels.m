%%%%
% Converting multiclass labels for the binary class SVM (1/-1)
%%%%
function [ svm_labels ] = convert_svm_labels(labels, target_label)
[n,d] = size(labels);

svm_labels = zeros(n,1);

indexes = find(labels==target_label);
svm_labels(indexes) = 1;

indexes = find(labels~=target_label);
svm_labels(indexes) = -1;


end

