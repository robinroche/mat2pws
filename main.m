% Robin Roche, 2012
% University of Technology of Belfort-Montbéliard, France

% Establishes a COM connection between Matlab and PowerWorld
% Requires PowerWorld Simulator with the SimAuto add-on
% Tested with PowerWorld Simulator 16

clc
clear all


%% Establish a connection with PowerWorld / SimAuto

disp('>> Connecting to PowerWorld Simulator / SimAuto...')
A = actxserver('pwrworld.SimulatorAuto');
disp('Connection established')


%% Open case

disp('>> Opening case');
pwFile = strcat(pwd,'\ieee14.PWB');
simOutput = A.OpenCase(pwFile);
if ~(strcmp(simOutput{1},''))
    disp(simOutput{1})
else
    disp('Case opened');
end


%% Get the list of fields for a type of device

% Note: you can use this to know which fields to include when
% getting/changing parameters of devices.
% Fields with a number in the first column are compulsory.

disp('>> Getting the list of fields');
type = 'Branch'; % Others: Load, Gen, Branch, ...
simOutput = A.GetFieldList(type);
if ~(strcmp(simOutput{1},''))
    disp(simOutput{1})
else
    disp('List of fields for generators:')
    disp([char(simOutput{2,1}(:,1)), char(simOutput{2,1}(:,2)), ...
        char(simOutput{2,1}(:,3))]);
end


%% Get the list of devices

disp('>> Listing devices')
type = 'Gen'; % Others: Load, Gen, Branch, ...
simOutput = A.ListOfDevices(type,'');
if ~(strcmp(simOutput{1},''))
    disp(simOutput{1})
else
    disp('List of generators:')
    disp(double(transpose(simOutput{2}{1})));
end


%% Get the parameters of a device

disp('>> Getting device parameters')
type = 'Gen';
fields = {'BusNum','GenId','GenMWMax','GenStatus'};
values = {3,1,0,''};
simOutput = A.GetParametersSingleElement(type,fields,values);
if ~(strcmp(simOutput{1},''))
    disp(simOutput{1})
else
    disp('List of generator parameters:')
    disp(char(simOutput{2,1}));
end


%% Switch to edit mode

disp('>> Switching to edit mode')
scriptcommand = 'EnterMode(EDIT)';
simOutput = A.RunScriptCommand(scriptcommand);
if ~(strcmp(simOutput{1},''))
    disp(simOutput{1})
else
    disp('Switched to edit mode');
end


%% Change the parameters of a device

disp('>> Changing device parameters')
type = 'Gen';
fields = {'BusNum','GenId','GenMWMax','GenStatus'};
values = {3,1,120,'Open'};
% Note: fields and values must be the same size, only the compuslory fields
% are read.
simOutput = A.ChangeParametersSingleElement(type, fields, values);
if ~(strcmp(simOutput{1},''))
    disp(simOutput{1})
else
    disp('Generator parameters changed');
end


%% Get the parameters of a device [checking]

disp('>> Getting device parameters [to check the changes]')
type = 'Gen';
fields = {'BusNum','GenId','GenMWMax','GenStatus'};
values = {3,1,0,''};
simOutput = A.GetParametersSingleElement(type,fields,values);
if ~(strcmp(simOutput{1},''))
    disp(simOutput{1})
else
    disp('List of generator parameters:')
    disp(char(simOutput{2,1}));
end


%% Get the parameters of all devices of a type

disp('>> Getting the parameters of all devices of a type')
type = 'Branch';
fields = {'BusNum','BusNum:1','LineCircuit','LineStatus'};
simOutput = A.GetParametersMultipleElement(type, fields, '');
if ~(strcmp(simOutput{1},''))
    disp(simOutput{1})
else
    disp('List of branch parameters:')
            disp([...
            char(simOutput{2,1}{1,1}), ...
            char(simOutput{2,1}{2,1}), ...
            char(simOutput{2,1}{3,1}), ...
            char(simOutput{2,1}{4,1}) ]);
end


%% Change the parameters of several devices of a type

disp('>> Changing parameters of several devices')
type = 'Branch';
fields = {'BusNum','BusNum:1','LineCircuit','LineStatus'};
nbElements = 3;
values = {1,2,1,'Open',1,5,1,'Open',2,3,1,'Open'};
% Note: values is of size nbElements*length(fields)
simOutput = A.ChangeParametersMultipleElementFlatInput(type, fields, nbElements, values);
if ~(strcmp(simOutput{1},''))
    disp(simOutput{1})
else
    disp('Branches parameters changed');
end


%% Get the parameters of all devices of a type [for checking]

disp('>> Getting the parameters of all devices of a type [to check the changes]')
type = 'Branch';
fields = {'BusNum','BusNum:1','LineCircuit','LineStatus'};
simOutput = A.GetParametersMultipleElement(type, fields,'');
if ~(strcmp(simOutput{1},''))
    disp(simOutput{1})
else
    disp('List of branch parameters:')
            disp([...
            char(simOutput{2,1}{1,1}), ...
            char(simOutput{2,1}{2,1}), ...
            char(simOutput{2,1}{3,1}), ...
            char(simOutput{2,1}{4,1}) ]);
end


%% Switch to run mode

disp('>> Switching to run mode')
scriptcommand = 'EnterMode(RUN)';
simOutput = A.RunScriptCommand(scriptcommand);
if ~(strcmp(simOutput{1},''))
    disp(simOutput{1})
else
    disp('Switched to run mode');
end


%% Run a power flow

% Note: you need to be in run mode to do that
% You can also change the power flow algorithm

disp('>> Running power flow')
scriptcommand = 'SolvePowerFlow(RECTNEWT)';
simOutput = A.RunScriptCommand(scriptcommand);
if ~(strcmp(simOutput{1},''))
    disp(simOutput{1})
else
    disp('Power flow run successfully');
end


%% Save to a new file

disp('>> Saving file')
newpwFile = strcat(pwd,'\ieee14_edit.PWB');
simOutput = A.SaveCase(newpwFile, 'PWB', true);
if ~(strcmp(simOutput{1},''))
    disp(simOutput{1})
else
    disp('File saved');
end


%% Close the case in PowerWorld

disp('>> Closing case')
simOutput = A.CloseCase;
if ~(strcmp(simOutput{1},''))
    disp(simOutput{1})
else
    disp('Case closed');
end

    
%% Close the connection with PowerWorld SimAuto

delete(A);
disp('>> Connection ended')
