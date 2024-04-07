clc;clear all;

X=-[0;0;0;0]; %Punto de operacion para Taylor
t_etapa=10e-3;
tSim=20;

Ts=t_etapa;
u=1;
ii=0;

for t=0:t_etapa:tSim
  ii=ii+1;
  x2(ii)=X(2);
  x4(ii)=X(4);
  X=modavionsemana2(t_etapa, X, u);
  acc(ii)=u;
end
t=0:t_etapa:tSim;
hfig1 = figure(1);
subplot(3,1,1);hold on;
plot(t,x2,'r');title('x_2 angulo fi'); hold on;
subplot(3,1,2);hold on;
plot(t,x4,'r');title('x_4 Altura');
subplot(3,1,3);hold on;
plot(t,acc,'r');title('Entrada u_t, v_a');
xlabel('Tiempo [Seg.]');


