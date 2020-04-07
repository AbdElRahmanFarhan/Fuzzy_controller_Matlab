clc; clear all; close all;
r=1;%Set Point
dt=0.001;%Time Step
c=0;%System Output
cp=0;%Previous Output
ep=0;%Prev Error
Tau=0.1;%Lag Time Constant
K=50;%System Gain
fis=readfis('MyController');%Fuzzy Controller
yi=0;%Integrator Output
Ns=2000;%Total number of Samples
for i=1:Ns
e=r-c;%Error
de=(e-ep);%Error Change
u=evalfis([e de],fis);%Compute controller output
yi=yi+dt*u; %Integrator Output
c=Tau*cp/dt+K*yi;
c=c/(1+Tau/dt); %Lag Output
cp=c;%Storing Previous Output
ep=e;%Storing Previous Errror
Y(i)=c;%Storing System Output
end
%Computing Sum of Squared Error
ISE1=dt*sum((Y-1).^2)
plot(dt*[0:(Ns-1)],Y,'r-')
xlabel('Sec')
ylabel('System Output')
grid
hold on
%%%%%%%%%%%%%%%%%