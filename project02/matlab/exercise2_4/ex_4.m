%% Clears everything 
clc; clear all; close all;

%% 0. Warmup (Data loading & Initialization)
load('digits');
train_data = [train0; train1; train2; train3; train4; train5; train6; train7; train8; train9];
test_data = [test0; test1; test2; test3; test4; test5; test6; test7; test8; test9];

features = size(train_data, 2);
classes = size(train_data, 1) / size(train0, 1);
class_samples = size(train0, 1);

%% ------------------------------------------------------------------------
% 1. MLE Estimation
p = zeros(classes, features); % p contains MLE for every class
for i = 1:classes
    temp_data = train_data((i-1)*class_samples + 1 : i*class_samples, :);
    for j = 1:size(temp_data, 1) % samples
        % MLE is the sample's mean.
        p(i, :) = mean(temp_data);
    end
end

% Fix zeros -> 0.0000001
e = 0.0000001;
for i = 1:classes
    for j = 1:features
        if p(i,j) == 0
            p(i,j) = e;
        end
    end
end

%% ------------------------------------------------------------------------
% 2. Model training using ML estimators from the question above.
p_tr = zeros(10 * class_samples, 1);
for i = 1:classes
    temp_data = train_data((i-1)*class_samples + 1 : i*class_samples, :);
    for j = 1:size(temp_data, 1) % samples
        %(1,784) * (784,1) + (1,784) * (784,1) => (1,1) : p_tr()
        p_tr((i-1) * j + 1) = temp_data(j, :) * log(p(i, :))' + (1 - temp_data(j, :)) * log(1 - p(i, :))';
    end
end

% Visualize trained model
for i = 1:classes
    temp_data = train_data((i-1)*class_samples + 1 : i*class_samples, :);
    temp_p_tr = p_tr((i-1)*class_samples + 1 : i*class_samples, :);
    img = temp_data' * temp_p_tr;
    img_2d = reshape(img, 28, 28)';
    subplot(2,5,i);
    imagesc(img_2d);
end

%% ------------------------------------------------------------------------
% 3. Predicting test sets
confusion_matrix = zeros(classes);
for i = 1:classes % for each test set
    temp_data = test_data((i-1)*class_samples + 1 : i*class_samples, :);
    for j = 1:size(temp_data, 1) % samples
        p_test = zeros;
        for k = 1:classes % calculate propability of being a certain digit.
            p_test(k) = temp_data(j, :) * log(p(k, :))' + (1 - temp_data(j, :)) * log(1 - p(k, :))'; 
        end
        [val, argmax] = max(p_test); % Find argmax
        confusion_matrix(i, argmax) = confusion_matrix(i, argmax) + 1;
    end
end

% Calculate accuracy for each class
accVec = zeros;
for i = 1:classes
    accVec(i) = confusion_matrix(i,i) / sum(confusion_matrix(i, :));
end

% Calculate total accuracy
total_accuray = mean(accVec)