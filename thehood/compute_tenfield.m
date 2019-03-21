function compute_tenfield(fname)
disp('Computing the velocity gradient tensor field out of stream function ...')

load(fname) 

if exist('TenField','var')
    disp('Tensor field is already computed, skipping ...')
else


    % size of grid in each direction
    N = VelocityField.N;

    % load derivative operator and grid
    [ ~,Operators ] = CavityGridOperators( N ); % grid coordinates and operators



    nt = length(VelocityField.Time);   % pick the time span - make it short otherwise the files become big
    uVector = [Operators.Dy; (-1)*Operators.Dx]*VelocityField.Psi(:,1:nt);



    TenField.u11 = reshape(Operators.Dx*uVector(1:end/2,:),[N+1,N+1,nt]);   % du/dx
    TenField.u12 = reshape(Operators.Dy*uVector(1:end/2,:),[N+1,N+1,nt]);   %du/dy
    TenField.u21 = reshape(Operators.Dx*uVector(end/2+1:end,:),[N+1,N+1,nt]);   %dv/dx
    TenField.u22 = reshape(Operators.Dy*uVector(end/2+1:end,:),[N+1,N+1,nt]);   %dv/dy

    save(fname,'TenField','-append')


end

% part of the source code
% for "Spectral Analysis of Mixing in 2D High-Reynolds Flows"
% by Arbabi and Mezic