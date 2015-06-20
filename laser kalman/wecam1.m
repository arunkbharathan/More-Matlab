clear
imaqhwinfo('winvideo', 1);
obj=videoinput('winvideo',1,'RGB24_640x480'); 
% preview(obj);
% Configure the trigger settings.
%           triggerconfig(obj, 'manual');
 
% obj.FrameGrabInterval=1;
 obj.FramesPerTrigger=1;
obj.TriggerFrameDelay=30;
% obj.ReturnedColorSpace='rgb';
        % Trigger the acquisition.
%          start(obj)
%          trigger(obj)
  obj.Timeout=30;
start(obj);
tic
% pause(3);
frame = getsnapshot(obj);toc
image(frame);
clear
imaqreset
