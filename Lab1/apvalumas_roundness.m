function [apvl,bw]=apvalumas_roundness(im,threshold)

% im - image 
% sl - threshold (reik?m?s gali b?ti 
% intervale [0,1]), rekomenduojamos: 0.1 - 0.2
% atsakyme: apvl - apvalumas (reik?m?s intervale [0,1])
% bw - binarinis vaizdas


I = rgb2gray(imcomplement(im));
% threshold = graythresh(I);
bw = im2bw(I,threshold);
% % % % % % % % % % % % % % % % % % % % % % % % figure
% % subplot(2,2,1)
% % % % % % % % % % % % % % % % % % % % % % % % imshow(bw)

% remove all object containing fewer than 30 pixels
bw = bwareaopen(bw,30);

% fill a gap in the pen's cap
se = strel('disk',10);
bw = imclose(bw,se);

% fill any holes, so that regionprops can be used to estimate
% the area enclosed by each of the boundaries
bw = imfill(bw,'holes');
% % subplot(2,2,2)
% % imshow(bw)

[B,L] = bwboundaries(bw,'noholes');

% Display the label matrix and draw each boundary
% % subplot(2,2,3)
% % imshow(label2rgb(L, @jet, [.5 .5 .5]))
% hold on
% % for k = 1:length(B)
% %   boundary = B{k};
% %   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
% % end

stats = regionprops(L,'Area','Centroid');

threshold = 0.94;

% loop over the boundaries

for k = 1:length(B)

  % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = B{k};

  % compute a simple estimate of the object's perimeter
  delta_sq = diff(boundary).^2;
  perimeter = sum(sqrt(sum(delta_sq,2)));

  % obtain the area calculation corresponding to label 'k'
  area = stats(k).Area;

  % compute the roundness metric
  metric = 4*pi*area/perimeter^2;

  % display the results
  metric_string = sprintf('%2.2f',metric);

  % mark objects above the threshold with a black circle
  if metric > threshold
    centroid = stats(k).Centroid;
%     plot(centroid(1),centroid(2),'ko');
  end

% %   text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','y',...
% %        'FontSize',14,'FontWeight','bold');

end
apvl=metric;