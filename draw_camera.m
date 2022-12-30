function [] = draw_camera(x,y,z,a,b,g,d,AH,AW,cam_size,cam_color)
%DRAW_CAMERA 
%   draw camera in 3d using internal matlab function plotCamera
%   x,y,z = cartesian coordinates of camera
%   a, b, g = euler angles of camera direction (alpha beta gamma)
%   d = distance from camera to object
%  AH  = vertical camera view angle in deg
%  AW  = horizontal camera  view angle in deg 
%  cam_size = 1.0 - size of camera
%  cam_color = [1 0 0]  RGB color of camera
trans = [x,y,z];
% camera points up so we rotate it along y axis 90 cw
% also camera is rotated 90 along z axis ccw
% to match height and width (otherwise height will be width and vice versa)
r0 = eul2rotm([pi/2 -pi/2 0],'ZYX');
r1 = eul2rotm([a b g],'ZYX');
rot = r0*r1;
R      = rigid3d(rot,trans);
%cam2 = plotCamera('AbsolutePose',R,'Opacity',0,'Size', 1);
cam2 = plotCamera('AbsolutePose',R,'Opacity',0,'Size', cam_size,'Color', cam_color);

LC = [ 0 0 ; 
          0 0 ; 
          0 d]; % center line
LC   = (LC'*rot)'; % rotate
LC   = [LC(1,:)+x;LC(2,:)+y;LC(3,:)+z]; % shift
plot3(LC(1,:),LC(2,:),LC(3,:),'g');

cH  = tand(AH/2)*d;
cW = tand(AW/2)*d;
LW1 = [0 +cW; 
            0 0 ;
            0 d];
LW2 = [0 -cW; 
            0 0; 
            0 d];
LH1 = [0 0; 
            0 +cH ;
            0 d];
LH2 = [0 0; 
            0 -cH; 
            0 d];
LW1   = (LW1'*rot)'; % rotate
LW1   = [LW1(1,:)+x;LW1(2,:)+y;LW1(3,:)+z]; % shift
plot3(LW1(1,:),LW1(2,:),LW1(3,:),'r');
LW2   = (LW2'*rot)'; % rotate
LW2   = [LW2(1,:)+x;LW2(2,:)+y;LW2(3,:)+z]; % shift
plot3(LW2(1,:),LW2(2,:),LW2(3,:),'r');

LH1   = (LH1'*rot)'; % rotate
LH1   = [LH1(1,:)+x;LH1(2,:)+y;LH1(3,:)+z]; % shift
plot3(LH1(1,:),LH1(2,:),LH1(3,:),'m');
LH2   = (LH2'*rot)'; % rotate
LH2   = [LH2(1,:)+x;LH2(2,:)+y;LH2(3,:)+z]; % shift
plot3(LH2(1,:),LH2(2,:),LH2(3,:),'m');
end

