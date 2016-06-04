%%%%
% mean, variance data normalization
%%%%
function [ data ] = normalize_data(data)

mean_data = mean(data);
std_data  = std(data);

[n,d] = size(data);
for i=1:n
    data(i,:) = (data(i,:)-mean_data)./std_data;
end

end

