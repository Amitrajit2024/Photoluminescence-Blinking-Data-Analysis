%% K-means Clustering on Processed Data with Mapping to Original Traces
% Description:
%   This script performs k-means clustering on processed (binned/normalized) data,
%   visualizes the clusters, and maps the results back to the original
%   unprocessed data to display individual traces per cluster.

%% Load Original unprocessed Data
% Update paths to unprocessed data files
% Excel file will contain time in the first column and unprocessed data in rest of the columns
Original_Data = xlsread('Provide path Name');
% Original_Data = xlsread('C:\Users\Amitrajit Mukherjee\Desktop\Unprocessed_Data'); %Example
Original_Data = Original_Data(:,2:end);          
Original_Data = Original_Data';    % Transpose data

%% Load processed Data
% Update the path to input processed Data file
% Excel file will contain time in the first column and processed data in rest of the columns
Processed_Data = xlsread('Provide path Name');
% Processed_Data = xlsread('C:\Users\Amitrajit Mukherjee\Desktop\Processed_Data'); %Example
[c, d] = size(Processed_Data);
Input = Processed_Data(:,2:end);                            
Input = Input'; % Transpose data

%% Parameter
k = 3;   % Provide number of clusters for k-means

%% Perform K-means Clustering
[idx, C] = kmeans(Input, k);

%% Visualization: Clustered Data
figure(2);
for i = 1:k
    subplot(k, 1, i);
    plot(Input(idx == i, :)', 'LineWidth', 1.5);
    title(sprintf('Cluster %d', i));
    xlim([0 c]);
    axis tight;
end

% Set renderer for better export quality
set(gcf, 'renderer', 'Painters');

%% Separate Original Data by Clusters
cluster_1 = Original_Data(idx == 1, :)';
cluster_2 = Original_Data(idx == 2, :)';
cluster_3 = Original_Data(idx == 3, :)';

% If needed, uncomment and extend for more clusters:
% cluster_4 = Original_Data(idx == 4, :)';

%% Plot Individual Traces per Cluster
% Cluster 1
[n1, m1] = size(cluster_1);
for j = 1:m1
    figure(j + 10);
    plot(cluster_1(:, j));
    title(sprintf('Cluster 1 - Trace %d', j));
end

% Cluster 2
[n2, m2] = size(cluster_2);
for j = 1:m2
    figure(j + 100);
    plot(cluster_2(:, j));
    title(sprintf('Cluster 2 - Trace %d', j));
end

% Cluster 3
[n3, m3] = size(cluster_3);
for j = 1:m3
    figure(j + 1000);
    plot(cluster_3(:, j));
    title(sprintf('Cluster 3 - Trace %d', j));
end

% Example for Cluster 4 (optional)
% [n4, m4] = size(cluster_4);
% for j = 1:m4
%     figure(j + 10000);
%     plot(cluster_4(:, j));
%     title(sprintf('Cluster 4 - Trace %d', j));
% end

% Optionally, repeat for additional clusters (if they exist)
