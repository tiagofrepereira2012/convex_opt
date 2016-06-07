%%%%%%
% svm_scoring.m
% 
% @author Tiago de Freitas Pereira <tiago.pereira@idiap.ch>
% @date Thu  2 Jun 2016
%
%%%%%%
function y = svm_scoring(w,b,x)
   y = x*w + b;
end
    


