%% Binning and Normalization of Blinking Data
% Description:
%   This script loads blinking data from an Excel file, bins the data 
%   using a fixed window length, normalizes the results to [0, 1], 
%   and visualizes both original and processed signals.

%% Load Data
% Update the path to your input Excel file
% Excel file will contain time in the first column and intensity data in rest of the columns
Data = xlsread('Provide path Name');
% Data = xlsread('C:\Users\Amitrajit Mukherjee\Desktop\Sample_Data.xlsx'); %Example
[c, d] = size(Data);  % Get the dimensions of the data matrix

Binned_Data = [];     % Initialize array to store binned results

%% Parameters
window_length = 80;   % Provide Window size for data binning

%% Process Each Column (except the first, assumed time)
for j = 2 : d
    I = Data(:, j);   % Extract signal for each columns    
    % Optional: Remove NaNs if data lengths are unequal
    % I = I(~isnan(I));  
    
    I = I';  % Transpose to row vector for binning

    % --- Binning ---
    % Reshape signal into windows and compute mean per bin
    out_mean = nanmean(reshape([I(:); nan(mod(-numel(I), window_length), 1)], ...
                        window_length, []));
    
    % --- Normalization ---
    % Scale the binned signal to [0, 1]
    out_mean_norm = normalize(out_mean, 'range');  
    
    % Store the normalized binned data
    Binned_Data = [Binned_Data, out_mean_norm']; 

    % --- Visualization: Original Data ---
    figure('Name', sprintf('Original_%d', j));
    plot(1:length(I), I, 'LineWidth', 1.5);
    title(sprintf('Original Data for Column %d', j));
    xlabel('Time (samples)');
    ylabel('Blinking Data');
    axis tight;

    % --- Visualization: Binned + Normalized Data ---
    figure('Name', sprintf('Binned_%d', j + 10000));
    plot(1:length(out_mean_norm), out_mean_norm, 'LineWidth', 1.5);
    title(sprintf('Binned and Normalized Data for Column %d', j));
    xlabel('Time (binned)');
    ylabel('Normalized Blinking Data');
    axis tight;
end

%% Visualization: All Processed Data
figure(1111);
plot(Binned_Data, 'LineWidth', 1.5);
title('All Binned and Normalized Data');
xlabel('Data Index');
ylabel('Normalized Blinking Data');
axis tight;
