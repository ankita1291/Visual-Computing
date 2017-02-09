function colorTransferImg = testHSV(s, t, pathName)
% s = imread('/vanGogh.png');
% t = imread('/vanGoghTarget.png');
s = im2double(s);
t = im2double(t);
hsvImgSrc = rgb2hsv(s);
hsvImgTgt = rgb2hsv(t);
[row, col, noChannel] = size(hsvImgSrc);
[rowt, colt, noChannel] = size(hsvImgTgt);
hsvImageSource = [reshape(hsvImgSrc(:,:,1),1, []);reshape(hsvImgSrc(:,:,2),1,[]);reshape(hsvImgSrc(:,:,3),1,[])];
hsvImageTarget = [reshape(hsvImgTgt(:,:,1),1, []);reshape(hsvImgTgt(:,:,2),1,[]);reshape(hsvImgTgt(:,:,3),1,[])];
meanSrc = mean(hsvImageSource,2);
meanTgt = mean(hsvImageTarget,2);
stdSrc= std(hsvImageSource,0,2);
stdTgt = std(hsvImageTarget,0,2);
factor = stdSrc./stdTgt;
[row,col,ch] = size(t);
newimg = zeros(3,row*col);
for i=1:3
    newimg(i,:) = (hsvImageTarget(i,:) - meanTgt(i))*factor(i) + meanSrc(i);
end
rgbImage = hsv2rgb(reshape(newimg,size(t)));
figure();
imshow(rgbImage);
means  = mean2(hsvImgSrc);
meant = mean2(hsvImgTgt);
stds = std2(hsvImgSrc);
stdt = std2(hsvImgTgt);
f = stds/stdt;
rs = hsvImgSrc - means;
rt = hsvImgTgt - meant;
newi = rt*f + means;
rgbi = hsv2rgb(newi);
% figure();
% imshow(rgbi);
colorTransferImg = rgbi;
