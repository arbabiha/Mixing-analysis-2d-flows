function compute_velfield(fname)
disp('Computing the velocity field out of stream function ...')

load(fname) 

if exist('VelField','var')
    disp('Velocity field is already computed, skipping ...')
else


    % size of grid in each direction
    N = VelocityField.N;

    % load derivative operator and grid
    [ Grid,Operators ] = CavityGridOperators( N ); % grid coordinates and operators



    nt = length(VelocityField.Time);   % pick the time span - make it short otherwise the files become big
    uVector = [Operators.Dy; (-1)*Operators.Dx]*VelocityField.Psi(:,1:nt);

    VelField.UX = reshape(uVector(1:end/2,:),[N+1,N+1,nt]);
    VelField.UY = reshape(uVector(end/2+1:end,:),[N+1,N+1,nt]);
    VelField.xv = Grid.x;
    VelField.yv = VelField.xv;
    VelField.t  = VelocityField.Time(1:nt);
    VelField.t  = VelField.t-VelField.t(1);

    save(fname,'VelField','-append')
end



end


% part of the source code
% for "Spectral Analysis of Mixing in 2D High-Reynolds Flows"
% by Arbabi and Mezic

