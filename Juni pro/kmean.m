function [data] = kmean(x,C)
% Calculate k-means for x with C number of centroids
train.kmeans.x = cell(size(x,1),1);
train.kmeans.esql = cell(size(x,1),1);
train.kmeans.j = cell(size(x,1),1);
for i = 1:size(x,1)
[train.kmeans.j{i} train.kmeans.x{i}] = kmeans(x{i}(:,1:12),C);
end
data = train.kmeans.x;