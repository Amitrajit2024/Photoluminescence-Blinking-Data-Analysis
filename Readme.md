**Clustering Workflow for Blinking Data Analysis**



This repository contains a MATLAB-based pipeline for processing and clustering blinking time-series data.

The workflow consists of five sequential steps:





1. **Binning and Normalization**



**2. Optimal Cluster Evaluation using Silhouette Score**



**3. Optimal Cluster Evaluation using Calinski–Harabasz (CH) Index**



**4. Optimal Cluster Evaluation using Elbow Method (SSE)**



**5. Clustering of Time Traces with Mapping to Original Data**







**Workflow Overview**



**Binning and Normalization (Data\_Binning.m)**



Loads raw blinking time traces from Excel.



Performs binning using a fixed window size.



Normalizes binned traces to range \[0, 1].



Produces:



Individual plots of original and processed traces.



A combined plot of all normalized traces.







**Silhouette Score Method (Silhouette\_Score\_Calculation.m)**



Repeats k-means clustering across multiple epochs.



Computes the Silhouette coefficient for different cluster counts.



Evaluates misclassification percentage (data points below threshold).



Produces:



Plots of Silhouette score across epochs.



Mean ± std plots of Silhouette values.



Misclassification percentage analysis.







**Calinski–Harabasz (CH) Index Method (CH\_Value\_Determination.m)**



Uses the Calinski–Harabasz index to determine optimal cluster number.



Runs multiple epochs for stable evaluation.



Produces:



CH index plots (per epoch, mean, mean ± std).







**Elbow Method (Elbow\_Evaluation.m)**



Implements the Elbow Method using Sum of Squared Errors (SSE).



Runs clustering across multiple epochs to average out randomness.



Produces:



SSE plots per epoch.



Mean SSE curve.



Mean ± std (error bars) plot.







**Clustering of Time Traces (Clustering\_Time\_Traces.m)**



Performs k-means clustering on the processed data.



Maps clustering results back to the original unprocessed traces.



Produces:



Subplots of clustered processed data.



Individual plots of original traces separated by cluster.



Supports flexible cluster numbers (k).







**Requirements**



MATLAB R2022a or later



Statistics and Machine Learning Toolbox





**\*\*For further concepts, please contact:**



Dr. Amitrajit Mukherjee



linkedin.com/in/amitrajit-mukherjee-484b2571

Email: amitrajit2010@gmail.com

