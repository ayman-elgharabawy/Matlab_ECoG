function idx = gram_schmidt(X, Y, featnum)
%idx = gram_schmidt(X, Y, featnum)
% Feature selection by Gram Schmidt orthogonalization.
% X -- Data matrix (m, n), m patterns, n features.
% Y -- Target vector (m,1).
% featnum -- Number of features selected.
% idx -- Ordered indices of the features (best first.)
[m, N]=size(X);
if nargin<3 | isempty(featnum), featnum=min(m,N); end
idx=zeros(1,featnum); w=zeros(1,featnum);
rss=zeros(1,featnum); % Residual sum of squares
colid=1:N; % Original feature numbering
n=N;
% Main loop over features
for k=1:featnum
fprintf('\nTraining on feature set size: %d\n', N-n+1);
% Normalize
XN=sqrt(sum(X.^2)); % Norms of the feature vectors
XN(XN==0)=eps;
X_norma = X./repmat(XN, m,1); % Normalized feature matrix
% Project onto Y
y_proj = sum(repmat(Y, 1, n).*X_norma);
ay_proj=abs(y_proj);
% Find the direction of maximum projection
[maxval, maxidx] = max(ay_proj); % Dir. of max. proj.
idx(k)=colid(maxidx); % Index of that feature
% Update the model
w(k)=y_proj(maxidx)/XN(maxidx); % Weight of that feature
Y_proj = w(k)*X(:,maxidx); % Proj. Y on dir. X(:,maxidx)
Y_residual = Y - Y_proj; % New residual
rss(k) = sum(Y_residual.^2); % Residual error model
% Compute the residual X vectors
X_proj = sum(repmat(X_norma(:,maxidx),1,n).*X);
X_residual = X-repmat(X_proj, m, 1).* ...
repmat(X_norma(:,maxidx), 1, n);
% Change the matrix to iterate
Y=Y_residual;
X=X_residual(:, [1:maxidx-1,maxidx+1:n]);
colid=colid([1:maxidx-1,maxidx+1:n]);
n=n-1; 
fprintf('Training mse: %5.2f\n', rss(k)/m);
fprintf('Features selected:\nidx=[');
fprintf('%d ',idx(1:k));
fprintf(']\n');
end