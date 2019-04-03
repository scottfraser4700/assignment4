%% Section 3 - Circuit with Noise
% Here we are modelling a variation to the previous circuit, attempting to
% model the thermal noise generated in a resistor. We need to take two new
% components into our MNA equations, a current source to model the noise,
% and a capacitor to bandwidth limit the circuit. The new capacitor Cn will
% be placed in position (3,3) in the C matrix, and In will be placed in
% (3,1) in the F matrix. F is randomly generated from a normal distribution
% with each iteration in time. 
% Section 4 involves implementing a more complex nonlinear transconductance
% to our system, which involves using the B vector in our solution. We
% would need to implement a Jacobian which involves a bunch of computation
% that I don't really want to do. Other than the introduction to the B term
% whenever the system of equations is solved, most of the rest of the code
% can be reused.

%component values
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
C1 = .25;
Cn = 0.00001;
a = 100;
t=0;
dt=1e-3;
Tstop = 1000*dt;
%Capacitive matrix
C = [C1 -C1 0 0 0 0 0;
    -C1 C1 0 0 0 0 0;
     0 0 Cn 0 0 0 0;
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
 A = (1/dt)*C+G;
   %resetting variables
 Vin = zeros(1,1000);
 Vout = zeros(1,1000);
 Vold = zeros(7,1);
 vin = 0;
 t=0;
 iteration=1;
 delay=0.06;
 sigma=0.03;
 while t<Tstop
    %set up gaussian pulse
     vin = (1/(sqrt(2*pi)*sigma))*exp(-((delay-t)^2)/(2*sigma^2));
     In = randn*0.01;
     F = [0 0 In 0 0 0 vin]'; 
     V = A\(C*Vold/dt + F);
     Vin(iteration) = vin;
     Vout(iteration) = V(5);
     Vold = V;
     iteration=iteration+1;
     t = t+dt;
 end
 t = 0:1:999;
 %plotting gaussian response
  figure(8)
  subplot(2,1,1);
  plot(t,Vin)
  hold on 
  plot(t,Vout)
  title('Gaussian Response')
  subplot(2,1,2);
  plot(Frequency,10*log10(abs(fftshift(fft(Vout)))))
  title('Fourier Transform of Gaussian Response Cn=0.00001')
  
  %second plot of noise analysis with C = 0.001 instead of 0.00001
  Cn= 0.0001;
  C = [C1 -C1 0 0 0 0 0;
    -C1 C1 0 0 0 0 0;
     0 0 Cn 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 -L;
     0 0 0 0 0 0 0];
   Vin = zeros(1,1000);
 Vout = zeros(1,1000);
 Vold = zeros(7,1);
 vin = 0;
 t=0;
 iteration=1;
 delay=0.06;
 sigma=0.03;
 while t<Tstop
    %set up gaussian pulse
     vin = (1/(sqrt(2*pi)*sigma))*exp(-((delay-t)^2)/(2*sigma^2));
     In = randn*0.01;
     F = [0 0 In 0 0 0 vin]'; 
     V = A\(C*Vold/dt + F);
     Vin(iteration) = vin;
     Vout(iteration) = V(5);
     Vold = V;
     iteration=iteration+1;
     t = t+dt;
 end
 t = 0:1:999;
 %plotting gaussian response
  figure(9)
  subplot(2,1,1);
  plot(t,Vin,'r')
  hold on 
  plot(t,Vout,'b')
  title('Gaussian Response')
  subplot(2,1,2);
  plot(Frequency,10*log10(abs(fftshift(fft(Vout)))))
  title('Fourier Transform of Gaussian Response C=0.0001')
  
  %third plot of noise analysis with C=0.000001
  Cn= 0.000001;
  C = [C1 -C1 0 0 0 0 0;
    -C1 C1 0 0 0 0 0;
     0 0 Cn 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 -L;
     0 0 0 0 0 0 0];
 
 Vin = zeros(1,1000);
 Vout = zeros(1,1000);
 Vold = zeros(7,1);
 vin = 0;
 t=0;
 iteration=1;
 delay=0.06;
 sigma=0.03;
 while t<Tstop
    %set up gaussian pulse
     vin = (1/(sqrt(2*pi)*sigma))*exp(-((delay-t)^2)/(2*sigma^2));
     In = randn*0.01;
     F = [0 0 In 0 0 0 vin]'; 
     V = A\(C*Vold/dt + F);
     Vin(iteration) = vin;
     Vout(iteration) = V(5);
     Vold = V;
     iteration=iteration+1;
     t = t+dt;
 end
 t = 0:1:999;
 %plotting gaussian response
  figure(10)
  subplot(2,1,1);
  plot(t,Vin)
  hold on 
  plot(t,Vout)
  title('Gaussian Response')
  subplot(2,1,2);
  plot(Frequency,10*log10(abs(fftshift(fft(Vout)))))
  title('Fourier Transform of Gaussian Response C=0.000001')
 

 