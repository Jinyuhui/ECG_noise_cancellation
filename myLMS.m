%LMS
function [en,yn,wn]=myLMS(dn,xn,mu,m)

LENGTH=length(dn);

% Initialization
xx=zeros(m,1);
wn_1=zeros(m,1);
yn=zeros(LENGTH,1);
en=zeros(LENGTH,1);

% Iteration process
for n=1:LENGTH
    xx=[xx(2:m);xn(n)];
    yn(n)=wn_1'*xx;
    en(n)=dn(n)-yn(n);
    wn_1=wn_1+mu*en(n)*xx;
    wn(:,n)=wn_1;
end

end