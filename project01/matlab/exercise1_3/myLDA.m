function A = myLDA(Samples, Labels, NewDim)
% Input:    
%   Samples: The Data Samples 
%   Labels: The labels that correspond to the Samples
%   NewDim: The New Dimension of the Feature Vector after applying LDA

	[NumSamples, NumFeatures] = size(Samples);
    if(NumSamples ~= length(Labels))
        fprintf('\nNumber of Samples are not the same with the Number of Labels.\n\n');
        exit
    end

    classes = length(unique(Labels));
    %For each class i
	%Find the necessary statistics
    Sw = zeros; P = zeros; m = zeros(classes, NumFeatures);
    for i = 1 : classes
        idx = i - 1;
        %Calculate the Class Prior Probability
        P(i) = sum(Labels==idx) / (size(Samples, 1));
        %Calculate the Class Mean 
        m(i, :) = mean(Samples(Labels==idx, :));
        %Calculate the Within Class Scatter Matrix
        Sw = Sw + P(i) .* cov(Samples(Labels==idx, :));
    end
    
    %Calculate the Global Mean
    m0 = sum(m) ./ classes;
    
    %Calculate the Between Class Scatter Matrix
    Sb = zeros;
    for i = 1 : classes
        Sb = Sb + P(i) .* ((m(i) - m0)' * (m(i) - m0));
    end

    %Eigen matrix EigMat=inv(Sw)*Sb
    %EigMat = inv(Sw)*Sb;
    proj = Sw \ Sb;
    
    %Perform Eigendecomposition
    [V, D] = eig(proj);
    eigval = diag(D);
    [eigval, idx] = sort(eigval, 1, 'descend');
    V_sorted = V(:, idx);
    % Return the LDA projection vectors
    A = V_sorted(:, 1:NewDim);
    %A = A / norm(A);
end
