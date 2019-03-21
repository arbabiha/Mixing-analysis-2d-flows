function Vec = TensorfieldInterp(time,x,filename)

persistent VelField X Y TenField
% ---------------------------------------------------------%
% X, Y : spatial grid
% UX,UY: column vectors of velocity at the grid points
% t: time stamps      
% ---------------------------------------------------------%
if isempty(VelField)
    load(filename,'VelField')
    disp('Vector Field loaded')
    if length(VelField.t)==1    % steady field
        VelField.t = [0,1,1.33];
        VelField.UX = repmat(VelField.UX,[1,1,3]);
        VelField.UY = repmat(VelField.UY,[1,1,3]);
    end 
end

if isempty(TenField)
    load(filename,'TenField')
    disp('Tensor Field loaded')
    if length(VelField.t)==1    % steady field
        TenField.u11 = repmat(VelField.u11,[1,1,3]);
        TenField.u12 = repmat(VelField.u12,[1,1,3]);
        TenField.u21 = repmat(VelField.u21,[1,1,3]);
        TenField.u22 = repmat(VelField.u22,[1,1,3]);
    end 
    
end

if isempty(X)
    [X,Y]=meshgrid(VelField.xv,VelField.yv);
end

if time>=VelField.t(end)
    time=mod(time,VelField.t(end));
end

it = find(time<VelField.t,1,'first')-1;


xp = x(1:end/6);
yp = x(end/6+1:end/3);
J11= x(end/3+1:end/2);
J12= x(end/2+1:2*end/3);
J21= x(2*end/3+1:5*end/6);
J22= x(5*end/6+1:end);


method = 'spline';


%%% first interpolate in time
a = (time-VelField.t(it))/(VelField.t(it+1)-VelField.t(it));
%%% and then in space
Uinterm =   ((1-a)*VelField.UX(:,:,it)) + (a * VelField.UX(:,:,it+1));
Vinterm =   ((1-a)*VelField.UY(:,:,it)) + (a * VelField.UY(:,:,it+1));
u11_interm = ((1-a)*TenField.u11(:,:,it)) + (a * TenField.u11(:,:,it+1));
u12_interm = ((1-a)*TenField.u12(:,:,it)) + (a * TenField.u12(:,:,it+1));
u21_interm = ((1-a)*TenField.u21(:,:,it)) + (a * TenField.u21(:,:,it+1));
u22_interm = ((1-a)*TenField.u22(:,:,it)) + (a * TenField.u22(:,:,it+1));



up = interp2(X,Y,Uinterm,xp,yp,method);
vp = interp2(X,Y,Vinterm,xp,yp,method);
U11 = interp2(X,Y,u11_interm,xp,yp,method);
U12 = interp2(X,Y,u12_interm,xp,yp,method);
U21 = interp2(X,Y,u21_interm,xp,yp,method);
U22 = interp2(X,Y,u22_interm,xp,yp,method);


% rate of change in Jacobians


Vec =[up; ...
    vp;...
    U11.*J11+U12.*J21;...
    U11.*J12+U12.*J22;...
    U21.*J11+U22.*J21;...
    U21.*J12+U22.*J22];


end



% part of the source code
% for "Spectral Analysis of Mixing in 2D High-Reynolds Flows"
% by Arbabi and Mezic