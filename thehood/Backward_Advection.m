function [xy_departure]=Backward_Advection(flowname,xy,tout,dt)
% this program advects a blob in the cavity flow
% outputs:
% C: the advected field at time stamps in T 
% tout(1) is the start time and C(:,:,1) is the initial field
% xy_dp: the location of dparture points at time stamps in T
% xy(:,i) is the location at T(i)


% CFL is the ratio of dt/dx for the advection (5 is good for simple flows)





clear InterpolateInTimeSpace

disp('backward Lagrangian advection ...')




% vector field handle
CavityVelocity=@(t,x) CreateUV(t,x,flowname);

% initialize
xy_departure = zeros(length(xy),length(tout));
xy_departure(:,1)=xy;

% sequential iteration from T(i+1) to T(i) for i=1,2,...
tic
for bigstep = 2:length(tout)
    
    % first define the time grid
    tin = tout(bigstep):-dt:tout(bigstep-1);   
    xy_dp=xy;
    
    for tnow = tin(1:end-1)
               
        % compute the backward image of grid (departure points)
        xy_dp = RK3( tnow, -dt, xy_dp,CavityVelocity );

        
    end
    
    
    % saving the departure
    xy_departure(:,bigstep)=xy_dp;    
    
    
end

disp(['simulation time to advect the flow :',num2str(toc)])


end



% part of the source code
% for "Spectral Analysis of Mixing in 2D High-Reynolds Flows"
% by Arbabi and Mezic





