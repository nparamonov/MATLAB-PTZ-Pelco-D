%
%   ���������� PTZ ����������� � ���������� Pelco D
%   ����������� ��������� � ��������
%

%% 

close all
clear all
clc

%% �����������

COMport     = 'COM6';   % �� ���������� ��������� ��� ����������� ��������������� ����������� USB-RS485
BaudRate	= 2400;     % ������� ��������
DataBits	= 8;        % �������� �� ��������� ��� Pelco D
StopBits	= 1.0;      % �������� �� ��������� ��� Pelco D

AddressPTZ	= 1;        % ����� ���������� ��� ��������� Pelco D

%% ��������� ���������� � COM ������

s=serial(COMport,'BaudRate',BaudRate);
set(s,'DataBits',DataBits);
set(s,'StopBits',StopBits);
fopen(s);
fprintf('Connected to %s with BaudRate %d\n',COMport,BaudRate);

%% Set Pan Position

[degpan] = input('> Set Pan Position [deg]: ');
% ����� ���� ������� (0..35999)
degpan = degpan * 100;
if (degpan > 0) 
	degpan = 36000 - degpan;
end
if (degpan < 0) 
	degpan = -degpan;
end
% 2 ����� ����������
degpan = typecast(uint16(degpan),'uint8');
pan1 = degpan(2);
pan2 = degpan(1);
% �������� �������
fwrite(s,[255,AddressPTZ,0,75,pan1,pan2,mod((75+int32(AddressPTZ)+int32(pan1)+int32(pan2)),256)],'uint8');
fprintf('Pan has been set\n');

%% Set Tilt Position

degtilt = input('> Set Tilt Position [deg]: ');
% ����� ���� ������� (0..35999)
degtilt = degtilt * 100;
if (degtilt > 0) 
    degtilt = 36000 - degtilt;
end
if (degtilt < 0) 
    degtilt = -degtilt;
end
% 2 ����� ����������
degtilt = typecast(uint16(degtilt),'uint8');
tilt1 = degtilt(2);
tilt2 = degtilt(1);
% �������� �������
fwrite(s,[255,AddressPTZ,0,77,tilt1,tilt2,mod((77+int32(AddressPTZ)+int32(tilt1)+int32(tilt2)),256)],'uint8');
fprintf('Tilt has been set\n');

%% �������� ���������� � COM ������

fclose(s);
fprintf('Disconnected from %s\n',COMport);