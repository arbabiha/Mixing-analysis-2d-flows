function [ up,vp ] = InterpolateInTimeSpace( time,X,Y,filename )
%INTERPOLATEINTIMESPACE load the velocity field in the filename 
% and interpolates the velocity field at X-Y grid and time t
persistent VelField Xv Yv
% ---------------------------------------------------------%
% X, Y : spatial grid
% UX,UY: column vectors of velocity at the grid points
% t: time stamps      
% ---------------------------------------------------------%

if isempty(VelField)
    load(filename,'VelField')
    disp('VF loaded')
    if length(VelField.t)==1    % steady field
        VelField.t = [0,1,1.33];
        VelField.UX = repmat(VelField.UX,[1,1,3]);
        VelField.UY = repmat(VelField.UY,[1,1,3]);
    end 
end


if isempty(Xv)
    [Xv,Yv]=meshgrid(VelField.xv,VelField.yv);
end


if time>=VelField.t(end)
    time=mod(time,VelField.t(end));
end


it = find(time<VelField.t,1,'first')-1;
method = 'spline';

%%% first interpolate in time
a = (time-VelField.t(it))/(VelField.t(it+1)-VelField.t(it));
Uinterm = ((1-a)*VelField.UX(:,:,it)) + (a * VelField.UX(:,:,it+1));
Vinterm = ((1-a)*VelField.UY(:,:,it)) + (a * VelField.UY(:,:,it+1));

%%% and then in space
up = interp2(Xv,Yv,Uinterm,X,Y,method);
vp = interp2(Xv,Yv,Vinterm,X,Y,method);
end

