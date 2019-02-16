clear all

ds = datastore('heart_DD.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
size(T);
ss=size(T);
TrainS=ceil(0.5*ss(1));
CrosVS=TrainS+ceil(0.2*ss(1));
TestS=ss(1);
Alpha=.01;
lamda=0.00;

m=length(T{:,1});

U=T{:,1:13};
X=[ones(m,1) U ];
n=length(X(1,:));

Y=T{:,14};

Theta=zeros(n,1);
m=length(X(:,1));

h=1/(1+exp(X*-Theta));
h=h';
aa=(1-Y).*log(1-h)
a=-Y.*log(h)
E(1)=(1/m)*sum(-Y.*log(h)-(1-Y).*log(1-h));

k=2;
R=1;
while R==1
Alpha=Alpha*1;
Theta=Theta-(Alpha/m)*X'*(h-Y);
h=1/(1+exp(X*-Theta));
k=k+1;
h=h';
E(k)=(-1/m)*sum(Y.*log(h)+(1-Y).*log(1-h));
q=(E(k-1)-E(k))./E(k-1);
if isnan(E(k))
    break
end
    
if q <.01;
    R=0;
end
end

