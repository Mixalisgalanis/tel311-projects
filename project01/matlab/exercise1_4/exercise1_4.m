%Loading the image database
data = load('./data/mnist.mat');

%Reshaping images as 2 dimensional 28-by-28 pixel arrays
images = zeros(size(data.trainX, 1), 28, 28);
labels = zeros(size(data.trainY, 2), 1);

for i = 1:size(data.trainX, 1)
    img = data.trainX(i, :);
    images(i, :, :) = reshape(img, 28, 28)';
    labels(i) = data.trainY(i);
end

%Extract only images belonging to class 1 and 2
digit_C1_images = images(labels == 1, :, :);
digit_C2_images = images(labels == 2, :, :);
digit_images = [digit_C1_images;digit_C2_images];

% Compute the aspect ratios of all images and store the value of the i-th image in aRatios(i)
aRatios = computeAspectRatio(digit_images); %Ratios of all images
minAspectRatio = min(aRatios);
maxAspectRatio = max(aRatios);

aRatiosC1 = computeAspectRatio(digit_C1_images); %Ratios of class 1
minAspectRatioC1 = min(aRatiosC1);
maxAspectRatioC1 = max(aRatiosC1);

aRatiosC2 = computeAspectRatio(digit_C2_images); %Ratios of class 2
minAspectRatioC2 = min(aRatiosC2);
maxAspectRatioC2 = max(aRatiosC2);

% Calculate the histograms of our samples
% Use the findBin function to get the counts for the histogram
% C1
numBins = 3;
binEndsC1 = linspace(minAspectRatioC1, maxAspectRatioC1, numBins+1);
C1_bins = zeros(1, numBins);
for i = 1:length(aRatiosC1)
    idx = findBin(aRatiosC1(i), binEndsC1);
    C1_bins(idx) = C1_bins(idx) + 1;
end

% C2
binEndsC2 = linspace(minAspectRatioC2, maxAspectRatioC2, numBins+1);
C2_bins = zeros(1, numBins);
for i = 1:length(aRatiosC2)
    idx = findBin(aRatiosC2(i), binEndsC2);
    C2_bins(idx) = C2_bins(idx) + 1;
end


binEnds = linspace(minAspectRatio, maxAspectRatio, numBins+1);
all_bins = zeros(1, numBins);
for i = 1:length(aRatios)
    idx = findBin(aRatios(i), binEnds);
    all_bins(idx) = all_bins(idx) + 1;
end

% Prior Probabilities
PC1 = size(digit_C1_images, 1) / size(images, 1);
PC2 = size(digit_C2_images, 1) / size(images, 1);

% Likelihoods
PLgivenC1 = C1_bins(1) / size(digit_C1_images, 1);
PMgivenC1 = C1_bins(2) / size(digit_C1_images, 1);
PHgivenC1 = C1_bins(3) / size(digit_C1_images, 1);

PLgivenC2 = C2_bins(1) / size(digit_C2_images, 1);
PMgivenC2 = C2_bins(2) / size(digit_C2_images, 1);
PHgivenC2 = C2_bins(3) / size(digit_C2_images, 1);

% Evidence 
PL = PLgivenC1 * PC1 + PLgivenC2 * PC2;
PM = PMgivenC1 * PC1 + PMgivenC2 * PC2;
PH = PHgivenC1 * PC1 + PHgivenC2 * PC2;

% Posterior Probabilities
PC1givenL = PLgivenC1 * PC1 / PL;
PC2givenL = PLgivenC2 * PC2 / PL;