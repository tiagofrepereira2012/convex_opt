%%%%%%
% svm_train.m
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
function [w,b,alpha] = svm_train(x, t, soft, C)

[n,dim] = size(x);

if(soft)
  %Training the SVM with soft margins
  cvx_begin
      variables w(dim) b slack(n); %3 VARIABLES: The coordenates of the margins, 
      %the bias and the slack variables correspondent to each 
      dual variable alpha; %The dual variables will give the support vectors
      minimize(0.5*w'*w + C*sum(slack));
      subject to 
  	    alpha: t.*(x*w+b) > 1 - slack; %Constraint
        slack > 0;
  cvx_end
else
  %Training the SVM with HARD margins
  cvx_begin
      variables w(dim) b; %2 VARIABLES: The coordenates of the margins AND 
      %the bias
      dual variable alpha; %The dual variables will give the support vectors
      minimize(0.5*w'*w);
      subject to 
  	    alpha: t.*(x*w+b) > 1; %Constraint        
  cvx_end
    
end
    


