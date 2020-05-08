function Z = projectData(X, U, K)
%PROJECTDATA Computes the reduced data representation when projecting only 
%on to the top k eigenvectors
%   Z = projectData(X, U, K) computes the projection of 
%   the input samples X into the reduced dimensional space spanned by
%   the first K columns of U. It returns the projected examples in Z.

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the projection of the data using only the top K 
%               eigenvectors in U (first K columns).
U = U(:, 1:K);
Z = X * U;
% =============================================================
end