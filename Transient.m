%% Section 2 - Transient Circuit Simulation
% In this section, we use a finite difference approach to numerically
% simulate the time domain response of the circuit analyzed in the previous
% section. The circuit is a low pass filter/amplifier. It comes with an expected
% frequency response of high gain for low frequency inputs, and a rolloff
% in gain for frequencies above its corner frequency.
%defining component values

R1 = 1;
R2 = 2;
R3 = 10;
R4 = 0.1;
R5 = 1000;
g1 = 1/R1;
g2 = 1/R2;
g3 = 1/R3;
g4 = 1/R4;
g5 = 1/R5;
L = 0.2;
C = .25;
a = 100;
t=0;
dt=1e-3;
Tstop = 1000*dt;
%Capacitive matrix
C = [C -C 0 0 0 0 0;
    -C C 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 -L;
     0 0 0 0 0 0 0];
%Conductivity matrix
 G =   [g1 -g1 0 0 0 1 0 ;
        -g1 g1+g2 0 0 0 0 1;
        0 0 g3 0 0 0 -1;
        0 0 0 1 0 0 -a;
        0 0 0 -g4 g4+g5 0 0 ;
        0 1 -1 0 0 0 0 ;
        1 0 0 0 0 0 0];
   
 A = (1/dt)*C +G;
 Vin = zeros(1,1000);
 Vout = zeros(1,1000);
 Vold = zeros(1,7);
 vin = 0;
 while t<Tstop
     %defining input function
     if (t>30)
         vin = 1;
     end
     F = [0 0 0 0 0 0 vin]'; 
     %%%%
     %problem here: C in finite difference matrix dimensions are bad
     %%%%
     V = A\(Vold/dt + F);
     Vin(t/dt + 1) = V(1);
     Vout(t/dt + 1) = V(5);
     Vold = V;
     t = t+dt;
 end
 t = 0:1:1000;
 %plotting step response
  figure(1)
  plot(t,Vin)
  hold on 
  plot(t,Vout)
  
  
  
  %resetting variables
 Vin = zeros(1,1000);
 Vout = zeros(1,1000);
 Vold = zeros(1,7);
 vin = 0;
 t=0;
 f = 1/0.03;
 while t<Tstop
     vin = sin(2*pi*f*t);
     F = [0 0 0 0 0 0 vin]'; 
     %%%%
     %problem here: C in finite difference matrix dimensions are bad
     %%%%
     V = A\(Vold/dt + F);
     Vin(t/dt + 1) = V(1);
     Vout(t/dt + 1) = V(5);
     Vold = V;
     t = t+dt;
 end
 t = 0:1:1000;
 %plotting sinusoidal response
  figure(2)
  plot(t,Vin)
  hold on 
  plot(t,Vout)
  
  
  %resetting variables
 Vin = zeros(1,1000);
 Vout = zeros(1,1000);
 Vold = zeros(1,7);
 vin = 0;
 t=0;
 while t<Tstop
    %set up gaussian pulse
     F = [0 0 0 0 0 0 vin]'; 
     %%%%
     %problem here: C in finite difference matrix dimensions are bad
     %%%%
     V = A\(Vold/dt + F);
     Vin(t/dt + 1) = V(1);
     Vout(t/dt + 1) = V(5);
     Vold = V;
     t = t+dt;
 end
 t = 0:1:1000;
 %plotting gaussian response
  figure(2)
  plot(t,Vin)
  hold on 
  plot(t,Vout)
  
  
 
 
 
 
 