load fisheriris.mat

X = meas;
N = size(X, 1); % number of examples
species

K = 3; % Number of classes

[Pm, M, S] = fitGMMs(X, K);

Y_hat = zeros(N, 1);
for i = 1:N
    Y_hat(i, 1) = classify_with_gmms(X(i, :), Pm, M, S);
end

Y_hat


