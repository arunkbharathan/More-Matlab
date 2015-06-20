function dispresult(x,y,z)
disp('The average of Euclidean distances between database and test wave file')
color = ['r'; 'g'; 'c'; 'b'; 'm'; 'k'];
for i = 1:size(x,1)
disp(x(i,:))
disp(y{i})
end
disp('The test voice is most likely from')
disp(x(z,:))