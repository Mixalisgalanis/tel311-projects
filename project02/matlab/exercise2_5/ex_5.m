% Clears everything 
clc; clear all; close all;

% 0. Warmup (Data loading & Initialization)
data = importdata('data_2_5.txt');
H = data.data;
n = size(H, 1);

% -------------------------------------------------------------------------
% 1. m parameter estimation and bayesian learning plot

s = 1.25;
m_0 = 0;
s_0 = sqrt(10) * s;

colors = jet(n);
lgd = cell(n, 1);
for i = 1:n
    % Calculate new mean and estimate parameters
    x_n = mean(H(1:i));
    m_n = (i * s_0^2 * x_n + s^2 * m_0) / (i * s_0^2 + s^2);
    s_n_sq = (s_0^2 * s^2) / (i * s_0^2 + s^2);
    % Calculate a posteriori density
    X = linspace(0, 6.5, 500);
    y = normpdf(X, m_n, s_n_sq);
    % Plot a posteriori density
    plot(X, y, 'Color', colors(i, :));
    lgd{i} = strcat('n = ' , num2str(i));
    hold on;
    grid on;
end
legend(lgd)

% -------------------------------------------------------------------------
% 2. Univariate case
x_n = mean(H); % n = 25 (constant)
s_0_table = [sqrt(10) * s, sqrt(1)* s, sqrt(0.1) * s, sqrt(0.01) * s];

colors = jet(length(s_0_table));
figure; lgd = cell(length(s_0_table), 1);
for i = 1:length(s_0_table) % cycle through all of s_0 values
    % Re-estimate parameters with different s_0
    m_n = (n * s_0_table(i)^2 * x_n + s^2 * m_0) / (n * s_0_table(i)^2 + s^2);
    s_n_sq = (s_0_table(i)^2 * s^2) / (n * s_0_table(i)^2 + s^2);
    
    % Calculate class conditional density
    X = linspace(-5, 10);
    y = normpdf(X, m_n, s_n_sq + s^2);
    
    % Plot class conditional density
    plot(X, y, 'Color', colors(i, :));
    lgd{i} = strcat(num2str(i), '. s_0^2 = ' , num2str(s_0_table(i) ^ 2));
    hold on;
    grid on;
end
legend(lgd)

