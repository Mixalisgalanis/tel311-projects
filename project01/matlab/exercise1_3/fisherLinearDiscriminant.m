function v = fisherLinearDiscriminant(X1, X2)
%   fisherLinearDiscriminant(X1, X2) returns a vector of unit norm. This
%   function applies the Linear Discriminant Analysis on a binary class
%   case.
% ====================== CODE GOES HERE ======================
    % X1, X2 are standardized. We have two equal propability classes (1) and (2)
    m_est(:, 1) = mean(X1);
    m_est(:, 2) = mean(X2);

    S1 = (1/size(X1, 1)) * transpose(X1) * X1;
    S2 = (1/size(X2, 1)) * transpose(X2) * X2;

    Sw = (S1 + S2) / 2;
    w = Sw \ (m_est(:, 1) - m_est(:, 2));
    v = w / norm(w);
% ============================================================
end