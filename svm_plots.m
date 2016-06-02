%%%%%%
% svm_plots.m
% 
% @author Tiago de Freitas Pereira <tiago.pereira@idiap.ch>
% @date Thu  2 Jun 2016
%
% This code trains an SVM for a binary classification given a 2d data matrix 
% and the labels.
% Also it plots the data with the decision boundary enhancing the support
% vectors
% ** Parameters
%   data: nx2 matrix with the data points
%   labels: nx2 matrix with the lables (eithe 1 or -1)
%   C: Value of the regularization constant C
%   soft: It defines the implementation t`rue `is soft margins, `false` is
%   hard margins
%%%%%%
function svm_plots(data, labels, soft, C)

[n,dim] = size(data);

if(soft)
  %Training the SVM with soft margins
  cvx_begin
      variables w(dim) b slack(n); %3 VARIABLES: The coordenates of the margins, 
      %the bias and the slack variables correspondent to each 
      dual variable y; %The dual variables will give the support vectors
      minimize(0.5*w'*w + C*sum(slack)) 
      subject to 
  	    y: labels.*(data*w+b) > 1 - slack; %Constraint
        slack > 0;
  cvx_end
else
  %Training the SVM with HARD margins
  cvx_begin
      variables w(dim) b; %2 VARIABLES: The coordenates of the margins AND 
      %the bias
      dual variable y; %The dual variables will give the support vectors
      minimize(0.5*w'*w) 
      subject to 
  	    y: labels.*(data*w+b) > 1; %Constraint        
  cvx_end
    
end
    
% Plot the data points fro the two classes
pos = find(labels == 1);
neg = find(labels == -1);
plot(data(pos,1), data(pos,2), 'ko', 'MarkerFaceColor', 'b'); hold on;
plot(data(neg,1), data(neg,2), 'ko', 'MarkerFaceColor', 'g')

%Plotting the Lagrange multipliers greaters than zero (epsilon)
epsilon = 0.000001;
for i=1:n
    if(y(i) > epsilon)
        viscircles([data(i,1),data(i,2)],0.1, 'LineStyle','--')
    end
end

% Plotting decision boundary and the support vectors
% Threshold 0 and support vectors +1 and -1
limits = [-10 10];
x_lin             = limits(1):0.5:limits(2);
decision_boundary = (-b - w(1).*x_lin)/w(2);
support_vector_1  = (+1 -b - w(1).*x_lin)/w(2);
support_vector_2  = (-1 -b - w(1).*x_lin)/w(2);
plot(x_lin, decision_boundary);
plot(x_lin, support_vector_1, 'LineStyle','--');
plot(x_lin, support_vector_2, 'LineStyle','--');
xlim([-0.5, 5])

