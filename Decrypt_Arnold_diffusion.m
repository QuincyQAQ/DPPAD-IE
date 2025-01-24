function P = Decrypt_Arnold_diffusion(C1)
[M,N]=size(C1);
L=M*N;
C1=reshape(C1,1,L);
C1=double(C1);

N0 =1000;
xn=zeros(1,L);yn=zeros(1,L);
x3 = -0.8;
y3 = -0.8;
a=25;b=20;
for i = 1:N0 + L/2
    x3 = a*cos(exp(1*x3^2)+y3);  
    y3 = b*cos(y3*(1-x3^2));
    if i > N0
        xn(i - N0) = mod(floor(x3* 10^15), 256);
        yn(i - N0) = mod(floor(x3* 10^10), 256);
    end
end

xn=horzcat(xn,yn);
yn=xn+1;
zn=xn*(-1);

K1=xn;
K2=yn;
K3=zn;

a=15;b=85;

 T(L)=mod(K1(1)+(b)*(C1(L)-K2(1))+(1)*(K3(1)),256);
 C(L)=mod((a*b+1)*(C1(L)-K2(1))+(-a)*(T(L)-K3(1)),256);

for n=L-1:-1:1

 T(n)=mod(K1(L+1-n)+(b)*(C1(n)-K2(L+1-n))+(1)*(K3(L+1-n)),256);
 S(n)=mod((a*b+1)*(C1(n)-K2(L+1-n))+(-a)*(T(n)-K3(L+1-n)),256);
 C(n)=mod(S(n)-T(n+1),256);

end


P=zeros(1,L);


 T(1)=mod(K1(1)+(b)*(C(1)-K2(1))+(1)*(K3(1)),256);
 P(1)=mod((a*b+1)*(C(1)-K2(1))+(-a)*(T(1)-K3(1)),256);

for n=2:L

 T(n)=mod(K1(n)+(b)*(C(n)-K2(n))+(1)*(K3(n)),256);
 S(n)=mod((a*b+1)*(C(n)-K2(n))+(-a)*(T(n)-K3(n)),256);
 P(n)=mod(S(n)-T(n-1),256);



P=uint8(reshape(P,M,N));

end

