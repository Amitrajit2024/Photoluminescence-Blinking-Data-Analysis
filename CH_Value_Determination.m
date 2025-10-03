%% Optimal Cluster Determination using Calinski–Harabasz Index
% Description:
%   This script determines the optimal number of clusters in a dataset 
%   using the Calinski–Harabasz index across multiple epochs.
%   It plots evaluation metrics and identifies the most stable cluster number.

%% Load Data
% Update the file path as per your system
% Excel file will contain time in the first column and intensity data in rest of the columns
Data = xlsread('Provide path Name');
% Data = xlsread('C:\Users\Amitrajit Mukherjee\Desktop\Sample_Data'); %Example
Input = Data(:,2:end);
Input = Input'; % Transpose data, rows = features
%% Parameters
Kmax   = 15;    % Maximum number of clusters to evaluate
epochs = 100;   % Number of repetitions

%% Initialize
all_eval = zeros(epochs, Kmax-1);

%% Run Clustering Evaluations
for j = 1:epochs
    eva = evalclusters(Input, 'kmeans', 'CalinskiHarabasz', 'KList', 2:Kmax);
    all_eval(j, :) = eva.CriterionValues;
end

%% Mean Calinski–Harabasz Values
xx = mean(all_eval)';

%% Visualization
figure(1)
plot(2:Kmax, all_eval(1:end,:), '-o'); hold on;
xlim([0 16]);
xlabel('Number of clusters (K)');
ylabel('Calinski–Harabasz (CH) values');
title('CH Index Across Epochs');

figure(2)
plot(2:Kmax, mean(all_eval), '-o');
xlim([0 16]);
xlabel('Number of clusters (K)');
ylabel('Mean CH values');
title('Mean CH Index');

figure(3)
errorbar(2:Kmax, mean(all_eval), std(all_eval));
xlim([0 16]);
xlabel('Number of clusters (K)');
ylabel('CH values ± std');
title('Mean ± Std of CH Index');

