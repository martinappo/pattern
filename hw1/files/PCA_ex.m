X1 = [2.5 0.5 2.2 1.9 3.1 2.3 2.0 1.0 1.5 1.2]';
X2 = [2.4 0.7 2.9 2.2 3.0 2.7 1.6 1.1 1.6 0.9]';

Mu1 = mean(X1);
Mu2 = mean(X2);
% shift
X1p = X1-Mu1;
X2p = X2-Mu2;
% get covariance matrix
cov_mat = cov(X1p,X2p);

[V,D]=eig(cov_mat);
% sort according to eigenvalues
eigen_val = diag(D);
[eigen_val_sorted, index] = sort(eigen_val,'descend');
% use all eigenvectors for full reconstruction
feature_vector = V(:,index);

RowFeatureVector = feature_vector';
RowZeroMeanData = [X1p X2p]';

FinalData = (RowFeatureVector * RowZeroMeanData)';

figure
plot(X1,X2,'r*')

figure
plot(FinalData(:,1),FinalData(:,2),'r*')

% reduce dimension
figure
plot(FinalData(:,1),0,'r*')

% recover 
[r,c]=size(FinalData);
OriginalMean = repmat([Mu1 Mu2]',1,r);
RowOriginalData = (pinv(RowFeatureVector)*FinalData') + OriginalMean;
ColOriginalData = RowOriginalData';

figure
plot(ColOriginalData(:,1),ColOriginalData(:,2),'r*')

