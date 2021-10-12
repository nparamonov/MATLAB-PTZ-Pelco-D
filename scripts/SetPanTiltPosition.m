%
%   PTZ device control with Pelco D protocol
%   Set the pan or tilt position of the device in degrees
%

%% 

close all
clear all
clc

%% Configuration

COMport     = 'COM6';   % From the device manager when connecting the interface converter USB-RS485
BaudRate	= 2400;     % Baud rate
DataBits	= 8;        % Default for Pelco D
StopBits	= 1.0;      % Default for Pelco D

AddressPTZ	= 1;        % Address of the receiver/driver device being controlled with Pelco D

%% Establish connection to COM port

s=serial(COMport,'BaudRate',BaudRate);
set(s,'DataBits',DataBits);
set(s,'StopBits',StopBits);
fopen(s);
fprintf('Connected to %s with BaudRate %d\n',COMport,BaudRate);

%% Set Pan Position

[degpan] = input('> Set Pan Position [deg]: ');
% Hundredths of a degree (0..35999)
degpan = degpan * 100;
if (degpan > 0) 
	degpan = 36000 - degpan;
end
if (degpan < 0) 
	degpan = -degpan;
end
% 2 data bytes
degpan = typecast(uint16(degpan),'uint8');
pan1 = degpan(2);
pan2 = degpan(1);
% Send command
fwrite(s,[255,AddressPTZ,0,75,pan1,pan2,mod((75+int32(AddressPTZ)+int32(pan1)+int32(pan2)),256)],'uint8');
fprintf('Pan has been set\n');

%% Set Tilt Position

degtilt = input('> Set Tilt Position [deg]: ');
% Hundredths of a degree (0..35999)
degtilt = degtilt * 100;
if (degtilt > 0) 
    degtilt = 36000 - degtilt;
end
if (degtilt < 0) 
    degtilt = -degtilt;
end
% 2 data bytes
degtilt = typecast(uint16(degtilt),'uint8');
tilt1 = degtilt(2);
tilt2 = degtilt(1);
% Send command
fwrite(s,[255,AddressPTZ,0,77,tilt1,tilt2,mod((77+int32(AddressPTZ)+int32(tilt1)+int32(tilt2)),256)],'uint8');
fprintf('Tilt has been set\n');

%% Close connection to COM port

fclose(s);
fprintf('Disconnected from %s\n',COMport);