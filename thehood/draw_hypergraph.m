function [MHp,cmap,handle] = draw_hypergraph(X,Y,D,T,Option)

% draw hypergraphs given the value of mesohyperbolicity field (D) 
% [X,Y] grid
% as in Mezic et al, 2010, "A new mixing diagnostics and the Gulf oil
% spill"


Ts=4/T^2;   % meso-scale:  used to classify the region: larger than Ts is mesohelical (red)
            %               smaller than 0 is mesohyperbolic (blue) and
            %               in-between is meso-elliptic(green)

   
% post-processing of mesohyperbolicity  - we cut off the large values
% so that the colorbar doesn't be too packed
% we generally confine the valuues to be between -T_s and 2*T_s
MHp = D;
MHp(MHp<0) = - log( 1-MHp(MHp<0) ); 
MHp(MHp>Ts)=  Ts + 3.5*log( 1 - Ts + MHp(MHp>Ts));
MHp(MHp>2*Ts) = 2*Ts;
MHp(MHp<-Ts)  = -Ts;

% we prepare the colormap (red, green and blue) 



        % color coding
        m = 252;
        n = ceil(m/3);
        cmap = zeros(m,3);
        ind = 0;
        for i=1:n           % dark blue going to white
            ind =ind +1;
            cmap(ind,1)=(i-1)/(n-1);
            cmap(ind,2)=(i-1)/(n-1);
            cmap(ind,3)=1;
        end
        for i=1:n           % white going to green going to white again
            ind =ind +1;
            cmap(ind,1)=abs(cos(pi*(i-1)/(n-1)))^2;
            cmap(ind,2)=1;
            cmap(ind,3)=abs(cos(pi*(i-1)/(n-1)))^2;
        end
        for i=1:n           % white going to dark red
            ind =ind +1;
            cmap(ind,1)=1;
            cmap(ind,2)=(n-i)/(n-1);
            cmap(ind,3)=(n-i)/(n-1);
        end

handle=0;
if nargin < 5
                handle = contourf(X,Y,MHp,'LineStyle','None');
               colormap(cmap)
               caxis([-Ts 2*Ts])
end



% part of the source code
% for "Spectral Analysis of Mixing in 2D High-Reynolds Flows"
% by Arbabi and Mezic