function varargout = DPABISurf_VIEW(varargin)
% DPABISURF_VIEW MATLAB code for DPABISurf_VIEW.fig
%      DPABISURF_VIEW, by itself, creates a new DPABISURF_VIEW or raises the existing
%      singleton*.
%
%      H = DPABISURF_VIEW returns the handle to a new DPABISURF_VIEW or the handle to
%      the existing singleton*.
%
%      DPABISURF_VIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DPABISURF_VIEW.M with the given input arguments.
%
%      DPABISURF_VIEW('Property','Value',...) creates a new DPABISURF_VIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DPABISurf_VIEW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DPABISurf_VIEW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DPABISurf_VIEW

% Last Modified by GUIDE v2.5 27-Feb-2019 00:34:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DPABISurf_VIEW_OpeningFcn, ...
                   'gui_OutputFcn',  @DPABISurf_VIEW_OutputFcn, ...
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


% --- Executes just before DPABISurf_VIEW is made visible.
function DPABISurf_VIEW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DPABISurf_VIEW (see VARARGIN)

handles.UnderlayFilePath='';
handles.OverlayInd=0;
handles.OverlayNegRatio=1;
handles.OverlayPosRatio=1;
handles.OverlayPosNegSync=true;
handles.LabelInd=0;

handles.ColorMapEnum={'Jet';...
    'HSV';...
    'Hot';...
    'Cool';...
    'Spring';...
    'Summer';...
    'Autumn';...
    'Winter';...
    'Gray';...
    'Bone';...
    'Pink';...
    'AFNI12'};


% Choose default command line output for DPABISurf_VIEW
handles.output = hObject;
axis(handles.SurfaceAxes, 'off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DPABISurf_VIEW wait for user response (see UIRESUME)
% uiwait(handles.MainFig);

% --- Outputs from this function are returned to the command line.
function varargout = DPABISurf_VIEW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function UnderlayMenu_Callback(hObject, eventdata, handles)
% hObject    handle to UnderlayMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateUnderlayFile(hObject);
% Hints: get(hObject,'String') returns contents of UnderlayMenu as text
%        str2double(get(hObject,'String')) returns contents of UnderlayMenu as a double

% --- Executes during object creation, after setting all properties.
function UnderlayMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UnderlayMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in UnderlayBtn.
function UnderlayBtn_Callback(hObject, eventdata, handles)
% hObject    handle to UnderlayBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.UnderlayBtn, 'Enable', 'Off');

[~, Fcn]=w_RenderSurf(handles.UnderlayFilePath, handles.SurfaceAxes);
handles.Fcn=Fcn;
guidata(hObject, handles);

function UpdateUnderlayFile(Obj)
DPABISurfPath=fileparts(which('DPABISurf.m'));
SurfTpmPath=fullfile(DPABISurfPath, 'SurfTemplates');

Handles=guidata(Obj);
HemiInd=get(Handles.HemiMenu, 'Value');
if HemiInd==1 % L
    HemiFlag='L';
elseif HemiInd==2 % R
    HemiFlag='R';
end

UnderlayInd=get(Handles.UnderlayMenu, 'Value');
switch UnderlayInd
    case 1
        return;
    case 2 % fsaverage_inflated
        if strcmpi(HemiFlag, 'L')
            UnderlayFilePath=fullfile(SurfTpmPath, ...
                'fsaverage_lh_inflated.surf.gii');
        else
            UnderlayFilePath=fullfile(SurfTpmPath, ...
                'fsaverage_rh_inflated.surf.gii');            
        end
    case 3 % fsaverage_white
        if strcmpi(HemiFlag, 'L')
            UnderlayFilePath=fullfile(SurfTpmPath, ...
                'fsaverage_lh_white.surf.gii');
        else
            UnderlayFilePath=fullfile(SurfTpmPath, ...
                'fsaverage_rh_white.surf.gii');            
        end        
    case 4 % fsaverage5_inflated
        if strcmpi(HemiFlag, 'L')
            UnderlayFilePath=fullfile(SurfTpmPath, ...
                'fsaverage5_lh_inflated.surf.gii');
        else
            UnderlayFilePath=fullfile(SurfTpmPath, ...
                'fsaverage5_rh_inflated.surf.gii');            
        end        
    case 5 % fsaverage5_white
        if strcmpi(HemiFlag, 'L')
            UnderlayFilePath=fullfile(SurfTpmPath, ...
                'fsaverage5_lh_white.surf.gii');
        else
            UnderlayFilePath=fullfile(SurfTpmPath, ...
                'fsaverage5_rh_white.surf.gii');            
        end               
    otherwise
        ObjTag=get(Obj, 'Tag');
        if strcmpi(ObjTag, 'UnderlayMenu')
            [File , Path]=uigetfile({'*surf.gii','Brain Surface (*.surf.gii)';...
                '*.gii', 'All GIfTI Files (*.gii)';'*.*', 'All Files (*.*)';}, ...
                'Pick Brain Surface File' , pwd);
            if isnumeric(File) && File==0
                return
            end
            UnderlayFilePath=fullfile(Path, File);
        else
            UnderlayFilePath=Handles.UnderlayFilePath;
        end
end
set(Handles.UnderlayBtn, 'Enable', 'On');
set(Handles.UnderlayEty, 'String', UnderlayFilePath);
Handles.UnderlayFilePath=UnderlayFilePath;
guidata(Obj, Handles);

function OverlayMenu_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OverlayInd=get(handles.OverlayMenu, 'Value');
handles.OverlayInd=OverlayInd;
guidata(hObject, handles);
UpdateOverlayConfig(hObject);
% Hints: get(hObject,'String') returns contents of OverlayMenu as text
%        str2double(get(hObject,'String')) returns contents of OverlayMenu as a double

% --- Executes during object creation, after setting all properties.
function OverlayMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in OverlayAddBtn.
function OverlayAddBtn_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayAddBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'UnderlayFilePath') || isempty(handles.UnderlayFilePath)
    errordlg('Please Indicate Underlay First!');
    return
end

if ~isfield(handles, 'Fcn')
    errordlg('Please Set Underlay First!');
    return
end

[File , Path]=uigetfile({'*.gii', 'All GIfTI Files (*.gii)';...
    '*.shape.gii;*.func.gii','Vertex Metric (*.shape.gii;*.func.gii)';...
    '*.*', 'All Files (*.*)';}, ...
    'Pick Vertex Metric File' , pwd);
if isnumeric(File) && File==0
    return
end

OverlayFile=fullfile(Path, File);
Fcn=handles.Fcn;
ExitCode=Fcn.AddOverlay(OverlayFile);
if ExitCode
    return
end
OverlayInd=numel(Fcn.GetOverlayFiles());
handles.OverlayInd=OverlayInd;
guidata(hObject, handles);

UpdateOverlayConfig(hObject);

function UpdateOverlayConfig(Obj)
Handles=guidata(Obj);
Fcn=Handles.Fcn;
OverlayFiles=Fcn.GetOverlayFiles();
OverlayInd=Handles.OverlayInd;
if ~isempty(OverlayFiles)
    BtnState='On';
    [~, NameList, ExtList]=cellfun(@(f) fileparts(f), OverlayFiles, 'UniformOutput', false);
    FileList=cellfun(@(f, e) [f, e], NameList, ExtList, 'UniformOutput', false);
    set(Handles.OverlayMenu, 'Enable', BtnState,...
        'String', FileList,...
        'Value', OverlayInd);
    set(Handles.OverlayRmBtn, 'Enable', BtnState);
    
    Thres=Fcn.GetOverlayThres(OverlayInd);
    set(Handles.OverlayNMaxEty, 'Enable', BtnState, 'String', num2str(Thres.NegMax));
    set(Handles.OverlayNMinEty, 'Enable', BtnState, 'String', num2str(Thres.NegMin));
    set(Handles.OverlayPMinEty, 'Enable', BtnState, 'String', num2str(Thres.PosMin));
    set(Handles.OverlayPMaxEty, 'Enable', BtnState, 'String', num2str(Thres.PosMax));
    set(Handles.OverlayThresNegSlider, 'Enable', BtnState, 'Value', 1-Handles.OverlayNegRatio);
    set(Handles.OverlayThresPosSlider, 'Enable', BtnState, 'Value', Handles.OverlayPosRatio);
    set(Handles.OverlayThresSyncBtn, 'Enable', BtnState, 'Value', Handles.OverlayPosNegSync);
    
    Opt=Fcn.GetOverlayThresPN_Flag(OverlayInd);
    ThresPN_Flag=Opt.ThresPN_Flag;
    PNF=false(3, 1);
    if isempty(ThresPN_Flag)
        PNF(3, 1)=true;
    elseif strcmpi(ThresPN_Flag, '+')
        PNF(1, 1)=true;
    elseif strcmpi(ThresPN_Flag, '-')
        PNF(2, 1)=true;
    end
    set(Handles.OverlayThresOnlyPosBtn, 'Enable', BtnState, 'Value', PNF(1));    
    set(Handles.OverlayThresOnlyNegBtn, 'Enable', BtnState, 'Value', PNF(2));
    set(Handles.OverlayThresFullBtn, 'Enable', BtnState, 'Value', PNF(3));

    Opt=Fcn.GetOverlayStatOption(OverlayInd);
    set(Handles.StatBtn, 'Enable', BtnState);
    set(Handles.OverlayTestFlagEty, 'Enable', BtnState, 'String', Opt.TestFlag);
    Opt=Fcn.GetOverlayPThres(OverlayInd);
    set(Handles.OverlayPThresEty, 'Enable', BtnState, 'String', num2str(Opt.PThres));
    
    Opt=Fcn.GetOverlayColorMap(OverlayInd);
    CmString=Opt.ColorMapString;
    CmInd=cellfun(@(s) strcmpi(CmString(1:3), s(1:3)), Handles.ColorMapEnum);
    CmInd=find(CmInd);
    if isempty(CmInd)
        CmInd=numel(ColorMapEnum)+1;
    end
    set(Handles.OverlayColorMenu, 'Enable', BtnState, ...
        'String', [Handles.ColorMapEnum; 'Customize...'], 'Value', CmInd);
    set(Handles.OverlayColorPNFlagMenu, 'Enable', BtnState);
    
    Opt=Fcn.GetOverlayAlpha(OverlayInd);
    set(Handles.OverlayAlphaSlider, 'Enable', BtnState, 'Value', Opt.Alpha);
    set(Handles.OverlayAlphaEty, 'Enable', BtnState, 'String', num2str(Opt.Alpha));
    
    Opt=Fcn.GetOverlayTimePoint(OverlayInd);
    set(Handles.OverlayTpEty, 'Enable', BtnState, 'String', num2str(Opt.CurTP));
    set(Handles.OverlayTcBtn, 'Enable', BtnState);
    
    set(Handles.OverlayFweOptBtn, 'Enable', BtnState);
    set(Handles.OverlayUtilitiesMenu, 'Enable', BtnState);
else
    BtnState='Off';
    FileList='Add Overlay...';
    set(Handles.OverlayMenu, 'Enable', BtnState,...
        'String', FileList,...
        'Value', OverlayInd);
    set(Handles.OverlayRmBtn, 'Enable', BtnState);
    set(Handles.OverlayNMaxEty, 'Enable', BtnState, 'String', '');
    set(Handles.OverlayNMinEty, 'Enable', BtnState, 'String', '');
    set(Handles.OverlayPMinEty, 'Enable', BtnState, 'String', '');
    set(Handles.OverlayPMaxEty, 'Enable', BtnState, 'String', '');    
    set(Handles.OverlayThresNegSlider, 'Enable', BtnState, 'Value', 0);
    set(Handles.OverlayThresPosSlider, 'Enable', BtnState, 'Value', 1);
    set(Handles.OverlayThresSyncBtn, 'Enable', BtnState, 'Value', 0);
    
    set(Handles.OverlayThresOnlyNegBtn, 'Enable', BtnState, 'Value', 0);
    set(Handles.OverlayThresOnlyPosBtn, 'Enable', BtnState, 'Value', 0);
    set(Handles.OverlayThresFullBtn, 'Enable', BtnState, 'Value', 0);
    
    set(Handles.StatBtn, 'Enable', BtnState);
    set(Handles.OverlayTestFlagEty, 'Enable', BtnState, 'String', 'NA');
    set(Handles.OverlayPThresEty, 'Enable', BtnState, 'String', '');       

    set(Handles.OverlayColorMenu, 'Enable', BtnState, ...
        'String', [Handles.ColorMapEnum; 'Customize...'], 'Value', 1);
    set(Handles.OverlayColorPNFlagMenu, 'Enable', BtnState);
    
    set(Handles.OverlayAlphaSlider, 'Enable', BtnState, 'Value', 1);
    set(Handles.OverlayAlphaEty, 'Enable', BtnState, 'String', '');
    
    set(Handles.OverlayTpEty, 'Enable', BtnState, 'String', '');
    set(Handles.OverlayTcBtn, 'Enable', BtnState);    
    
    set(Handles.OverlayFweOptBtn, 'Enable', BtnState);
    set(Handles.OverlayUtilitiesMenu, 'Enable', BtnState);    
end
Fcn.UpdateOverlay(OverlayInd);

function OverlayNMaxEty_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayNMaxEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fcn=handles.Fcn;
OverlayInd=handles.OverlayInd;

NMax=str2num(get(handles.OverlayNMaxEty, 'String'));
NMin=str2num(get(handles.OverlayNMinEty, 'String'));
PMin=str2num(get(handles.OverlayPMinEty, 'String'));
PMax=str2num(get(handles.OverlayPMaxEty, 'String'));

Fcn.SetOverlayThres(OverlayInd, NMax, NMin, PMin, PMax);
UpdateOverlayConfig(hObject);

% Hints: get(hObject,'String') returns contents of OverlayNMaxEty as text
%        str2double(get(hObject,'String')) returns contents of OverlayNMaxEty as a double

% --- Executes during object creation, after setting all properties.
function OverlayNMaxEty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayNMaxEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OverlayNMinEty_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayNMinEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fcn=handles.Fcn;
OverlayInd=handles.OverlayInd;

NMax=str2num(get(handles.OverlayNMaxEty, 'String'));
NMin=str2num(get(handles.OverlayNMinEty, 'String'));
PMin=str2num(get(handles.OverlayPMinEty, 'String'));
PMax=str2num(get(handles.OverlayPMaxEty, 'String'));

Fcn.SetOverlayThres(OverlayInd, NMax, NMin, PMin, PMax);
UpdateOverlayConfig(hObject);
% Hints: get(hObject,'String') returns contents of OverlayNMinEty as text
%        str2double(get(hObject,'String')) returns contents of OverlayNMinEty as a double

% --- Executes during object creation, after setting all properties.
function OverlayNMinEty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayNMinEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OverlayPMinEty_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayPMinEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fcn=handles.Fcn;
OverlayInd=handles.OverlayInd;

NMax=str2num(get(handles.OverlayNMaxEty, 'String'));
NMin=str2num(get(handles.OverlayNMinEty, 'String'));
PMin=str2num(get(handles.OverlayPMinEty, 'String'));
PMax=str2num(get(handles.OverlayPMaxEty, 'String'));

Fcn.SetOverlayThres(OverlayInd, NMax, NMin, PMin, PMax);
UpdateOverlayConfig(hObject);
% Hints: get(hObject,'String') returns contents of OverlayPMinEty as text
%        str2double(get(hObject,'String')) returns contents of OverlayPMinEty as a double


% --- Executes during object creation, after setting all properties.
function OverlayPMinEty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayPMinEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OverlayPMaxEty_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayPMaxEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fcn=handles.Fcn;
OverlayInd=handles.OverlayInd;

NMax=str2num(get(handles.OverlayNMaxEty, 'String'));
NMin=str2num(get(handles.OverlayNMinEty, 'String'));
PMin=str2num(get(handles.OverlayPMinEty, 'String'));
PMax=str2num(get(handles.OverlayPMaxEty, 'String'));

Fcn.SetOverlayThres(OverlayInd, NMax, NMin, PMin, PMax);
UpdateOverlayConfig(hObject);
% Hints: get(hObject,'String') returns contents of OverlayPMaxEty as text
%        str2double(get(hObject,'String')) returns contents of OverlayPMaxEty as a double


% --- Executes during object creation, after setting all properties.
function OverlayPMaxEty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayPMaxEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function HemiEty_Callback(hObject, eventdata, handles)
% hObject    handle to HemiEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HemiEty as text
%        str2double(get(hObject,'String')) returns contents of HemiEty as a double


% --- Executes during object creation, after setting all properties.
function HemiEty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HemiEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in YokeCheckBox.
function YokeCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to YokeCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of YokeCheckBox


% --- Executes on button press in TextureCheckBox.
function TextureCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to TextureCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TextureCheckBox


% --- Executes on button press in ViewPointMenu.
function ViewPointMenu_Callback(hObject, eventdata, handles)
% hObject    handle to ViewPointMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
Val=get(handles.ViewPointMenu, 'Value');


switch Val
    case 1 % DO NOTING
        return 
    case 2 % Left     
        ViewPoint=[ -90,   0];
        handles.Fcn.SetViewPointCustomFlag(0);
    case 3 % Right
        ViewPoint=[  90,   0];
        handles.Fcn.SetViewPointCustomFlag(0);
    case 4 % Ventral
        ViewPoint=[ -90, -90];
        handles.Fcn.SetViewPointCustomFlag(0);
    case 5 % Dorsal
        ViewPoint=[  90,  90];
        handles.Fcn.SetViewPointCustomFlag(0);
    case 6 % Anterior
        ViewPoint=[-180,   0];
        handles.Fcn.SetViewPointCustomFlag(0);
    case 7 % Posterior
        ViewPoint=[   0,   0];
        handles.Fcn.SetViewPointCustomFlag(0);
    case 8 % Customize
        Opt=handles.Fcn.GetViewPoint();
        CurVP=Opt.ViewPoint;
        Prompt={'Enter View Point'};
        NumLines=1;
        DefaultAns={num2str(CurVP, '%g ')};
        InputAns=inputdlg(Prompt, 'View Point', NumLines, DefaultAns);
        if isempty(InputAns)
            return;
        end
        ViewPoint=str2num(InputAns{1});
        handles.Fcn.SetViewPointCustomFlag(1);
end
handles.Fcn.SetViewPoint(ViewPoint);


% --- Executes on selection change in OverlayColorMenu.
function OverlayColorMenu_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayColorMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CmInd=get(handles.OverlayColorMenu, 'Value');
OverlayInd=handles.OverlayInd;
Fcn=handles.Fcn;
if CmInd>numel(handles.ColorMapEnum)
    return
    
    Opt=Fcn.GetOverlayColorMap(OverlayInd);
    CM=Opt.ColorMap;
    colormap(handles.SurfaceAxes, CM);
    colormapeditor;
    CM=colormap(handles.SurfaceAxes, CM);
    Fcn.SetOverlayColorMap(OverlayInd, CM, Opt.PN_Flag);
else
    CmString=handles.ColorMapEnum{CmInd};
    Opt=Fcn.GetOverlayColorMap(OverlayInd);
    Fcn.SetOverlayColorMap(OverlayInd, CmString, Opt.PN_Flag);
end
UpdateOverlayConfig(hObject);
% Hints: contents = cellstr(get(hObject,'String')) returns OverlayColorMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from OverlayColorMenu


% --- Executes during object creation, after setting all properties.
function OverlayColorMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayColorMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in OverlayColorPNFlagMenu.
function OverlayColorPNFlagMenu_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayColorPNFlagMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ind=get(handles.OverlayColorPNFlagMenu, 'Value');
switch Ind
    case 1
        PN_Flag='';
    case 2
        PN_Flag='+';
    case 3
        PN_Flag='-';
end
Fcn=handles.Fcn;
OverlayInd=handles.OverlayInd;

CmInd=get(handles.OverlayColorMenu, 'Value');
if CmInd>numel(handles.ColorMapEnum)
    %!!!!
else
    CmString=handles.ColorMapEnum{CmInd};
    Fcn.SetOverlayColorMap(OverlayInd, CmString, PN_Flag);
end
UpdateOverlayConfig(hObject);
% Hints: contents = cellstr(get(hObject,'String')) returns OverlayColorPNFlagMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from OverlayColorPNFlagMenu


% --- Executes during object creation, after setting all properties.
function OverlayColorPNFlagMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayColorPNFlagMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OverlayAlphaEty_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayAlphaEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fcn=handles.Fcn;
OverlayInd=handles.OverlayInd;

Alpha=str2num(get(handles.OverlayAlphaEty, 'String'));
if isempty(Alpha)
    errordlg('Invalid Overlay Alpha!');
    Opt=Fcn.GetOverlayAlpha(OverlayInd);
    set(handles.OverlayAlphaEty, 'String', num2str(Opt.Alpha));
    return
end

Fcn.SetOverlayAlpha(OverlayInd, Alpha);
UpdateOverlayConfig(hObject);
% Hints: get(hObject,'String') returns contents of OverlayAlphaEty as text
%        str2double(get(hObject,'String')) returns contents of OverlayAlphaEty as a double


% --- Executes during object creation, after setting all properties.
function OverlayAlphaEty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayAlphaEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function OverlayAlphaSlider_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayAlphaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Alpha=get(handles.OverlayAlphaSlider, 'Value');
Fcn=handles.Fcn;
OverlayInd=handles.OverlayInd;
Fcn.SetOverlayAlpha(OverlayInd, Alpha);
UpdateOverlayConfig(hObject);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function OverlayAlphaSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayAlphaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in HemiMenu.
function HemiMenu_Callback(hObject, eventdata, handles)
% hObject    handle to HemiMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateUnderlayFile(hObject);
% Hints: contents = cellstr(get(hObject,'String')) returns HemiMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from HemiMenu


% --- Executes during object creation, after setting all properties.
function HemiMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HemiMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function UnderlayEty_Callback(hObject, eventdata, handles)
% hObject    handle to UnderlayEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UnderlayFilePath=handles.UnderlayFilePath;
set(handles.UnderlayEty, 'String', UnderlayFilePath);
% Hints: get(hObject,'String') returns contents of UnderlayEty as text
%        str2double(get(hObject,'String')) returns contents of UnderlayEty as a double


% --- Executes during object creation, after setting all properties.
function UnderlayEty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UnderlayEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SurfOptBtn.
function SurfOptBtn_Callback(hObject, eventdata, handles)
% hObject    handle to SurfOptBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in DfBtn.
function DfBtn_Callback(hObject, eventdata, handles)
% hObject    handle to DfBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function OverlayThresNegSlider_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayThresNegSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function OverlayThresNegSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayThresNegSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function OverlayThresPosSlider_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayThresPosSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function OverlayThresPosSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayThresPosSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in OverlayThresSyncBtn.
function OverlayThresSyncBtn_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayThresSyncBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of OverlayThresSyncBtn


% --- Executes during object creation, after setting all properties.
function OverlayThresSyncBtn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayThresSyncBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in StatBtn.
function StatBtn_Callback(hObject, eventdata, handles)
% hObject    handle to StatBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fcn=handles.Fcn;
OverlayInd=handles.OverlayInd;

Opt=Fcn.GetOverlayStatOption(OverlayInd);
tmp=w_ChangeDf(Opt);
if isempty(tmp)
    return
end
Opt.TestFlag=tmp{1};
Opt.Df=tmp{2};
Opt.Df2=tmp{3};
Fcn.SetOverlayStatOption(OverlayInd, Opt);

UpdateOverlayConfig(hObject);

function OverlayPThresEty_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayPThresEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fcn=handles.Fcn;
OverlayInd=handles.OverlayInd;

Opt=Fcn.GetOverlayStatOption(OverlayInd);
PThres=str2num(get(handles.OverlayPThresEty, 'String'));
if isempty(PThres)
    set(handles.OverlayPThresEty, 'String', num2str(Opt.PThres));
    errordlg('Invalid P Threshold!');
    return
end
Fcn.SetOverlayPThres(OverlayInd, PThres);
UpdateOverlayConfig(hObject);
% Hints: get(hObject,'String') returns contents of OverlayPThresEty as text
%        str2double(get(hObject,'String')) returns contents of OverlayPThresEty as a double


% --- Executes during object creation, after setting all properties.
function OverlayPThresEty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayPThresEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OverlayTestFlagEty_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayTestFlagEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OverlayTestFlagEty as text
%        str2double(get(hObject,'String')) returns contents of OverlayTestFlagEty as a double


% --- Executes during object creation, after setting all properties.
function OverlayTestFlagEty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayTestFlagEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OverlayFweOptBtn.
function OverlayFweOptBtn_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayFweOptBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fcn=handles.Fcn;
OverlayInd=handles.OverlayInd;

Val=get(handles.OverlayFweOptBtn, 'Value');
switch Val
    case 1
    case 2 % Set Cluster Size
        Opt=Fcn.GetOverlayClusterSizeOption(OverlayInd);
        Opt=w_SurfClusterSize(Opt);
        if isempty(Opt)
            return
        else
            Fcn.SetOverlayClusterSizeOption(OverlayInd, Opt);
        end
end

% --- Executes on button press in OverlayTcBtn.
function OverlayTcBtn_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayTcBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in OverlayUtilitiesMenu.
function OverlayUtilitiesMenu_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayUtilitiesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fcn=handles.Fcn;
OverlayInd=handles.OverlayInd;

Val=get(handles.OverlayUtilitiesMenu, 'Value');
switch Val
    case 1
    case 2 % Save All Cluster
        [File , Path]=uiputfile({'*.gii', 'All GIfTI Files (*.gii)';...
            '*.shape.gii;*.func.gii','Vertex Metric (*.shape.gii;*.func.gii)';...
            '*.*', 'All Files (*.*)';}, ...
            'Pick Vertex Metric File' , pwd);
        if isnumeric(File) && File==0
            return
        end
        OutFilePath=fullfile(Path, File);
        Fcn.SaveOverlayClusters(OverlayInd, OutFilePath);
end

% --- Executes on button press in OverlayRmBtn.
function OverlayRmBtn_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayRmBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fcn=handles.Fcn;
OverlayInd=get(handles.OverlayMenu, 'Value');
Fcn.RemoveOverlay(OverlayInd);
handles.OverlayInd=1;
guidata(hObject, handles);
UpdateOverlayConfig(hObject);

% --- Executes on button press in NewBtn.
function NewBtn_Callback(hObject, eventdata, handles)
% hObject    handle to NewBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in MontageBtn.
function MontageBtn_Callback(hObject, eventdata, handles)
% hObject    handle to MontageBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in OverlayColorCustomBtn.
function OverlayColorCustomBtn_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayColorCustomBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in OverlayThresOnlyPosBtn.
function OverlayThresOnlyPosBtn_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayThresOnlyPosBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of OverlayThresOnlyPosBtn



function OverlayTpEty_Callback(hObject, eventdata, handles)
% hObject    handle to OverlayTpEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fcn=handles.Fcn;
OverlayInd=handles.OverlayInd;
Opt=Fcn.GetOverlayTimePoint(OverlayInd);

NewTP=str2num(get(handles.OverlayTpEty, 'String'));
if isempty(NewTP) || NewTP>Opt.NumTP
    errordlg('Invalid Time Point!');
    set(handles.OverlayTpEty, 'String', num2str(Opt.CurTP));
    return
end

Fcn.SetOverlayTimePoint(OverlayInd, NewTP);
% Hints: get(hObject,'String') returns contents of OverlayTpEty as text
%        str2double(get(hObject,'String')) returns contents of OverlayTpEty as a double


% --- Executes during object creation, after setting all properties.
function OverlayTpEty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlayTpEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in LabelMenu.
function LabelMenu_Callback(hObject, eventdata, handles)
% hObject    handle to LabelMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LabelMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LabelMenu


% --- Executes during object creation, after setting all properties.
function LabelMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LabelMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LabelAddBtn.
function LabelAddBtn_Callback(hObject, eventdata, handles)
% hObject    handle to LabelAddBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'UnderlayFilePath') || isempty(handles.UnderlayFilePath)
    errordlg('Please Indicate Underlay First!');
    return
end
DPABISurfPath=fileparts(which('DPABISurf.m'));
SurfTempPath=fullfile(DPABISurfPath, 'SurfTemplates');
[File , Path]=uigetfile({'*.label.gii','Label (*.label.gii)';'*.gii', 'All GIfTI Files (*.gii)';'*.*', 'All Files (*.*)';}, ...
    'Pick Label File' , SurfTempPath);
if isnumeric(File) && File==0
    return
end

LabelFile=fullfile(Path, File);
Fcn=handles.Fcn;
ExitCode=Fcn.AddLabel(LabelFile);
if ExitCode
    return
end
LabelInd=numel(Fcn.GetLabelFiles());
handles.LabelInd=LabelInd;
guidata(hObject, handles);
UpdateLabelConfig(hObject);

function UpdateLabelConfig(Obj)
Handles=guidata(Obj);
Fcn=Handles.Fcn;
LabelFiles=Fcn.GetLabelFiles();
LabelInd=Handles.LabelInd;
if ~isempty(LabelFiles)
    BtnState='On';
    [~, NameList, ExtList]=cellfun(@(f) fileparts(f), LabelFiles, 'UniformOutput', false);
    FileList=cellfun(@(f, e) [f, e], NameList, ExtList, 'UniformOutput', false);
    set(Handles.LabelMenu, 'Enable', BtnState,...
        'String', FileList,...
        'Value', LabelInd);
    set(Handles.LabelRmBtn, 'Enable', BtnState);
    Alpha=Fcn.GetLabelAlpha(LabelInd);
    set(Handles.LabelAlphaSlider, 'Enable', BtnState, 'Value', Alpha);
    set(Handles.LabelAlphaEty, 'Enable', BtnState, 'String', num2str(Alpha));
else
    BtnState='Off';
    FileList='Add Overlay...';    
    set(Handles.LabelMenu, 'Enable', BtnState,...
        'String', FileList,...
        'Value', LabelInd);
    set(Handles.LabelRmBtn, 'Enable', BtnState); 
    set(Handles.LabelAlphaSlider, 'Enable', BtnState, 'Value', 1);
    set(Handles.LabelAlphaEty, 'Enable', BtnState, 'String', '');    
end


% --- Executes on button press in LabelRmBtn.
function LabelRmBtn_Callback(hObject, eventdata, handles)
% hObject    handle to LabelRmBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fcn=handles.Fcn;
LabelInd=get(handles.LabelMenu, 'Value');
Fcn.RemoveLabel(LabelInd);
handles.LabelInd=1;
guidata(hObject, handles);
UpdateLabelConfig(hObject);

% --- Executes on button press in LabelBorderBtn.
function LabelBorderBtn_Callback(hObject, eventdata, handles)
% hObject    handle to LabelBorderBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LabelBorderBtn


% --- Executes on button press in LabelColorBtn.
function LabelColorBtn_Callback(hObject, eventdata, handles)
% hObject    handle to LabelColorBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function LabelAlphaSlider_Callback(hObject, eventdata, handles)
% hObject    handle to LabelAlphaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fcn=handles.Fcn;
LabelInd=handles.LabelInd;

Alpha=get(handles.LabelAlphaSlider, 'Value');

Fcn.SetLabelAlpha(LabelInd, Alpha);
UpdateLabelConfig(hObject);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function LabelAlphaSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LabelAlphaSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function LabelAlphaEty_Callback(hObject, eventdata, handles)
% hObject    handle to LabelAlphaEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fcn=handles.Fcn;
LabelInd=handles.LabelInd;

Alpha=str2num(get(handles.LabelAlphaEty, 'String'));
if isempty(Alpha)
    errordlg('Invalid Label Alpha!');
    Opt=Fcn.GetLabelAlpha(LabelInd);
    set(handles.LabelAlphaEty, 'String', num2str(Opt.Alpha));
    return
end

Fcn.SetLabelAlpha(LabelInd, Alpha);
UpdateLabelConfig(hObject);
% Hints: get(hObject,'String') returns contents of LabelAlphaEty as text
%        str2double(get(hObject,'String')) returns contents of LabelAlphaEty as a double


% --- Executes during object creation, after setting all properties.
function LabelAlphaEty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LabelAlphaEty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in LabelUtilitiesMenu.
function LabelUtilitiesMenu_Callback(hObject, eventdata, handles)
% hObject    handle to LabelUtilitiesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LabelUtilitiesMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LabelUtilitiesMenu


% --- Executes during object creation, after setting all properties.
function LabelUtilitiesMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LabelUtilitiesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
