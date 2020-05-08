function [U, S] = myPCA(X)
%PCA Run principal component analysis on the dataset X
%   [U, S] = myPCA(X) computes eigenvectors of the covariance matrix of X
%   Returns the eigenvectors U, the eigenvalues (on diagonal) in S

% ====================== YOUR CODE GOES HERE ======================
% I assume the input dataset is already standardized. First step is to 
% calculate the covariance matrix for the features in the dataset. Then
% i calculate the eigenvalues and eigenvectors for the covariance matrix.
cov_matrix = (1/size(X, 1)) .* (transpose(X) * X);
[U, S] = svd(cov_matrix);
% =========================================================================
end