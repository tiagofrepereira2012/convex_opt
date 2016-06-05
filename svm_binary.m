%%%%%%
% svm_binary.m
% 
% @author Tiago de Freitas Pereira <tiago.pereira@idiap.ch>
% @date Thu  2 Jun 2016
%
%%%%%%
function [accuracy_train, accuracy_test, support_vectors_ratio] = svm_binary(data_train, labels_train, data_test, labels_test, soft, C)

    epsilon = 0.000001;
    [n_train,d] = size(data_train);
    [n_test,d] = size(data_test);

    data_train = normalize_data(data_train);
    data_test = normalize_data(data_test);

    [w,b, lambda] = svm_train(data_train, labels_train, soft, C);
    y_train = svm_scoring(w,b,data_train); %scoring
    y_test  = svm_scoring(w,b,data_test); %scoring

        
    predictions_train = ones(n_train,1);    
    index_negatives = find(y_train<0);
    predictions_train(index_negatives) = -1;
    
    predictions_test = ones(n_test,1);
    index_negatives = find(y_test<0);
    predictions_test(index_negatives) = -1;

    
    accuracy_train = sum(labels_train == predictions_train) / n_train;
    accuracy_test = sum(labels_test == predictions_test) / n_test;
    support_vectors_ratio = sum(lambda>epsilon)/ n_train; %Ratio of the average (support vector)
    
    
end
    


