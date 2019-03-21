function xn = RK3( ts, dt, x,Vectorfield )
%TVD RUNGE_KUTTA_O3

% Vectorfield(ts,x): the function handle that takes the current time (ts) and
% current state (x) and delivers xdot

% x and output of Vectorfield (xdot) should be of the same size   

u1 = Vectorfield(ts, x);
x1 = x + dt * u1;
u2 = Vectorfield(ts + dt, x1);
x2 = x + (dt/4) * u1 + (dt/4) * u2;
u3 = Vectorfield(ts + dt/2, x2);
xn = x + (dt/6) * (u1 + u2 + 4*u3);



end

