function colorTransferImg = colortransfer(s, t, pathName)
r = im2double(s(:,:,1));
g = im2double(s(:,:,2));
b = im2double(s(:,:,3));
[row,col] = size(r);
rs = row*col;
rt = im2double(t(:,:,1));
gt = im2double(t(:,:,2));
bt = im2double(t(:,:,3));
[rowt, colt] = size(rt);
st = rowt*colt;
rgbs = [reshape(r,1,[]);reshape(g,1,[]);reshape(b,1,[])];
xyzc = [0.5141,0.3239,0.1604;0.2651,0.6702,0.0641;0.0241,0.1228,0.8444]*rgbs;
rgbt = [reshape(rt,1,st);reshape(gt,1,st);reshape(bt,1,st)];
xyzt = [0.5141,0.3239,0.1604;0.2651,0.6702,0.0641;0.0241,0.1228,0.8444]*rgbt;
%convert to LMS
rgbs = max(rgbs,1/255);
rgbt = max(rgbt,1/255);
lmss = [0.3811 0.5783 0.0402;0.1967 0.7244 0.0782;0.0241 0.1288 0.8444]*rgbs;
lmst = [0.3811 0.5783 0.0402;0.1967 0.7244 0.0782;0.0241 0.1288 0.8444]*rgbt;
lmss = log10(lmss);
lmst = log10(lmst);
%convert to lab
labs = [1/sqrt(3),0,0;0,1/sqrt(6),0;0,0,1/sqrt(2)]*[1,1,1;1,1,-2;1,-1,0]*lmss;
labt = [1/sqrt(3),0,0;0,1/sqrt(6),0;0,0,1/sqrt(2)]*[1,1,1;1,1,-2;1,-1,0]*lmst;
labsm(3,1)=0;
labtm(3,1)=0;
stds(3,1)=0;
stdt(3,1)=0;
for i =1:3
    labsm(i) = mean(labs(i,:));
   % labs(i,:) = labs(i,:)- labsm(i);
    labtm(i) = mean(labt(i,:));
    labt(i,:) = labt(i,:)- labtm(i);
    stds(i) = std(labs(i,:), 0, 2);
    stdt(i) = std(labt(i,:), 0, 2);
end
factor = stds./stdt;
newimg(3,st)=0;
for i =1:3
    newimg(i,:) = factor(i).*labt(i,:);
    newimg(i,:) = newimg(i,:)+labsm(i);
end
%convert to lms
%lmss = [1,1,1;1,1,-2;1,-1,0]*[1/sqrt(3),0,0;0,1/sqrt(6),0;0,0,1/sqrt(2)]*labs;
lmsn = [1,1,1;1,1,-1;1,-2,0]*[sqrt(3)/3 0 0;0 sqrt(6)/6 0;0 0 sqrt(2)/2]*newimg;
est = ([4.4679 -3.5873 0.1193;-1.2186 2.3809 -0.1624;0.0497 -0.2439 1.2045]*(10.^lmsn))';
est = reshape(est,size(t));
imwrite(est,strcat(pathName,'/newImg.bmp'));
colorTransferImg =  est;

%test for RGB color space
% r1 = (s(:,:,1));
% g1 = (s(:,:,2));
% b1 = (s(:,:,3));
% r2 = (t(:,:,1));
% g2 = (t(:,:,2));
% b2 = (t(:,:,3));
% rgbss = [reshape(r1,1,rs);reshape(g1,1,rs);reshape(b1,1,rs)];
% rgbtt = [reshape(r2,1,st);reshape(g2,1,st);reshape(b2,1,st)];
% s = imread('/cat.bmp');
% t = imread('/plane.bmp');
% stdrs = std2(s);
% stdrt = std2(t);
% meanrs = mean2(s);
% meanrt = mean2(t);
% fa = stdrt/stdrs;
% rs1 = s-meanrs;
% rt1 = t- meanrt;
% n1(size(t)) = 0;
% for i =1:3
%     n1 = fa.*rt1;
%     n1 = n1+meanrs;
% end
% rgbf = reshape(n1,size(t));
% figure();
% rgbf = ((rgbf));
% imshow(rgbf);
% colorTransferImg =  newimg;
