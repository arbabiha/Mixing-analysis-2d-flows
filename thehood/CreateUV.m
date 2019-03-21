function uv = CreateUV(ts,XY,filename)

% XY is a column vector
X = XY(1:end/2);
Y = XY(end/2+1:end);


% interpolate 
[up,vp]=InterpolateInTimeSpace(ts,X,Y,filename);

uv = [up;vp];

end

% part of the source code
% for "Spectral Analysis of Mixing in 2D High-Reynolds Flows"
% by Arbabi and Mezic