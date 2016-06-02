function [ data, labels ] = load_twofeature(filename)

fileID = fopen(filename);

formatSpec = '%d %*d:%f %*d:%f';
C = textscan(fileID,formatSpec,'Delimiter','\n','CollectOutput', true);

labels = double(C{1});
data = double(C{2});
end

