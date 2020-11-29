%3/Test and comment all these demos:
%a/Visualize Decision Surfaces of Different Classifiers
load fisheriris
X = meas(:,1:2);
y = categorical(species);
labels = categories(y);
figure(1)
gscatter(X(:,1),X(:,2),species,'rgb','osd');
xlabel('Sepal length');
ylabel('Sepal width');
classifier_name = {'Naive Bayes','Discriminant Analysis','Classification Tree','Nearest Neighbor'};
classifier{1} = fitcnb(X,y);
classifier{2} = fitcdiscr(X,y);
classifier{3} = fitctree(X,y);
classifier{4} = fitcknn(X,y);
x1range = min(X(:,1)):.01:max(X(:,1));
x2range = min(X(:,2)):.01:max(X(:,2));
[xx1, xx2] = meshgrid(x1range,x2range);
XGrid = [xx1(:) xx2(:)];
figure(2)
for i = 1:numel(classifier)
   predictedspecies = predict(classifier{i},XGrid);

   subplot(2,2,i);
   gscatter(xx1(:), xx2(:), predictedspecies,'rgb');

   title(classifier_name{i})
   legend off, axis tight
end

legend(labels,'Location',[0.35,0.01,0.35,0.05],'Orientation','Horizontal')
