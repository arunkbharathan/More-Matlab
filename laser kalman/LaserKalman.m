
% Access and configure a device. 
vid = videoinput('winvideo', 1, 'RGB24_640x480');
set(vid, 'FramesPerTrigger', 1);
set(vid, 'TriggerRepeat', Inf);
triggerconfig(vid,'manual')
clear global  x_est p_est

%%

% Using the preview window, request that the camera be positioned such
% that the view is of the blue box and little else.





%% Laser Tracking
kk=zeros(6, 1);
figure
start(vid)
for i = 1:50
    % Acquire an image frame and determine the 
    % camera pixel coordinates.
     trigger(vid);
    frame = getdata(vid, 1);
    [x, y] = utilfindlaser(frame);    
z=[x;y];
%      [z k] = kalmanfilter([x;y]);
%      kk=[kk k];
    imagesc(frame);hold on
    plot(z(1), z(2), 'gO')
plot([1 size(frame, 2)], [z(2) z(2)], 'y-')
plot([z(1) z(1)], [1 size(frame, 1)], 'y-')
flushdata(vid);
end




% Stop the acquisition, remove the object from memory,
% and clear the variable.

delete(vid)
clear vid

