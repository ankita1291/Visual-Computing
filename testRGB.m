function colorTransferImg = testRGB(s, t, pathName)
% s = imread('/vanGogh.png');
% t = imread('/vanGoghtarget.png');
s = im2double(s);
t = im2double(t);
[row, col, noChannel] = size(s);
[rowt, colt, noChannel] = size(t);
means  = mean2(s);
meant = mean2(t);
stds = std2(s);
stdt = std2(t);
f = stds/stdt;
rt = t - meant;
newi = rt*f + means;
% figure();
% imshow(newi);
colorTransferImg = newi;
% reshapeRGBSrc = [reshape(s(:,:,1),1, []);reshape(s(:,:,2),1,[]);reshape(s(:,:,3),1,[])];
% reshapeRGBTgt = [reshape(t(:,:,1),1, []);reshape(t(:,:,2),1,[]);reshape(t(:,:,3),1,[])];
% meanSrc = mean(reshapeRGBSrc,2);
% meanTgt = mean(reshapeRGBTgt,2);
% 
% means = mean2(reshapeRGBSrc);
% meant = mean2(reshapeRGBTgt);
% reshapeRGBTgt = reshapeRGBTgt - meant; 
% reshapeRGBSrc = reshapeRGBSrc - means; 
% 
% stdSrc= std(reshapeRGBSrc,0,2);
% stdTgt = std(reshapeRGBTgt,0,2);
% factor = stdTgt./stdSrc;
% newImage = [];
% newImage2 = [];
% newImage = bsxfun(@times,factor ,reshapeRGBTgt);
% for i=1:3
%      newImage2(i,:) = newImage(i,:)+ means;
% end
% rgbImage = hsv2rgb(reshape(newImage2,size(t)));
% imshow(rgbImage);

% this one works :)
% % function colorTransferImg = testHSV(s, t, pathName)
% s = im2double(imread('/cat.bmp'));
% t = im2double(imread('/dog.bmp'));
% rgbs = max(s,1/255);
% rgbt = max(t,1/255);
% means = mean2(rgbs);
% meant = mean2(rgbt);
% stds = std2(rgbs);
% stdt = std2(rgbs);
% factor = stds/stdt;
% newImage = [];
% newImage2 = [];
% t = t - meant;
% newImage = bsxfun(@times,factor ,rgbt);
% newImage = newImage + means;
% figure();
% imshow(newImage);

