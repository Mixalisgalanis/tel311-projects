function out = mapFeature(X1, X2)
% MAPFEATURE Feature mapping function to polynomial features
%
%   MAPFEATURE(X1, X2) maps the two input features
%   to quadratic features used in the regularization exercise.
%
%   Returns a new feature array with more features, comprising of 
%   X1, X2, X1.^2, X2.^2, X1*X2, X1*X2.^2, etc..
%
%   Inputs X1, X2 must be the same size
%
out = ones(size(X1, 1), 28);
new_index = 1;
for i = 0 : 6 % max degree
    for j = 0 : i
        P = X1.^(i-j) .* X2.^j;
        out(:,new_index) = P;  % append to vector
        new_index = new_index + 1;
    end
end
