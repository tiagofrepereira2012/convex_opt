%%%%%%
% svm_multiclass.m
% 
%
% Implements the multiclass SVM in the same fashion as in Bishop's book, chapter 7.1.3.
%
% For a classification task with K classes, K separate binary SVMs are
% contructed in which the kth model yk(x) is trained using the data from 
% class Ck as the positive examples and the data from the remaining K ? 1 
% classes as the negative examples (one-versus-the-rest approach).
%
% The final decision is made by taking:
% y(x) = max yk (x).
%
% @author Tiago de Freitas Pereira <tiago.pereira@idiap.ch>
% @date Thu  2 Jun 2016
%
%%%%%%
function [accuracy_train, accuracy_test, support_vectors_ratio] = svm_multiclass(data_train, labels_train, data_test, labels_test, soft, C)

    epsilon = 0.000001;
    n_classes = max(labels_train);
    [n_train,d] = size(data_train);
    [n_test,d] = size(data_test);

    Y_train = [];
    Y_test = [];
    LAMBDA = [];
    data_train = normalize_data(data_train);
    data_test = normalize_data(data_test);
    %Creating svms for each class
    for i=1:n_classes
        svm_labels = convert_svm_labels(labels_train, i);
        [w,b, lambda] = svm_train(data_train, svm_labels, soft, C);
        y_train = svm_scoring(w,b,data_train); %scoring
        y_test  = svm_scoring(w,b,data_test); %scoring
        Y_train = [Y_train, y_train];
        Y_test = [Y_test, y_test];
        LAMBDA = [LAMBDA sum(lambda>epsilon)];
    end
    
    [argvalue, predictions_train] = max(Y_train,[],2);
    [argvalue, predictions_test] = max(Y_test,[],2);
    
    accuracy_train = sum(labels_train == predictions_train) / n_train;
    accuracy_test = sum(labels_test == predictions_test) / n_test;
    support_vectors_ratio = (sum(LAMBDA) / n_classes) / n_train; %Ratio of the average (support vector)
    
    
end
    


