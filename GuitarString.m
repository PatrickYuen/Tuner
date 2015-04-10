clear all
clf

M = 1;   % Set mass of the string
L = 1;   % Set length of the string
r = 25;  % Set friction coefficient
f = 41.2; % Set frequency of the string: set to E
T = (2*f*L)^2*M;  % Compute the tension to get the desired frequency
wavespeed = sqrt(T/M);
N = 200;
dx = L/(N-1);
x = 0:dx:L;
nskip = ceil(2*wavespeed/(8192*dx));   
% nskip parameter to  set time step within desired limit. Put in a factor
% of 2 just for safety. Try setting it to factor less than 1, and print
% out the wave

dt = 1/(nskip*8192); % Set time step
H = zeros(1,N); % Create H array
V = zeros(1,N); % Create V array

% set initial conditions
x1 = 0.2*L;
j = 2:N-1; % Create an array of internal indices

% Set initial H for string plucking.
for i=1:N
    if(x(i)<x1)
        H(i) = x(i)/x1;
    else
        H(i) = (L-x(i))/(L-x1);
    end
end

% Loop over all time steps
tmax = 2;
clockmax = ceil(tmax/dt);
count = 0;
S = zeros(1,clockmax/nskip);
for clock=1:clockmax
    V(j) = V(j) + dt/dx^2*(T/M)*(H(j-1)-2*H(j)+H(j+1));% - dt*r/M*V(j); % Update velocity at all internal coordinates
    H(j) = H(j) + dt*V(j); % Update height
    if(mod(clock,nskip)== 0)
        count = count+1;
        S(count) = H(2); 
    end
end

plot(S);
disp(Note(S, 8192));
delete('note.wav');
audiowrite('note.wav',S,44000);