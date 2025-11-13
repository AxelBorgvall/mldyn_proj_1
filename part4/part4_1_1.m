addpath('linRegFuncs');
addpath('canvas_code');

N=1000;
var=0;


[x,y]=twoDimData2(N,var);


[xq,yq] = meshgrid(0:.2:10, 0:.2:10);
vq = griddata(x(:,1),x(:,2),y,xq,yq);
mesh(xq,yq,vq)

hold on
plot3(x(:,1),x(:,2),y,'o')