clear all
k=1;
while(k<9)
 E(1,k)=k;
[E(2,k),E(3,k),E(4,k),Theta]=aml(k-1)
k=k+1;
end
