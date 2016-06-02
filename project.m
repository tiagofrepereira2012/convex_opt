%%%%%%
% project.m
% 
% @author Tiago de Freitas Pereira <tiago.pereira@idiap.ch>
% @date Thu  2 Jun 2016
%
%%%%%%
clear;

C = [0.0001 0.001 0.01 0.01 0.1 1 10 100 1000];

figure;
hold on;
title('Perfect separation');
[data, labels] = load_twofeature('twofeature_perfect.txt');
for i=1:9
  subplot(3,3,i);
  if(i==1)
    svm_plots(data, labels, 0, false);
    title('Hard margin (margins = 1)');
  else
    svm_plots(data, labels, C(i), true);
    title(strcat('Soft margin (C=',num2str(C(i)),')'));
  end
end
hold off;



figure;
hold on;
title('Problem with noise');
[data, labels] = load_twofeature('twofeature.txt');
for i=1:9
  subplot(3,3,i);
  if(i==1)
    svm_plots(data, labels, false, 0);
    title('Hard margin (margins = 1)');
  else
    svm_plots(data, labels, true, C(i));
    title(strcat('Soft margin (C=',num2str(C(i)),')'));
  end
end
hold off;
