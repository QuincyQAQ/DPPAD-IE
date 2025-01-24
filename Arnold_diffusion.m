function C1 = Arnold_diffusion(P)
[M,N]=size(P);
L=M*N;
P=reshape(P,1,L);
P=double(P);

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

C=zeros(1,L);
S=zeros(1,L); 
T=zeros(1,L);

C(1)=mod(1*P(1)+a*K1(1)+K2(1),256);
T(1)=mod(b*P(1)+(a*b+1)*K1(1)+K3(1),256);
S(2)=mod(T(1)+P(2),256);

for i=2:L-1
    C(i)=mod(1*S(i)+a*K1(i)+K2(i),256);
    T(i)=mod(b*S(i)+(a*b+1)*K1(i)+K3(i),256);
    S(i+1)=mod(T(i)+P(i+1),256);

end
C(L)=mod(1*S(L)+a*K1(L)+K2(L),256);


C1=zeros(1,L);
C1(L)=mod(1*C(L)+a*K1(1)+K2(1),256);
T(L)=mod(b*C(L)+(a*b+1)*K1(1)+K3(1),256);
S(L-1)=mod(T(L)+C(L-1),256);

for i=L-1:-1:2
    C1(i)=mod(1*S(i)+a*K1(L-i+1)+K2(L-i+1),256);
    T(i)=mod(b*S(i)+(a*b+1)*K1(L-i+1)+K3(L-i+1),256);
    S(i-1)=mod(T(i)+C(i-1),256);

end
C1(1)=mod(1*S(1)+a*K1(L)+K2(L),256);


C1=uint8(reshape(C1,M,N));
C1=uint8(C1);


end







