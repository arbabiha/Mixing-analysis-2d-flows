function xn = RK4(ts, h, x,Vectorfield)


u1 = Vectorfield(ts, x);
x1 = x + h/2 * u1;
u2 = Vectorfield(ts + h/2, x1);
x2 = x + h/2 * u2;
u3 = Vectorfield(ts + h/2, x2);
x3 = x + h * u3;
u4 = Vectorfield(ts + h, x3);
xn = x + h/6 * (u1 + 2 * u2 + 2 * u3 + u4);

end
