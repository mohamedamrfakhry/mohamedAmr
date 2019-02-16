
function [E,e,ee,Theta]=aml(b)
ds = datastore('house_data_complete.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
size(T);
ss=size(T);
TrainS=ceil(0.5*ss(1));
CrosVS=TrainS+ceil(0.2*ss(1));
Alpha=.01;
lamda=0.00;

m=length(T{:,1});
U0=T{:,2};
U11=T{:,4:7};
U12=T{:,9:16};
U13=T{:,18:19};

U=[U11 U12 U13];
U1=T{:,20:21};
%U3=log(U);

X0=[ones(m,1) U U1 ];
X1=[ones(m,1) U U1 U.^2 ];
X2=[ones(m,1) U U1 U.^2 U.^3];
X3=[ones(m,1) U U1 U.^2 U.^3 U.^4];
X4=[ones(m,1) U U1 U.^2 U.^3 U.^4 U.^5];
X5=[ones(m,1) U U1 U.^2 U.^3 U.^4 U.^5 U.^6];
X6=[ones(m,1) U U1 U.^2 U.^3 U.^4 U.^5 U.^6 U.^7];
X7=[ones(m,1) U U1 U.^2 U.^3 U.^4 U.^5 U.^6 U.^7 U.^8];


if b==0
   X=X0;
else
if b==1
   X=X1;
else
if b==2
   X=X2;
else
if b==3
   X=X3;
else
    if b==4
   X=X4;
    else
       if b==5
   X=X5;
       else
          if b==6
   X=X6;
    else
    X=X7;
          end
       end

end  
end    
end
end
end


%U4=exp(-x);
n=length(X(1,:));
%n=10000
for w=2:n
    if max(abs(X(:,w)))~=0
    X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w));
    end
end
x=X;
X=X(1:TrainS,1:end);
Y=T{:,3}/mean(T{:,3});
y=Y;
Y=Y(1:TrainS,1:end);
Theta=zeros(n,1);
k=1;
m=length(X(:,1));
E(k)=(1/(2*m))*sum((X*Theta-Y).^2);

R=1;
while R==1
Alpha=Alpha*1;
Theta=Theta-(Alpha/m)*X'*(X*Theta-Y);
k=k+1;

E(k)=(1/(2*m))*sum((X*Theta-Y).^2)+((lamda/2*m)*sum(Theta.^2));
if E(k-1)-E(k)<0
    break
end 
q=(E(k-1)-E(k))./E(k-1);
if q <.01;
    R=0;
end

end
%--------------------cv set--------------------
X=x(TrainS:CrosVS,1:end);
Y=y(TrainS:CrosVS,1:end);
R=1;
m=length(X(:,1));
while R==1
Alpha=Alpha*1;
Theta=Theta-(Alpha/m)*X'*(X*Theta-Y);
k=k+1;

e(k)=(1/(2*m))*sum((X*Theta-Y).^2)+((lamda/2*m)*sum(Theta.^2));
if e(k-1)-e(k)<0
    break
end 
q=(e(k-1)-e(k))./e(k-1);
if q <.01;
    R=0;
end

end
%-------------------- test --------------------
X=x(CrosVS:end,1:end);
Y=y(CrosVS:end,1:end);
R=1;
m=length(X(:,1));
while R==1
Alpha=Alpha*1;
%Theta=Theta-(Alpha/m)*X'*(X*Theta-Y);
k=k+1;

ee(k)=(1/(2*m))*sum((X*Theta-Y).^2)+((lamda/2*m)*sum(Theta.^2));
if ee(k-1)-ee(k)<0
    break
end 
q=(ee(k-1)-ee(k))./ee(k-1);
if q <.01;
    R=0;
end

end
E=E(end);
e=e(end);
ee=ee(end);
end
