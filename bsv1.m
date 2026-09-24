%%
%step 1
load carsmall.mat 
who %load
plot(Displacement,Horsepower,'.b');
xlabel('Displacement')
ylabel('Horespower')
%%
%step 2
Plot(Horsepower,MPG,'.r') 
xlabel('Horsepower')
ylabel('MPG')

%%
% step 3
%testData = {'ID',"name"} %maybe a way to make test data strucutre 
testData.ID = 9;
testData.name = 'tom';
testData.time = [0:.025:2]
testData.voltage= sin(2*pi*testData.time)
%ID = range(0,2)
%for n in range(0,2)
   % testData.ID = (.025+n);
plot(testData.time,testData.voltage,'.g')
xlabel('Time')
ylabel('Voltage')
%%
testData(2).ID = 15;
testData(2).name = 'Sean'
testData(2).time = testData(1).time
testData(2).voltage= sin(1.5*2*pi*testData(1).time)
%%
xlabel('Time')
ylabel('Patient Voltage')
for i = 1:length(testData)
    plot(testData(i).time,testData(i).voltage)
hold on
end
legend('Patient 1 (Tom)','Patient 2 (Sean)')
%voltage is y axis 
%x axis is time
%%
%filter design step 5
f0rder = 4; %filter order
f1 = 50; %half power frequency in HZ
sampleRate = 1000; %sample rate in Hz  %this is from the video l03
filter0bj = designfilt('highpassiir','FilterOrder',f0rder,'HalfPowerFrequency',f1,'SampleRate',sampleRate);
fvtool(filter0bj,'Analysis','Magnitude')
filter0bj = designfilt(filter0bj)
fvtool(filterobj)

%%
%Step 6     
t = 0:1/10:2;   %i made it 10hz instead of 1khz so i can see it closer 
wave1= sin(2*pi*1*t);  
wave60= sin(2*pi*60*t); 
x= wave1 + wave60; 
y= filter(filter0bj, x);
yff= filtfilt(filter0bj, x);
figure
plot(t, x)
hold on
plot(t, y)
plot(t, yff)
hold off
xlabel('Time (s)')
ylabel('Signal')
legend('Original','Filtered with filter','Filtered with filtfilt')
%%
%Step 7
sr=1000 %sample rate 
t2= 0:1/sr:.2;   %step stize I made it 10 to see it closer 
wave12 = 1*sin(2*pi*12*t2); %12 Hz wave
wave60 = 1*sin(2*pi*60*t2); %60 Hz wave again
x2 = wave12 + wave60;
forder = 6;
fc = 60;
lpf = designfilt('lowpassiir','FilterOrder',forder,'HalfPowerFrequency',fc,'SampleRate',sr); % cahnge the 10 to sr in sample rate to make it actually cahnge nvm needs to be kept in var i thnk 
y2f= filter(lpf, x2);
y2ff = filtfilt(lpf, x2);
figure
plot(t2, x2)
hold on
plot(t2, y2f)
plot(t2, y2ff)
hold off
xlabel('Time (s)')
ylabel('Signal')
legend('Og','LP filter','Lp ff')
%%
%Step 8
%on a new page 