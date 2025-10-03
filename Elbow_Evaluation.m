%% Elbow Method for Optimal K in K-means
% Description:
%   This script applies the Elbow Method to determine the optimal number 
%   of clusters (K) for k-means clustering. It repeats clustering across 
%   multiple epochs to stabilize results and plots the SSE (sum of squared errors).

%% Parameters
Kmax = 15;   % Maximum number of clusters to evaluate
epox = 100;  % Number of repetitions (epochs) to average SSE

%% Load Data
% Update the path to your input Excel file
% Excel file will contain time in the first column and intensity data in rest of the columns
Data = xlsread('Provide path Name');
% Data = xlsread('C:\Users\Amitrajit Mukherjee\Desktop\Sample_Data'); %Example
Input = Data(:,2:end);
Input = Input'; % Transpose data, rows = features

%% Initialize Storage
graphs = zeros(epox, Kmax);  % SSE results across epochs

%% Run K-means for Multiple Epochs
for j = 1:epox
    sse = zeros(Kmax, 1);   % SSE values for this epoch
    
    for k = 1:Kmax
        % Perform k-means clustering
        [~, C] = kmeans(Input, k);  
        
        % Compute squared Euclidean distances from each point to cluster centroids
        D = pdist2(Input, C).^2;  
        
        % Sum of squared distances (SSE) for this cluster count
        sse(k) = sum(min(D, [], 2));
    end
    
    % Store epoch results
    graphs(j, :) = sse;
end

%% Aggregate Results
mean_sse = mean(graphs, 1);  % Mean SSE across epochs
std_sse  = std(graphs, 0, 1); % Standard deviation of SSE

%% Visualization
% Plot SSE across all epochs
figure(1);
plot(1:Kmax, graphs', '-o');
xlabel('Number of clusters (K)');
ylabel('Sum of squared distances (SSE)');
title('Elbow Method: SSE Across Epochs');
xlim([0 Kmax + 1]);

% Plot mean SSE across epochs
figure(2);
plot(1:Kmax, mean_sse, '-o');
xlabel('Number of clusters (K)');
ylabel('Mean Sum of Squared Distances');
title('Elbow Method: Mean SSE');
xlim([0 Kmax + 1]);

% Plot mean SSE with error bars (std deviation)
figure(3);
errorbar(1:Kmax, mean_sse, std_sse, '-o');
xlabel('Number of clusters (K)');
ylabel('Mean SSE ± Std Dev');
title('Elbow Method: Mean and Standard Deviation of SSE');
xlim([0 Kmax + 1]);
