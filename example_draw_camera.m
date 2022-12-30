clear all; clc; close all;
% demo script for draw_camera
figure;
r_obj = 2;
r_rasp = 4;
h_cam = 2;
r_cam = 8;
cam_HPX = 1080;
cam_WPX = 1920;
AH = 21; 
AW = 39;
N = 4;
COLORS = [ 1 0 0; 0 1 0 ; 0 0 1; 0.5 0.5 0.5];

for i = 0:N-1
    [X,Y,Z] = ellipsoid(0,0,0,r_obj,r_obj,r_obj,20);
    X01 = r_rasp*cos(i*(2*pi/N));
    Y01 = r_rasp*sin(i*(2*pi/N));
    Z01 = h_cam;
    X1 = X + X01;
    Y1 = Y + Y01;
    Z1 = Z + Z01;

    XC = X01+ (r_rasp+r_cam)*cos(i*(2*pi/N));
    YC = Y01 +(r_rasp+r_cam)*sin(i*(2*pi/N));
    ZC = h_cam;
    t = [XC,YC,ZC];
    surf(X1,Y1,Z1);
    hold on;
    draw_camera(XC,YC,ZC,pi-(i*(2*pi/N)),0,0,r_cam+r_rasp,AH,AW,1.0,COLORS(i+1,:));

end;
[X,Y,Z] = cylinder(r_rasp,40);
Z = Z*0.5;
surf(X,Y,Z);

axis equal;axis manual; grid minor;
xlim([-18 22]);
ylim([-20 20]);

disp(['AH=' num2str(AH) ' deg AW=' num2str(AW) ' deg'])
disp(['r_obj=' num2str(r_obj) ' m r_rasp=' num2str(r_rasp) ' m'])
disp(['r_cam=' num2str(r_cam)])

pix_rh = tand(AH/2)*r_cam/(cam_HPX/2)*1000;
pix_rw = tand(AW/2)*r_cam/(cam_WPX/2)*1000;
fov_rh = 2*tand(AH/2)*r_cam*1000;
fov_rw = 2*tand(AW/2)*r_cam*1000;
disp(['fov_rh=' num2str(fov_rh,'%3.0f') ' mm fov_rw=' num2str(fov_rw,'%3.0f') ' mm'])
disp(['pix_rh=' num2str(pix_rh,'%3.1f') ' mm pix_rw=' num2str(pix_rw,'%3.1f') ' mm'])


