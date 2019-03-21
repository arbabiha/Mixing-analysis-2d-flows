function [ Phi ] = SobolevNorm2D( f,varargin)
%SOBOLEVNORM computes the sobolev norm of function f
%   inputs:
%   f: value of the function on a 2-dimensional uniform grid
%   'Index',ind (optional): the index of the norm     - default 1/2
%   'Domain Size',L (optional): the vector containing the domain size - default ones(1,N)
%   output:
%   Phi: the Sobolev Space norm of f
 
 % default parameters
 L = ones(1,2)*2;
 p = 0.5;

 % reading input parameters
 for i=1:2:nargin-1
     if strcmp(varargin{i},'DomainSize')
         L = varargin{i+1};
     elseif strcmp(varargin{i},'Index')
         p=varargin{i+1};
     end
 end
 
% disp(['Domain Size:',num2str(L(1)),'x',num2str(L(2))])
% disp(['Sobolve norm index:',num2str(-p)])

     

N   = size(f)-1;
kx = (0:N(1)-1)/L(1);
ky = (0:N(2)-1)/L(2);

[kx,ky] = meshgrid(kx,ky);

 SobolevWeights = 1./ (1+ ( 4 * pi^2 * (kx.^2+ky.^2) ).^p ) ;
 
 F = (1/N(1))*(1/N(2))* fft2(f(2:end,2:end));

 Phi = sqrt(sum(SobolevWeights(:).*( abs(F(:)).^2)));
 
end


% part of the source code
% for "Spectral Analysis of Mixing in 2D High-Reynolds Flows"
% by Arbabi and Mezic
