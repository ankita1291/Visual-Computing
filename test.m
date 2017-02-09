
s = imread('/Van.jpg');
t = imread('/church.jpg');
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
rgbs = max(rgbs,1/255);
xyzc = [0.5141,0.3239,0.1604;0.2651,0.6702,0.0641;0.0241,0.1228,0.8444]*rgbs;
rgbt = [reshape(rt,1,st);reshape(gt,1,st);reshape(bt,1,st)];
rgbt = max(rgbt,1/255);
xyzt = [0.5141,0.3239,0.1604;0.2651,0.6702,0.0641;0.0241,0.1228,0.8444]*rgbt;
%convert to LMS
lmss = [0.3811 0.5783 0.0402;0.1967 0.7244 0.0782;0.0241 0.1288 0.8444]*rgbs;
lmst = [0.3811 0.5783 0.0402;0.1967 0.7244 0.0782;0.0241 0.1288 0.8444]*rgbt;
lmss = log10(lmss);
lmst = log10(lmst);
%convert to lab
labs = [1/sqrt(3),0,0;0,1/sqrt(6),0;0,0,1/sqrt(2)]*[1,1,1;1,1,-2;1,-1,0]*lmss;
labt = [1/sqrt(3),0,0;0,1/sqrt(6),0;0,0,1/sqrt(2)]*[1,1,1;1,1,-2;1,-1,0]*lmst;

labsm = mean(labs, 2);
labtm = mean(labt, 2);
stds = std(labs, 0, 2);
stdt = std(labt, 0, 2);
newimg(size(3, st));
for i = 1:3
    newimg(i,:) = labt(i,:)- labtm(i);
end

% for i =1:3
%     labsm(i) = mean(labs(i,:),2);
%     labs(i,:) = labs(i,:)- labsm(i);
%     labtm(i) = mean(labt(i),2);
%     labt(i,:) = labt(i,:)- labtm(i);
%     stds(i) = std(labs(i), 0, 1);
%     stdt(i) = std(labt(i), 0, 1);
% end
 factor = stds./stdt;
for i =1:3
    newimg2(i,:) = newimg(i,:)*factor(i);
    newimg(i,:) = newimg2(i,:)+labsm(i);
end
%convert back to lms
 lmsn = [1,1,1;1,1,-1;1,-2,0]*[sqrt(3)/3 0 0;0 sqrt(6)/6 0;0 0 sqrt(2)/2]*newimg;
 est = ([4.4679 -3.5873 0.1193;-1.2186 2.3809 -0.1624;0.0497 -0.2439 1.2045]*(10.^lmsn))';
 est = reshape(est,size(t));
 imshow(est);
