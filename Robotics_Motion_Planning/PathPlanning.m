function varargout = PathPlanning(varargin)
% PATHPLANNING MATLAB code for PathPlanning.fig
%      PATHPLANNING, by itself, creates a new PATHPLANNING or raises the existing
%      singleton*.
%
%      H = PATHPLANNING returns the handle to a new PATHPLANNING or the handle to
%      the existing singleton*.
%
%      PATHPLANNING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PATHPLANNING.M with the given input arguments.
%
%      PATHPLANNING('Property','Value',...) creates a new PATHPLANNING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PathPlanning_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PathPlanning_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PathPlanning

% Last Modified by GUIDE v2.5 08-Dec-2017 01:43:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PathPlanning_OpeningFcn, ...
                   'gui_OutputFcn',  @PathPlanning_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before PathPlanning is made visible.
function PathPlanning_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PathPlanning (see VARARGIN)

% Choose default command line output for PathPlanning
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
clearvars -global;
ah = axes('unit', 'normalized', 'position',[0 0 1 1]);
uistack(ah,'bottom');
bckImg= imread('backGround4.jpeg');
imagesc(bckImg);
set(ah,'handlevisibility','off','visible','off');

% UIWAIT makes PathPlanning wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PathPlanning_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in runRRTBtn.
function runRRTBtn_Callback(hObject, eventdata, handles)
global elapsedTime1;
global elapsedTime2;

if ((size(elapsedTime1,1) == 0) && (size(elapsedTime2,1) == 0))
    set(handles.timeTxt1,'Visible','off');
    set(handles.timeTxt1,'String','');
    set(handles.timeTxt2,'Visible','off');
    set(handles.timeTxt2,'String','');
else
    set(handles.timeTxt1,'Visible','off');
    set(handles.timeTxt1,'String','');
end

set(handles.errorTxt,'String','');
set(handles.errorTxt,'Visible','off');


    
cla(handles.axesCompare,'reset');
cla(handles.axesRRT,'reset');
cla(handles.axesPRM,'reset');

set(handles.runRRTBtn,'Enable','off');
set(handles.compareBtn,'Enable','off');
set(handles.runPRMBtn,'Enable','off');
axes(handles.axesRRT);
[elapsedTime,message] = rrtStart;

if(message ~= "")
    set(handles.errorTxt,'Visible','on');
    set(handles.errorTxt,'String',message);
else
    msg1 = sprintf('%s%s','RRT Total Elapsed Time: ',elapsedTime(1,1));
    set(handles.timeTxt1,'String',msg1);
    set(handles.timeTxt1,'Visible','on');
end
elapsedTime1 = sum(elapsedTime);

if ((size(elapsedTime1,1) ==1) && (size(elapsedTime2,1) == 1))
    set(handles.compareBtn,'Enable','on');
    set(handles.runPRMBtn,'Enable','off');
    set(handles.runRRTBtn,'Enable','off');
elseif(message ~= "")
    set(handles.compareBtn,'Enable','off');
    set(handles.runPRMBtn,'Enable','off'); 
    set(handles.runRRTBtn,'Enable','on');
else 
    set(handles.compareBtn,'Enable','off');
    set(handles.runPRMBtn,'Enable','on');
end 
%handles.elapsedTimeRRT = elapsedTime1;
% hObject    handle to runRRTBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function runRRTBtn_CreateFcn(hObject, eventdata, handles)

% hObject    handle to runRRTBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in runPRMBtn.
function runPRMBtn_Callback(hObject, eventdata, handles)
global elapsedTime1;
global elapsedTime2;

if ((size(elapsedTime1,1) == 0) && (size(elapsedTime2,1) == 0))
    set(handles.timeTxt1,'Visible','off');
    set(handles.timeTxt1,'String','');
    set(handles.timeTxt2,'Visible','off');
    set(handles.timeTxt2,'String','');
else
    set(handles.timeTxt2,'Visible','off');
    set(handles.timeTxt2,'String','');
end
    
set(handles.errorTxt,'Visible','off');
set(handles.errorTxt,'String','');

    
cla(handles.axesCompare,'reset');
cla(handles.axesPRM,'reset');
cla(handles.axesRRT,'reset');

set(handles.runPRMBtn,'Enable','off');
set(handles.compareBtn,'Enable','off');
set(handles.runRRTBtn,'Enable','off');
axes(handles.axesPRM);
[elapsedTime,message] = prmPathPlan;

if(message ~= "")
    set(handles.errorTxt,'Visible','on');
    set(handles.errorTxt,'String',message);
else
    msg1 = sprintf('%s\n%s%s\n%s%s\n%s%s\n%s%s',...
        'PRM Path Planning',...
        'Nodes Generation: ',elapsedTime(1,1),...
        'Finding K nearest neighbours: ',elapsedTime(1,2),...
        'Finding shortest path: ',elapsedTime(1,3),...
        'Total Elapsed Time: ',sum(elapsedTime));
    set(handles.timeTxt2,'String',msg1);
    set(handles.timeTxt2,'Visible','on');
    
end

elapsedTime2 = sum(elapsedTime);
if ((size(elapsedTime1,1) == 1) && (size(elapsedTime2,1) == 1))
    set(handles.compareBtn,'Enable','on');
    set(handles.runPRMBtn,'Enable','off');
    set(handles.runRRTBtn,'Enable','off');
elseif(message ~= "")
    set(handles.compareBtn,'Enable','off');
    set(handles.runPRMBtn,'Enable','on'); 
    set(handles.runRRTBtn,'Enable','off');
else
    set(handles.compareBtn,'Enable','off');
    set(handles.runRRTBtn,'Enable','on');
end 
%handles.elapsedTimePRM = elapsedTime2;

% hObject    handle to runPRMBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function runPRMBtn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to runPRMBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in compareBtn.
function compareBtn_Callback(hObject, eventdata, handles)
global elapsedTime1;
global elapsedTime2;

cla(handles.axesCompare);
axes(handles.axesCompare);
%rTime = elapsedTime1;
%pTime = elapsedTime2;
%rTime = handles.elapsedTime1;
%pTime = handles.elapsedTime2;
%elapsedTime = reshape([rTime(1+rem(0:max(numel(rTime),numel(pTime))-1, numel(rTime)));...
%                       pTime(1+rem(0:max(numel(rTime),numel(pTime))-1, numel(pTime)))],1,[]);
elapsedTime = [elapsedTime1 elapsedTime2; 0 0;];

bar(elapsedTime);
set(handles.runPRMBtn,'Enable','on');
set(handles.runRRTBtn,'Enable','on');
set(handles.compareBtn,'Enable','off');
clearvars -global;


% hObject    handle to compareBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function compareBtn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to compareBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in lookUpBtn.
function lookUpBtn_Callback(hObject, eventdata, handles)
open('PRM_project_report.pdf');
% hObject    handle to lookUpBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function lookUpBtn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lookUpBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function popupmenu9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
