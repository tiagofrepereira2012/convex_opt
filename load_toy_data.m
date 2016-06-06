%%%%%%
% load_toy_data.m
% 
% Generate toy dataset normal distributed as the following
%
% class_1 positives = mu=[-0.5 -0.5]; sigma=[[1.00 0.0];[0.0 1.00]];
% class_1 negatives = mu=[1.75 1.75]; sigma=[[1.00 0];[0 1.00]];
%
% class_2 positives = mu=[1.00 1.00]; sigma=[[1.00 0.0];[0.0 1.00]];
% class_2 negatives = mu=[2.25 2.25]; sigma=[[1.00 0];[0 1.00]];
%
%
% @author Tiago de Freitas Pereira <tiago.pereira@idiap.ch>
% @date Thu  5 Jun 2016
%
%%%%%%
function [ data_train, labels_train, data_test, labels_test ] = load_toy_data()

n = 50;
rng default  % For reproducibilit

%Train set
mu_train_positive = [-0.5 -0.5];
sigma_train_positive = [[1.00 0.0];[0.0 1.00]];
data_train = mvnrnd(mu_train_positive,sigma_train_positive,n);
labels_train = ones(n,1);

mu_train_negative = [1.75 1.75];
sigma_train_negative = [[1.00 0];[0 1.00]];
data_train = [data_train;mvnrnd(mu_train_negative,sigma_train_negative,n)];
labels_train = [labels_train;ones(n,1) * -1];


%Devel set
mu_test_positive = [0.0 0.0];
sigma_test_positive = [[1.00 0.0];[0.0 1.00]];
data_test = mvnrnd(mu_test_positive,sigma_test_positive,n);
labels_test = ones(n,1);

mu_test_negative = [2. 2.];
sigma_test_negative = [[1.00 0.0];[0.0 1.00]];
data_test = [data_test;mvnrnd(mu_test_negative,sigma_test_negative,n)];
labels_test = [labels_test;ones(n,1) * -1];

    
end



