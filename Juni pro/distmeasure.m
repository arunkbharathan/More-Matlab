function [result,index] = distmeasure(x,y)
result = cell(size(x,1),1);
dist = cell(size(x,1),1);
mins = inf;
for i = 1:size(x,1)
dist{i} = disteusq(x{i}(:,1:12),y(:,1:12),'x');
temp = sum(min(dist{i}))/size(dist{i},2);
result{i} = temp;
if temp < mins
mins = temp;
index = i;
end
end