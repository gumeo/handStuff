%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Try some basic stuff here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I = im2double(imread('./images/0.jpg'));

figure;
imshow(I);

% Do PCA on image
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

figure;
subplot(3,1,1);
imshow(R);
subplot(3,1,2);
imshow(G)
subplot(3,1,3);
imshow(B)


d = [R(:) G(:) B(:)];
coeff = pca(double(d));
% Make a projection
d = double(d)*coeff;
R = reshape(d(:,1),size(R));
G = reshape(d(:,2),size(R));
B = reshape(d(:,3),size(R));
figure;
subplot(3,1,1);
imagesc(R);
subplot(3,1,2);
imagesc(G);
subplot(3,1,3);
imagesc(B);

figure;
histogram(G(:));

figure;
imagesc(G>0.03);

% Define mask
mask = G > 0.03;

% Fill holes
mask = imfill(mask,'holes');
figure;
imagesc(mask);

bw = activecontour(G,mask,300);
  
figure, imshow(bw); hold on;
title('Segmented Image');
visboundaries(bw,'Color','r');
hold off;

% Try to trace boundary
contour = bwtraceboundary(bw,[281 660],'W',8,Inf,'counterclockwise');

figure;
imshow(bw);
hold on;
scatter(contour(:,2),contour(:,1));


