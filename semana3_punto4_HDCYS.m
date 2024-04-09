clear all; clc; close all;
pkg load symbolic
syms fi fi_p fi_pp p p_p p_pp M m u long Fricc g;
disp('Para el equilibrio estable')
ang_inic = pi;

p_pp=(1/(M+m))*(u-m*long*fi_pp+m*long*fi_p^2*(pi-fi)-Fricc*p_p);
fi_pp=(1/long)*(-g*(fi)+p_pp); %Pequeños angulos para fi~pi sin(fi)~(pi-fi)

%cos(fi)=(-1)
%DA ERROR DE CALCULO
fi_pp=solve(fi_pp==(1/long)*(g*(pi-fi)+p_pp),fi_pp);
disp('fi_pp=');
pretty(simplify(fi_pp));
p_pp=subs(p_pp,'fi_pp',fi_pp);
disp('p_pp=');
pretty(simplify(fi_pp));
p_pp=subs(p_pp,'fi_pp',fi_pp);


Mat_A=[[0 1 0 0];
 [subs(subs(subs(subs(diff(p_pp, p), p,0),p_p,0),fi,ang_inic),fi_p,0), ...
 subs(subs(subs(subs(diff(p_pp, p_p), p,0),p_p,0),fi,ang_inic),fi_p,0), ...
 subs(subs(subs(subs(diff(p_pp, fi), p,0),p_p,0),fi,ang_inic),fi_p,0), ...
 subs(subs(subs(subs(diff(p_pp, fi_p), p,0),p_p,0),fi,ang_inic),fi_p,0)]; ...
 [0 0 0 1];...
 [subs(subs(subs(subs(diff(fi_pp, p), p,0),p_p,0),fi,ang_inic),fi_p,0),...
 subs(subs(subs(subs(diff(fi_pp, p_p), p,0),p_p,0),fi,ang_inic),fi_p,0),...
 subs(subs(subs(subs(diff(fi_pp, fi), p,0),p_p,0),fi,ang_inic),fi_p,0),...
 subs(subs(subs(subs(diff(fi_pp, fi_p), p,0),p_p,0),fi,ang_inic),fi_p,0)]];
Mat_B=[0;
 subs(subs(subs(subs(diff(p_pp, u), p,0),p_p,0),fi,ang_inic),fi_p,0);...
 0;
 subs(subs(subs(subs(diff(fi_pp, u), p,0),p_p,0),fi,ang_inic),fi_p,0)];
disp('A=')
pretty(simplify(Mat_A))
disp('B=')
pretty(simplify(Mat_B))



