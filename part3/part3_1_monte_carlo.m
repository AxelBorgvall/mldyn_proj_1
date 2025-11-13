N=6000;
thetas = [];
for i = 1:N
    [x, y] = linearData(100,1,0);
    m = polyfit(x,y,0,1);
    theta = m.theta;
    thetas = [thetas theta];
end
bins = 20;

figure;
histogram(thetas(:,:,1),bins)
figure;
histogram(thetas(:,:,2),bins)