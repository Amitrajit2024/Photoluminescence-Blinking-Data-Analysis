%% Optimal Cluster Determination using Silhouette Method
% Description:
%   This script determines the optimal number of clusters in a dataset 
%   using the Silhouette score across multiple epochs.
%   It also evaluates "misclassified" points (below threshold) 
%   and plots performance metrics.

%% Parameters
epox  = 100;   % Number of repetitions (epochs)
Kmax  = 15;    % Maximum number of clusters to evaluate

%% Load Data
% Update the path to your input Excel file
% Excel file will contain time in the first column and intensity data in rest of the columns
Data = xlsread('Provide path Name');
% Data = xlsread('C:\Users\Amitrajit Mukherjee\Desktop\Sample_Data'); %Example
Input = Data(:,2:end);
Input = Input'; % Transpose data, rows = features

%% Initialize Storage
silhouette_loop = zeros(epox, Kmax-1);
percent_below_meanSLH_loop = zeros(epox, Kmax-1);

%% Run Clustering Evaluations
for j = 1:epox
    SLH = zeros(Kmax, 1);                   % Stores Silhouette scores
    percent_below_meanSLH = zeros(Kmax, 1); % Stores misclassification percentages

    for k = 2:Kmax
        clust = kmeans(Input, k);   % K-means clustering (default: sqeuclidean distance)
        SS  = silhouette(Input, clust);
        SS1 = mean(SS);          % Mean Silhouette score
        SS2 = 100 * (sum(SS < 0) / length(SS)); % Percentage of Misclassification

        SLH(k,:) = SS1;
        percent_below_meanSLH (k,:) = SS2;
    end

    % Store results per epoch
    silhouette_loop(j,:)            = SLH(2:end);
    percent_below_meanSLH_loop(j,:) = percent_below_meanSLH(2:end);
end

%% Aggregate Results
Mean_SLH                     = mean(silhouette_loop);
Mean_percent_below_meanSLH   = mean(percent_below_meanSLH_loop);
error                        = std(silhouette_loop);
error1                       = std(percent_below_meanSLH_loop);

%% Visualization
% Plot raw silhouette scores for each epoch
figure(1);
plot(2:Kmax, silhouette_loop(1:end,:), '-o'); hold on;
xlabel('Number of clusters (K)');
ylabel('Silhouette score');
title('Silhouette Method');

% Plot mean silhouette scores
figure(2);
plot(2:Kmax, Mean_SLH, '-o');
xlabel('Number of clusters (K)');
ylabel('Mean Silhouette score');
title('Silhouette Method');

% Error bars on mean silhouette scores
figure(3);
errorbar(2:Kmax, Mean_SLH, error);
xlabel('Number of clusters (K)');
ylabel('Mean Silhouette score');
title('Silhouette Method');

% Plot misclassification percentage
figure(4);
plot(2:Kmax, percent_below_meanSLH_loop(1:end,:), '-o'); hold on;
xlim([0 16]);
%ylim([0 100]); 
xlabel('Number of clusters (K)');
ylabel('Percentage_below_zero');
title('Misclassification');

% Plot average misclassification percentage
figure (5);
plot(2:Kmax,Mean_percent_below_meanSLH,'-o');
xlim([0 16]); 
%ylim([0 100]); 
xlabel('Number of clusters (K)');
ylabel('Mean_Percentage_below_zero');
title('Misclassification');

% Error bars on average misclassification percentage
figure(6)
errorbar(2:Kmax, Mean_percent_below_meanSLH,error1);
xlim([0 16]); 
%ylim([0 100]);
xlabel('Number of clusters (K)');
ylabel('Mean STD Percent below zero');
title('Misclassification');