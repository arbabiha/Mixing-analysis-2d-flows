function demo_mix_norm()
    addpath('./thehood/')
    disp({'demo of semi-Lagrangian advection simulation';
          'and using mix norm to quantify mixing'})



    % our data comes as snapshots of stream function
    File_name = 'Sample_data_Re13k';


    % so we pre-compute the velocity field
    compute_velfield(File_name)




    N = 333; % numer of grid points for the output grid
    [X,Y,Mesh2Vec,Vec2Mesh]=CavityGrid(N);
    xy = Mesh2Vec(X,Y);
    dx = X(1,2)-X(1,1);
    CFL = 5; % larger --> faster but less accurate computation, 5 is okay for here
    dt = CFL *dx; % time step of integration


    % time stamps for the advection output (should include 0) 
    T = 0:10:100;


    % advection of grid points backward in time
    [xy_departure]=Backward_Advection(File_name,xy,T,dt);



    % the initial density field:
    % creating a square blob with density 1
    C0=zeros(size(X));
    C0(X>-0.5 & X<=.5 & Y>0.5 & Y<=1)=1;  


    % evolution of density via interpolation 
    C= zeros([size(X),length(T)]);
    C(:,:,1)=C0;
    for jt=2:length(T)
        [X_dp,Y_dp]=Vec2Mesh(xy_departure(:,jt));   
        C(:,:,jt) = interp2(X,Y,C(:,:,jt-1),X_dp,Y_dp,'linear');
    end


    % plot the density field evolution
    figure(77), clf,iplot=1;
    for jT=[1,2,6,8,11]

        Cnow=C(:,:,jT);

        subplot(2,3,iplot),cla
        contourf(X,Y,Cnow,100,'LineStyle','None')
        colormap(AdvectionColorMap(128))
        axis square
        title([' t=',num2str(T(jT))],'FontSize',14);
        iplot=iplot+1;
    end

    % compute mix-norm
    phi = zeros(size(T));

    for j=1:length(T)
         phi(j) = SobolevNorm2D( C(:,:,j),'DomainSize',[2,2]);
    end

    subplot(2,3,iplot)
    plot(T,phi,'-x')
    title('Mix-norm','FontSize',14,'LineWidth',1.5)
    xlabel('t','FontSize',14)
end

function [X,Y,Mesh2Vec,Vec2Mesh]=CavityGrid(N)
    x=linspace(-1,1,N+1);
    y=x;
    [X,Y]=meshgrid(x,y);
    Mesh2Vec = @(X,Y) [X(:);Y(:)];
    Vec2Mesh = @(xy)  deal(reshape( xy(1:end/2),sqrt(size(xy,1)/2),sqrt(size(xy,1)/2)), ...
                         reshape( xy(end/2+1:end),sqrt(size(xy,1)/2),sqrt(size(xy,1)/2)) );


end

function [ cmap ] = AdvectionColorMap( n )

    x = linspace(0,1,n)';
    cmap= flipud([x x x]);

end


% part of the source code for
%  "Spectral Analysis of Mixing in 2D High-Reynolds Flows"
% by Arbabi and Mezic
