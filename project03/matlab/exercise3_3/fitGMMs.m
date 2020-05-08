function [Pm, M, S] = fitGMMs(X, K)
    %
    % INPUT:
    %   X: (N X d) N example vectors of dimension d
    %   K: number of GMM components
    %
    % OUTPUT:
    %   Pm: (K X 1) mixing probabilities
    %   M: (K X d) mean vectors
    %   S: (K X d X d) covariance matrices 
      
    [N, d] = size(X);

    % Initialize using kmeans. You may use the matlab kmeans.

    % your code here

    G = zeros(N, K); % likelihood of classes given features

    for its = 1:100
        % E-step. Calculation of likelihood 'G'
        % your code here     

        % Likelihood normalization (of G)
        % your code here 

        % M-step. Parameter updates
        % your code here
    end 
