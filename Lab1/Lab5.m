RGB = imread('peppers.png');
imshow(RGB);
I = rgb2gray(RGB);
figure
imshow(I);
%%1 vertical
%  h = [-1 2 -1;...
%      -1 2 -1;...
%      -1 2 -1];

%%
%%2 horizontal
%  h = [-1 -1 -1;...
%       2 2 2;...
%       -1 -1 -1];

%%
%%3
%% h = [-1 -1 2;...
%      -1 2 -1;...
%      2 -1 -1];
%% edge
BW1 = edge(I,'Canny');
BW2 = edge(I,'Prewitt');
imshowpair(BW1,BW2,'montage')

%% corner

C = corner(I, 10);
imshow(I)
hold on
plot(C(:,1),C(:,2),'r*');
%%filteredRGB = imfilter(I, h);

%%figure, imshow(filteredRGB)
