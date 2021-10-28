% RLS fuction
function [en,yn,wn] = myRLS(dn,xn,lamda,m)

LENGTH=length(dn);

%initialization
I=eye(m);
delta=0.05;
p=1/delta * I;
wn_1=zeros(m,1);
yn=zeros(LENGTH,1);
en=zeros(LENGTH,1);
x_1=zeros(m,1);

%Iteration process
for n = 1:LENGTH
    x_1=[xn(n); x_1(1:m-1)];
    k=(p*x_1)./(lamda+x_1'*p*x_1);
    yn(n)=x_1'*wn_1;
    en(n)=dn(n)-yn(n);
    wn_1=wn_1+k * en(n);
    p=(p-k*x_1'*p)./lamda;
    wn(:,n)=wn_1;
end

end