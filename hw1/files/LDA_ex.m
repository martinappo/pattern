X1 = [4, 2; 2, 4; 2, 3; 3, 6; 4, 4];
X2 = [9, 10; 6, 8; 9, 5; 8, 7; 10, 8];

Mu1 = mean(X1)';
Mu2 = mean(X2)';

S1 = cov(X1);
S2 = cov(X2);

% within class scatter matrix
Sw = S1 + S2;
% between-class scatter matrix
Sb = (Mu1-Mu2)*(Mu1-Mu2)';

% LDA projection
SwSb = inv(Sw)*Sb;

% projection vector
[V,D] = eig(SwSb);

% sort according to eigenvalues
eigen_val = diag(D);
[eigen_val_sorted, index] = sort(eigen_val,'descend');

W1 = V(:,index);

% project data samplesalong he projection axes
new_X1 = X1*W1;
new_X2 = X2*W1;
% get back the original data
old_X1 = new_X1*W1';
old_X2 = new_X2*W1';

figure
plot(X1(:,1),X1(:,2),'r*')
hold on
plot(X2(:,1),X2(:,2),'b*')

figure
plot(new_X1(:,1),new_X1(:,2),'r*')
hold on
plot(new_X2(:,1),new_X2(:,2),'b*')

% reduce dimension
figure
plot(new_X1(:,1),0,'r*')
hold on
plot(new_X2(:,1),0,'b*')

figure
plot(old_X1(:,1),old_X1(:,2),'r*')
hold on
plot(old_X2(:,1),old_X2(:,2),'b*')