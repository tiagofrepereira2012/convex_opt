%%%%%%
% wine_analysis.m
% 
% Analysis using Wine dataset (https://archive.ics.uci.edu/ml/datasets/Wine)
%
% The Wine dataset has 150 data points split in 3 classes.
%
% 1) Alcohol 
% 2) Malic acid 
% 3) Ash 
% 4) Alcalinity of ash 
% 5) Magnesium 
% 6) Total phenols 
% 7) Flavanoids 
% 8) Nonflavanoid phenols 
% 9) Proanthocyanins 
% 10)Color intensity 
% 11)Hue 
% 12)OD280/OD315 of diluted wines 
% 13)Proline 
%
% @author Tiago de Freitas Pereira <tiago.pereira@idiap.ch>
% @date Thu  2 Jun 2016
%
%%%%%%
clear;

[data_train, labels_train, data_test, labels_test] = load_wine('./db/wine/wine.data');
[data_train, mean_data, std_data] = normalize_data(data_train);
data_test = bsxfun(@minus, data_test, mean_data); %normalizing test set
data_test = bsxfun(@rdivide, data_test, std_data);


C = [0.00001; 0.0001; 0.001;0.01;0.1;1;10;100; 1000; 10000]
[n,d] = size(C)

accuracy_train = [];
accuracy_test = [];
support_vectors_ratio = [];
for i=1:n
    [acc_train, acc_test, sv_ratio] = svm_multiclass(data_train, labels_train, data_test, labels_test, true, C(i));
    accuracy_train = [accuracy_train acc_train];
    accuracy_test = [accuracy_test acc_test];
    support_vectors_ratio = [support_vectors_ratio sv_ratio];
end

figure;
hold on;
title('(b)');

xlabel('C') % x-axis label
ylabel('Accuracy') % y-axis label

semilogx(C,accuracy_train,'MarkerFaceColor', 'b','LineWidth',2);
semilogx(C,accuracy_test,'MarkerFaceColor', 'g','LineWidth',2);
semilogx(C, support_vectors_ratio, 'LineStyle','--','LineWidth',2);

semilogx(C,accuracy_train,'o','LineWidth',2);
semilogx(C,accuracy_test,'o','LineWidth',2);
semilogx(C, support_vectors_ratio,'o','LineWidth',2);

legend('Accuracy Train set', 'Accuracy Test set', 'Support Vectors ratio');
grid on;
set(gca,'xscale','log');
hold off;







%accuracy_train, accuracy_test, support_vectors_ratio

