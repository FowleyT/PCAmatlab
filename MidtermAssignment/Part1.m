clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
workspace;  % Make sure the workspace panel is showing.
fontSize = 20;
I=imread('paris.jpg');
I=rgb2gray(I);
k = [10,100,55];

%part 1 loop through values for k and call pca methods
for n =1 : length(k)
principalComponents = getPrincipalComponents(I, k(n));
blockPCA = @(block_struct) computePCA(block_struct.data, k(n));
result=blockproc(I,[16 16],blockPCA);
figure,imshow(result);
imwrite(result,sprintf('images/r%d.jpg',k(n)));
end

%part 2 llop through first 10 PCs and display/write
principalComponentsToDisplay = getPrincipalComponents(I, 10);
for n =1 : 10
figure,imshow(principalComponentsToDisplay(n));
imwrite(principalComponentsToDisplay(n),sprintf('images/r%d.jpg',(n-1)));
end

% inputs: image and matrix of eigenvectors,ordered
%output: transposed PCA image
function [PCAimage] = computePCA(originalImage, eigenVectors)
    [rows , ~] = size(originalImage);
    originalImage = im2double(originalImage); % covert to double to facilitate manipulation
    imageMean = mean(originalImage); % find mean
    meanMatrix = repmat(imageMean,rows,1); % convert matrix to correct size
    meanSubImage = originalImage - meanMatrix; % subtract mean from points
    transposeVecs = transpose(eigenVectors); % transpose mean image and calculate PCA 
    transposeMeanImage = transpose(meanSubImage);
    PCAimage = transposeVecs * transposeMeanImage;
end

% inputs original image and desired numbe of components
% output matrix of eigenvectors ordered
function [finalVectors] = getPrincipalComponents(originalImage, k)

% similar to eatlier function, just abstracted here for ease of use
    [rows , ~] = size(originalImage);
    originalImage = im2double(originalImage);
    imageMean = mean(originalImage);
    meanMatrix = repmat(imageMean,rows,1);
    meanSubImage = originalImage - meanMatrix;
    covMatrix = cov(meanSubImage);
    [eigVecMat,eigValMat] = eig(covMatrix);
    eigVals = diag(eigValMat);
    [~,Index] = sort(eigVals,'descend');
    sortedEigVecs = eigVecMat(:,Index);
    finalVectors = sortedEigVecs(:,1:k);
end