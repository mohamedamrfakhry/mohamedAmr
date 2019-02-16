clear all
% --------------- edit version -------------------  
ds = datastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
ss=size(T);
TMS=ceil(0.6*ss(1));
Alpha=.01;
lamda=0.0;

m=length(T{:,1});
U0=T{:,2};
U=T{:,3:19};

U1=T{:,20:21};
U2=U.^2;
X=[ones(m,1) U U1];
n=length(X(1,:));
for w=2:n
    if max(abs(X(:,w)))~=0
    X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w));
    end
end
Y=T{:,3}/mean(T{:,3});
Theta=zeros(n,1);
%------(x^t*x)^-1 *x^t*y----
Theta=(inv(transpose(X)*X))*transpose(X)*Y;


