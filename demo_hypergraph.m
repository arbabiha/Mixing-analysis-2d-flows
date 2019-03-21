function demo_hypergraph()
    addpath('./thehood/')
    disp({'demo of hypergraphs for detection of mixing regions'})
    
   
    
    % our data comes as snapshots of stream function
    File_name = 'Sample_data_Re13k';


    % so we pre-compute the velocity field
    compute_velfield(File_name)
    % and velocity gradient field
    compute_tenfield(File_name)
    
    
    % the grid for cavity
    N = 300;       
    [xs,ys]=CavityUniformGrid(N);
    
    
    % output times of advection
    tout = 0:10:100;
    dt = .05;   % inetgartyion time step
    
    
    % initializing 
    % note that in addition to the advection we have to solve variational
    % equations (eq. 3.4 in the paper)
    Xp = zeros(6*numel(xs),length(tout));
    Xp(:,1)=[xs;ys;ones(size(xs));zeros(size(xs));zeros(size(xs));ones(size(xs))];
    
    
    
    % run advection and variational system
    Xp=Forward_Lagrangian(File_name,Xp,tout,dt);
    
    
    
    % what is computed?
    np = numel(xs);
    xp = Xp(     1:np,  :); % position of tracers (not needed for forward hypergraphs)
    yp = Xp(  np+1:2*np,:);
    J11= Xp(2*np+1:3*np,:); % Flowmap Jacobians
    J12= Xp(3*np+1:4*np,:);
    J21= Xp(4*np+1:5*np,:);
    J22= Xp(5*np+1:6*np,:);
    
    
    
    % compute and plot hypergraphs at various times
    figure(46),clf, iplot=1;
    X0=reshape(xp(:,1),N,N);
    Y0=reshape(yp(:,1),N,N);
    
    for it = [1:5,10]
        
        T = tout(it+1)-tout(1);
        % meso-hyperbolicity field
        MH = (1/T^2)*( (J11(:,it+1)-1).*(J22(:,it+1)-1) - J21(:,it+1).*J12(:,it+1) );
        
        subplot(2,3,iplot)
        draw_hypergraph(X0,Y0,reshape(MH,N,N),T);
        axis square
        colorbar
        title(['$T=',num2str(T),'$'],'fontsize',14)
        iplot=iplot+1;
    end
    
    
    
    
    
    
    

end
    
function Xp=Forward_Lagrangian(Flowname,Xp,tout,dt)
        
        % Define the Vectorfield handle
        clear TensorfieldInterp    % clearing persistent variables
        VF=@(t,x)TensorfieldInterp(t,x,Flowname);

        % integration with RK4
        for it=1:length(tout)-1
            
            alpha=floor( (tout(it+1)-tout(it))/dt ); % # of steps per output time unit

            % temporary variables in each output time step
            Xc = zeros(size(Xp,1),alpha+1);
            tt = zeros(1,alpha+1);
      
            


            h = (tout(it+1)-tout(it))/alpha;
            Xc(:,1)=Xp(:,it);
            tt(1)=tout(it);

            for itt=1:alpha
                tt(itt+1) = tt(itt)+h; 
                Xc(:,itt+1) = RK4(tt(itt), h, Xc(:,itt),VF); %computing the solution at step it+1
            end
            Xp(:,it+1)=Xc(:,alpha+1);


        end
end





function [xs,ys]=CavityUniformGrid(n)
    [X,Y]=meshgrid(linspace(-1,1,n),linspace(-1,1,n));
    xs=X(:);
    ys=Y(:);
end
    
% part of the source code for
% "Spectral Analysis of Mixing in 2D High-Reynolds Flows"
% by Arbabi and Mezic
   
    
    