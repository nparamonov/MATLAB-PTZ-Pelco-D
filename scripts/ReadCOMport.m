%
%   Read COM port with const BaudRate
%   Reading stops when new command wasn't received during timeout
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
Timeout     = 60.0;     % [sec] Max waiting time after which the script exits

%% Establish connection to COM port

s=serial(COMport,'BaudRate',BaudRate);
set(s,'DataBits',DataBits);
set(s,'Timeout',Timeout);
fopen(s);
fprintf('Connected to %s with BaudRate %d\n',COMport,BaudRate); 

%% Read COM port

c = warning('error','MATLAB:serial:fread:unsuccessfulRead'); % Set warning to temporarily issue error (exception)

commands = 0;
fprintf('Start reading with max timeout = %d s\n',Timeout);
while 1
    try
        data=fread(s,7);
        c=clock;
        fix(c);
        fprintf('%d.%d.%d %d:%02d:%02d',round(c));
        fprintf('%11d%5d%5d%5d%5d%5d%5d\n',data);
        commands = commands+1;
    catch ME
        fprintf('The specified amount of data was not returned within the Timeout period = %d s\n',Timeout);
        break;
    end;
end;
fprintf('Finish reading. %d commands received\n',commands);

%% Close connection to COM port

fclose(s);
fprintf('Disconnected from %s\n',COMport);

%warning(c); % Restore the warning back to its previous (non-error) state