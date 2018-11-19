function varargout = pacejka4(varargin)
% PACEJKA4 M-file for pacejka4.fig
%      PACEJKA4, by itself, creates a new PACEJKA4 or raises the existing
%      singleton*.
%
%      H = PACEJKA4 returns the handle to a new PACEJKA4 or the handle to
%      the existing singleton*.
%
%      PACEJKA4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PACEJKA4.M with the given input arguments.
%
%      PACEJKA4('Property','Value',...) creates a new PACEJKA4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pacejka4_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pacejka4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pacejka4

% Last Modified by GUIDE v2.5 08-Sep-2008 16:34:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pacejka4_OpeningFcn, ...
                   'gui_OutputFcn',  @pacejka4_OutputFcn, ...
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


% --- Executes just before pacejka4 is made visible.
function pacejka4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pacejka4 (see VARARGIN)

% Choose default command line output for pacejka4
handles.output = hObject;
handles.slip=0:.5:25;

W1= str2double(get(handles.cload1,'string'));
W2= str2double(get(handles.cload2,'string'));

handles.load1=9.8*W1*ones(length(handles.slip),1);
handles.load2=9.8*W2*ones(length(handles.slip),1);

B  = get(handles.B_slider,'value');
C  = get(handles.C_slider,'value');
D1 = get(handles.D1_slider,'value');
D2 = get(handles.D2_slider,'value');
D  = (D1+D2/1000*W1)*W1;
set(handles.bcd,'string',num2str(B*C*D/W1));

f0=[D1 D2 B C];
handles.p=plot(handles.slip,lapsim_fit(f0,[handles.slip',handles.load1]),handles.slip,lapsim_fit(f0,[handles.slip',handles.load2]));
grid on
xlabel('Slip Angle')
ylabel('Lateral Force')

legend(['W1 = ' num2str(W1) 'kg'],['W2 = ' num2str(W2) 'kg'])
legend boxoff
title('Example Lapsim Tire Specification:')
handles.txt=text(-25,0,['B=' num2str(f0(3)) ' ,C=' num2str(f0(4)) ' ,D1=' num2str(f0(1)) ' ,D2=' num2str(f0(2))],'Fontweight','bold');
sidetext('william.a.cobb@gm.com')
guidata(hObject, handles);

% UIWAIT makes pacejka4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pacejka4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function cload1_Callback(hObject, eventdata, handles)
% hObject    handle to cload1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cload1 as text
%        str2double(get(hObject,'String')) returns contents of cload1 as a double
W1= str2double(get(handles.cload1,'string'));
W2= str2double(get(handles.cload2,'string'));
handles.load1=9.8*W1*ones(length(handles.slip),1);
handles.load2=9.8*W2*ones(length(handles.slip),1);
B  = get(handles.B_slider,'value');
C  = get(handles.C_slider,'value');
D1= get(handles.D1_slider,'value');
D2 = get(handles.D2_slider,'value');
D  = (D1+D2/1000*W1)*W1
set(handles.bcd,'string',num2str(B*C*D/W1));
f0 =[D1 D2 B C];
y1=lapsim_fit(f0,[handles.slip',handles.load1]);
y2=lapsim_fit(f0,[handles.slip',handles.load2]);
set(handles.p(1),'YData',y1)
set(handles.p(2),'YData',y2)



% --- Executes during object creation, after setting all properties.
function cload1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cload1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cload2_Callback(hObject, eventdata, handles)
% hObject    handle to cload2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cload2 as text
%        str2double(get(hObject,'String')) returns contents of cload2 as a double
W1= str2double(get(handles.cload1,'string'));
W2= str2double(get(handles.cload2,'string'));
handles.load1=9.8*W1*ones(length(handles.slip),1);
handles.load2=9.8*W2*ones(length(handles.slip),1);
B  = get(handles.B_slider,'value');
C  = get(handles.C_slider,'value');
D1= get(handles.D1_slider,'value');
D2 = get(handles.D2_slider,'value');
D  = (D1+D2/1000*W1)*W1
set(handles.bcd,'string',num2str(B*C*D/W1));
f0=[D1 D2 B C];
y1=lapsim_fit(f0,[handles.slip',handles.load1]);
y2=lapsim_fit(f0,[handles.slip',handles.load2]);
set(handles.p(1),'YData',y1)
set(handles.p(2),'YData',y2)


% --- Executes during object creation, after setting all properties.
function cload2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cload2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function B_slider_Callback(hObject, eventdata, handles)
% hObject    handle to B_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
W1= str2double(get(handles.cload1,'string'));
W2= str2double(get(handles.cload2,'string'));
handles.load1=9.8*W1*ones(length(handles.slip),1);
handles.load2=9.8*W2*ones(length(handles.slip),1);
B  = get(handles.B_slider,'value');
C  = get(handles.C_slider,'value');
D1 = get(handles.D1_slider,'value');
D2 = get(handles.D2_slider,'value');
D  = (D1+D2/1000*W1)*W1;
set(handles.bcd,'string',num2str(B*C*D/W1));

f0 = [D1 D2 B C];
y1 = lapsim_fit(f0,[handles.slip',handles.load1]);
y2 = lapsim_fit(f0,[handles.slip',handles.load2]);
set(handles.p(1),'YData',y1)
set(handles.p(2),'YData',y2)
set(handles.txt,'String',['B=' num2str(f0(3)) ' ,C=' num2str(f0(4)) ' ,D1=' num2str(f0(1)) ' ,D2=' num2str(f0(2))])

% --- Executes during object creation, after setting all properties.
function B_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function C_slider_Callback(hObject, eventdata, handles)
% hObject    handle to C_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
W1= str2double(get(handles.cload1,'string'));
W2= str2double(get(handles.cload2,'string'));
handles.load1=9.8*W1*ones(length(handles.slip),1);
handles.load2=9.8*W2*ones(length(handles.slip),1);
B  = get(handles.B_slider,'value');
C  = get(handles.C_slider,'value');
D1 = get(handles.D1_slider,'value');
D2 = get(handles.D2_slider,'value');
D  = (D1+D2/1000*W1)*W1;
set(handles.bcd,'string',num2str(B*C*D/W1));

f0=[D1 D2 B C];
y1=lapsim_fit(f0,[handles.slip',handles.load1]);
y2=lapsim_fit(f0,[handles.slip',handles.load2]);
set(handles.p(1),'YData',y1)
set(handles.p(2),'YData',y2)
set(handles.txt,'String',['B=' num2str(f0(3)) ' ,C=' num2str(f0(4)) ' ,D1=' num2str(f0(1)) ' ,D2=' num2str(f0(2))])


% --- Executes during object creation, after setting all properties.
function C_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function D1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to D1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
W1= str2double(get(handles.cload1,'string'));
W2= str2double(get(handles.cload2,'string'));
handles.load1=9.8*W1*ones(length(handles.slip),1);
handles.load2=9.8*W2*ones(length(handles.slip),1);
B  = get(handles.B_slider,'value');
C  = get(handles.C_slider,'value');
D1 = get(handles.D1_slider,'value');
D2 = get(handles.D2_slider,'value');
D  = (D1+D2/1000*W1)*W1;
set(handles.bcd,'string',num2str(B*C*D/W1));

f0=[D1 D2 B C];
y1=lapsim_fit(f0,[handles.slip',handles.load1]);
y2=lapsim_fit(f0,[handles.slip',handles.load2]);
set(handles.p(1),'YData',y1)
set(handles.p(2),'YData',y2)
set(handles.txt,'String',['B=' num2str(f0(3)) ' ,C=' num2str(f0(4)) ' ,D1=' num2str(f0(1)) ' ,D2=' num2str(f0(2))])


% --- Executes during object creation, after setting all properties.
function D1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to D1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function D2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to D2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
W1= str2double(get(handles.cload1,'string'));
W2= str2double(get(handles.cload2,'string'));
handles.load1=9.8*W1*ones(length(handles.slip),1);
handles.load2=9.8*W2*ones(length(handles.slip),1);
B  = get(handles.B_slider,'value');
C  = get(handles.C_slider,'value');
D1 = get(handles.D1_slider,'value');
D2 = get(handles.D2_slider,'value');
D  = (D1+D2/1000*W1)*W1;
set(handles.bcd,'string',num2str(B*C*D/W1));

f0=[D1 D2 B C];
y1=lapsim_fit(f0,[handles.slip',handles.load1]);
y2=lapsim_fit(f0,[handles.slip',handles.load2]);
set(handles.p(1),'YData',y1)
set(handles.p(2),'YData',y2)
set(handles.txt,'String',['B=' num2str(f0(3)) ' ,C=' num2str(f0(4)) ' ,D1=' num2str(f0(1)) ' ,D2=' num2str(f0(2))])


% --- Executes during object creation, after setting all properties.
function D2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to D2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in freeze_scale.
function freeze_scale_Callback(hObject, eventdata, handles)
% hObject    handle to freeze_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of freeze_scale
if get(handles.freeze_scale,'Value')
    axis manual
else 
    axis auto
end



% --- Executes on button press in constant_bcd.
function constant_bcd_Callback(hObject, eventdata, handles)
% hObject    handle to constant_bcd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of constant_bcd


