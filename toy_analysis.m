%%%%%%
% toy_analysis.m
% 
% Example of a Binary class SVM with a toy dataset
% This toy dataset is normal distributed as the following
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
clear;

[ data_train, labels_train, data_test, labels_test ] = load_toy_data();

[data_train, mean_data, std_data] = normalize_data(data_train);
data_test = bsxfun(@minus, data_test, mean_data); %normalizing test set
data_test = bsxfun(@rdivide, data_test, std_data);
%data_test = data(i,:) = (data(i,:)-mean_data)./std_data;



C      = [0.0001; 0.001;0.01;0.1;1;10;100; 1000; 10000];
C_plot = [0.001;0.01;0.1;1;10;100];
[n_C,d] = size(C);
[n_C_plot,d] = size(C_plot);
[n, d] = size(data_train);
half_n = n / 2;

figure;
hold on;
pos = find(labels_train == 1);
neg = find(labels_train == -1);
pos_test = find(labels_test == 1);
neg_test = find(labels_test == -1);

for i=1:n_C_plot
    subplot(3,2,i);
    plot(data_train(pos,1), data_train(pos,2), 'b.', 'MarkerFaceColor', 'b',  'MarkerSize',20); hold on;
    plot(data_train(neg,1), data_train(neg,2), 'r.', 'MarkerFaceColor', 'r',  'MarkerSize',20);

    %plot(data_test(pos_test,1), data_test(pos_test,2), 'b*', 'MarkerFaceColor', 'b');
    %plot(data_test(neg_test,1), data_test(neg_test,2), 'r*', 'MarkerFaceColor', 'r');
    title(strcat('C=',num2str(C_plot(i))));

    %training SVM
    [w,b,y] = svm_train(data_train, labels_train, true, C_plot(i));
    
    %Plotting the Lagrange multipliers greaters than zero (epsilon)
    epsilon = 0.000001;
    for j=1:n
        if(y(j) > epsilon)
            %viscircles([data_train(j,1),data_train(j,2)],0.1, 'LineStyle','--')
            if(labels_train(j) == 1)
              plot(data_train(j,1), data_train(j,2), 'b*', 'MarkerFaceColor', 'b',  'MarkerSize',7); hold on;
            else
              plot(data_train(j,1), data_train(j,2), 'r*', 'MarkerFaceColor', 'r',  'MarkerSize',7);hold on;
            end
        end
    end
    xlim([-4 4]);
    ylim([-4 4]);

    %Plotting decision boundary
    % Threshold 0 and support vectors +1 and -1
    limits = [-10 10];
    x_lin             = limits(1):0.5:limits(2);    
    decision_boundary = (-b - w(1).*x_lin)/w(2);
    support_vector_1  = (+1 -b - w(1).*x_lin)/w(2);
    support_vector_2  = (-1 -b - w(1).*x_lin)/w(2);
    plot(x_lin, decision_boundary);
    plot(x_lin, support_vector_1, 'LineStyle','--');
    plot(x_lin, support_vector_2, 'LineStyle','--');

end

hold off;



accuracy_train = [];
accuracy_test = [];
support_vectors_ratio = [];
for i=1:n_C
    [acc_train, acc_test, sv_ratio] = svm_binary(data_train, labels_train, data_test, labels_test, true, C(i));
    accuracy_train = [accuracy_train acc_train];
    accuracy_test = [accuracy_test acc_test];
    support_vectors_ratio = [support_vectors_ratio sv_ratio];
end

figure;
hold on;
title('Accuracy and Support Vectors Ratio vs C');

xlabel('C') % x-axis label
ylabel('Accuracy') % y-axis label

semilogx(C,accuracy_train,'MarkerFaceColor', 'b','LineWidth',2);
%semilogx(C,accuracy_test,'MarkerFaceColor', 'g','LineWidth',2);
semilogx(C, support_vectors_ratio, 'LineStyle','--','LineWidth',2);

semilogx(C,accuracy_train,'o','LineWidth',2);
%semilogx(C,accuracy_test,'o','LineWidth',2);
semilogx(C, support_vectors_ratio,'o','LineWidth',2);

%legend('Accuracy Train set', 'Accuracy Test set', 'Support Vectors ratio');
legend('Accuracy Train set', 'Support Vectors ratio');
grid on;
set(gca,'xscale','log');
hold off;


