clc;clear all;
m=.1; %para punto 2: m=.1, para el punto 3: m=2*.1
Fricc=0.1; long=0.6;g=9.8;M=.5;
h=0.0001;tiempo=(10/h);p_pp=0;tita_pp=0;
omega(1)=0;
%Condiciones iniciales
alfa(1)=pi+0.01; %pi-desplazamiento
color='b';
p(1)=0; p_p(1)=0; u(1)=0; i=1;
%Versión linealizada en el equilibrio estable.
%estado=[p(i); p_p(i); alfa(i); omega(i)]

Mat_A=[0 1 0 0;0 -Fricc/M -m*g/M 0; 0 0 0 1; 0 -Fricc/(long*M) -g*(m+M)/(long*M) 0]
Mat_B=[0; 1/M; 0; 1/(long*M)]

Xop=[0 0 pi 0]';
x=[0 0 alfa(1) 0]';
tic
while(i<(tiempo+1))

    %Variables del sistema no lineal
    estado=[p(i); p_p(i); alfa(i); omega(i)];
    u(i)=0;
    %Sistema no lineal
    p_pp=(1/(M+m))*(u(i)-m*long*tita_pp*cos(alfa(i))+m*long*omega(i)^2*sin(alfa(i))-Fricc*p_p(i));
    tita_pp=(1/long)*(g*sin(alfa(i))-p_pp*cos(alfa(i)));
    p_p(i+1)=p_p(i)+h*p_pp;
    p(i+1)=p(i)+h*p_p(i);
    omega(i+1)=omega(i)+h*tita_pp;
    alfa(i+1)=alfa(i)+h*omega(i);

    %Variables del sistema lineal
    pl(i)=x(1); p_pl(i)=x(2);alfal(i)=x(3);omegal(i)=x(4);

    %Sistema lineal
    xp=Mat_A*(x-Xop)+Mat_B*u(i);
    x=x+h*xp;
    i=i+1;
end
TCalculo=toc
disp(TCalculo)

t=0:i-1; t=t*h; u(i)=0;
pl(i)=x(1); p_pl(i)=x(2);alfal(i)=x(3);omegal(i)=x(4);
hfig1 = figure(1);
subplot(3,2,1);plot(t,omega,color);grid on; title('Velocidad Angulo');hold on;plot(t,omegal,'k');
subplot(3,2,2);plot(t,alfa,color);hold on;plot(t,pi*ones(size(t)),'k');plot(t,alfal,'k');
grid on;title('Angulo');hold on;
subplot(3,2,3); plot(t,p,color);grid on;title('Posicion carro');hold on;plot(t,pl,'k');
subplot(3,2,4);plot(t,p_p,color);grid on;title('Velocidad carro');hold on;plot(t,p_pl,'k');
subplot(3,1,3);plot(t,u,color);grid on;title('Accion de control');xlabel('Tiempo en Seg.');hold on;
hfig2 = figure(2);
subplot(2,2,1);plot(alfa,omega,color);grid on;xlabel('Angulo');ylabel('Velocidad angular');hold on;
subplot(2,2,1);plot(alfal,omegal,'k');
subplot(2,2,2);plot(p,p_p,color);grid on;xlabel('Posicion carro');ylabel('Velocidad carro');hold on;
subplot(2,2,2);plot(pl,p_pl,'k');

