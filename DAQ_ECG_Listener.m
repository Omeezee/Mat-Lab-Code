function DAQ_ECG_Listener(src,event,app)
%% This function is called whenever the DAQ has data that is ready to transfer to the PC.
% this occurs ever 1/10 second during recording; the data is processed in
% small chunks. 

%inputs:
%src: the session object (same as app.sesh in the calling GUI)

%event: struct containing that data for the most recent aquisition.
% event.TriggerTime : time that the first datapoint in this set of data was recorded
% event.Data : The data recorded in 1/10 second (a vector)
% event.TimeStamps : Time vector for the data
% event.Source : the session object used to record (same as src above)
% event.EventName : this should be a string 'DataAvailable'

% app : your app structure, which contains all the object and their properties (e.g.
% button values) and the properties (variables) you've defined (e.g.
% app.data, app. time)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% ADD YOUR CODE HERE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1) concatenate current readings with last readings, store in app
% properties %plot(app.UIAxes,event.TimeStamps,event.Data)
app.time = [app.time event.TimeStamps'];
app.data = [app.data event.Data'];
% 2) Delete out of range data (less than the end time minus app.winSize)
% %i used ai for this part 2 thing 
tEnd = app.time(end);
validIdx = app.time >= (tEnd - (app.winSize));
 
app.time = app.time(validIdx);
app.data = app.data(validIdx);
% plot(app.UIAxes, app.time, app.data)
% %3) do beat detection (call your HR_Detect script)


 [VFilt, vInt, locs] = HR_detect(app.data, src.Rate, app.filterObj);

% if MPD < length(V) % look for peaks when signal is longer than 0.2 s
%  [~, locs] = findpeaks(vInt, 'MinPeakDistance', MPD, ...
%  'MinPeakHeight', MPH);
% else
%  locs = []; % if not looking for peaks set locs to empty
% end


% %4) Do plots: conditional statements for check boxes, and the plotting
% % commands
% plot(app.UIAxes, app.time, app.data)
hold(app.UIAxes,'off')
% % i used gpt
% % plot detected beats if any
     if app.VoltageCheckBox.Value 
         plot(app.UIAxes,app.time,app.data)
         hold(app.UIAxes,'on')
     end
     if app.FilteredCheckBox.Value
         plot(app.UIAxes,app.time,VFilt)
         hold(app.UIAxes,'on')
     end
    
     if app.HeartBeatCheckBox.Value && ~isempty(locs)
         plot(app.UIAxes,app.time(locs),VFilt(locs),'o')
         hold(app.UIAxes,'on')
     end


% %set x-axis limits
xlim(app.UIAxes,[(app.time(1)) app.time(end)])
ylim(app.UIAxes,[min(app.data) max(app.data)])
% %5) Calculate heart rate, add to plot title
 HR = NaN;
% 
if length(locs) > 1
    RR = diff(app.time(locs));   % time between beats
    HR = 60/mean(RR);            % bpm
end

title(app.UIAxes, sprintf('Heart Rate: %.1f BPM', HR))

%Set title of plot to be heart rate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%