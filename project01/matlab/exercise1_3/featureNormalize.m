function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

% ====================== YOUR CODE GOES HERE ======================
    mu = mean(X);   % mean of each column (feature)
    sigma = std(X); % standard deviation of each column
    X_norm = zeros;
    for column = 1 : size(X, 2)   % For each column of X
        for i = 1:length(X)         % For each row of a particular column
            X_norm(i, column) = (X(i, column) - mu(column))/sigma(column);  % normalize each column independently
        end
    end
% ============================================================
end
