function varargout = interface1(varargin)
%INTERFACE1 MATLAB code file for interface1.fig
%      INTERFACE1, by itself, creates a new INTERFACE1 or raises the existing
%      singleton*.
%
%      H = INTERFACE1 returns the handle to a new INTERFACE1 or the handle to
%      the existing singleton*.
%
%      INTERFACE1('Property','Value',...) creates a new INTERFACE1 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to interface1_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      INTERFACE1('CALLBACK') and INTERFACE1('CALLBACK',hObject,...) call the
%      local function named CALLBACK in INTERFACE1.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interface1

% Last Modified by GUIDE v2.5 03-Mar-2018 21:01:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface1_OpeningFcn, ...
                   'gui_OutputFcn',  @interface1_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before interface1 is made visible.
function interface1_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for interface1
global turno;
global modo;

handles.output = hObject;
if(modo~=1)
    handles.estado_partida.String = strcat('Turno de:',int2str(turno));
end
actualizarVictorias(handles,0,0,0,0);

if(turno == 1)
    IAplay(handles);
end
if(modo == 1)
    if(turno == 2)
        enemyPlay(handles);
    end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interface1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function actualizarVictorias(handles,uno,dos,empates,total)
    handles.victorias_uno.String = int2str(uno);
    handles.victorias_dos.String = int2str(dos);
    handles.empates.String = int2str(empates);
    handles.total.String = int2str(total);


% --- Outputs from this function are returned to the command line.
function varargout = interface1_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function cambiarTurno()
global turno;
if(turno == 1)
    turno = 2;
else 
    turno = 1;
end

function enemyPlay(handles)
global matrix;
global turno;
global detener;
global modo;
matrix
if(turno == 2)
    [row, column] = playAgentEnemy(matrix);
    
    if(row == 1 && column ==1)
        handles.btn11.FontSize = 20;
        handles.btn11.ForegroundColor = [1 0 0];
        handles.btn11.String = 'X';
    elseif(row == 1 && column ==2)
        handles.btn12.FontSize = 20;
        handles.btn12.ForegroundColor = [1 0 0];
        handles.btn12.String = 'X';
    elseif(row == 1 && column ==3)
        handles.btn13.FontSize = 20;
        handles.btn13.ForegroundColor = [1 0 0];
        handles.btn13.String = 'X';
    elseif(row == 2 && column ==1)
        handles.btn21.FontSize = 20;
        handles.btn21.ForegroundColor = [1 0 0];
        handles.btn21.String = 'X';
    elseif(row == 2 && column ==2)
        handles.btn22.FontSize = 20;
        handles.btn22.ForegroundColor = [1 0 0];
        handles.btn22.String = 'X';
    elseif(row == 2 && column ==3)
        handles.btn23.FontSize = 20;
        handles.btn23.ForegroundColor = [1 0 0];
        handles.btn23.String = 'X';
    elseif(row == 3 && column ==1)
        handles.btn31.FontSize = 20;
        handles.btn31.ForegroundColor = [1 0 0];
        handles.btn31.String = 'X';
    elseif(row == 3 && column ==2)
        handles.btn32.FontSize = 20;
        handles.btn32.ForegroundColor = [1 0 0];
        handles.btn32.String = 'X';
    elseif(row == 3 && column ==3)
        handles.btn33.FontSize = 20;
        handles.btn33.ForegroundColor = [1 0 0];
        handles.btn33.String = 'X';
    end
    matrix(row,column) = 2;
    cambiarTurno();
    if(modo~=1)
        handles.estado_partida.String = strcat('Turno de:',int2str(turno));
    end
    
    comprobarEstado(handles);
    if(contarCeros(matrix) ~= 0 && ~detener)
        pause(0.2);
        IAplay(handles);
    end
end

function IAplay(handles)
global matrix;
global turno;
global modo;
global detener;

if(turno == 1)
    [row, column] = playAgentStudent(matrix);
    
    if(row == 1 && column ==1)
        handles.btn11.FontSize = 20;
        handles.btn11.ForegroundColor = [0 0 1];
        handles.btn11.String = 'O';
    elseif(row == 1 && column ==2)
        handles.btn12.FontSize = 20;
        handles.btn12.ForegroundColor = [0 0 1];
        handles.btn12.String = 'O';
    elseif(row == 1 && column ==3)
        handles.btn13.FontSize = 20;
        handles.btn13.ForegroundColor = [0 0 1];
        handles.btn13.String = 'O';
    elseif(row == 2 && column ==1)
        handles.btn21.FontSize = 20;
        handles.btn21.ForegroundColor = [0 0 1];
        handles.btn21.String = 'O';
    elseif(row == 2 && column ==2)
        handles.btn22.FontSize = 20;
        handles.btn22.ForegroundColor = [0 0 1];
        handles.btn22.String = 'O';
    elseif(row == 2 && column ==3)
        handles.btn23.FontSize = 20;
        handles.btn23.ForegroundColor = [0 0 1];
        handles.btn23.String = 'O';
    elseif(row == 3 && column ==1)
        handles.btn31.FontSize = 20;
        handles.btn31.ForegroundColor = [0 0 1];
        handles.btn31.String = 'O';
    elseif(row == 3 && column ==2)
        handles.btn32.FontSize = 20;
        handles.btn32.ForegroundColor = [0 0 1];
        handles.btn32.String = 'O';
    elseif(row == 3 && column ==3)
        handles.btn33.FontSize = 20;
        handles.btn33.ForegroundColor = [0 0 1];
        handles.btn33.String = 'O';
    end
    matrix(row,column) = 1;
    cambiarTurno();
    
    if(modo~=1)
        handles.estado_partida.String = strcat('Turno de:',int2str(turno));
    end
    
    comprobarEstado(handles);
    
    if(modo == 1)
        if(contarCeros(matrix) ~= 0  && ~detener)
            pause(0.2);
            enemyPlay(handles);
        end
    end
end


function realizarJugada(hObject,row,column,handles)
global turno;
global matrix;
if(isempty(hObject.String) && turno == 2)
    
    hObject.FontSize = 20;
    hObject.ForegroundColor = [0 0 1];
    hObject.String = 'X';
    matrix(row,column) = 2;
    cambiarTurno();
    if(contarCeros(matrix) ~= 0)
        tic;
        start = tic();
        IAplay(handles);
        fin = toc(start);
        disp(fin);
    else
        disp('Juego acabado');
    end
else
    disp('Esa casilla ya esta ocupada');
end



function comprobarEstado(handles)
global matrix;
global victorias_uno;
global victorias_dos;
global empates;
global total;
global detener;
status = checkBoard(matrix);

if(~isempty(status.winner) && ~detener)
    if(status.winner == 1)
        handles.estado_partida.String = strcat('Gano el jugador uno');
        victorias_uno = victorias_uno + 1;
    elseif(status.winner == 2)
        handles.estado_partida.String = strcat('Gano el jugador dos');
        victorias_dos = victorias_dos + 1;
    end
    total = total + 1;
    
    actualizarVictorias(handles,victorias_uno,victorias_dos,empates,total);
    detener = true;
elseif(isempty(status.winner) && contarCeros(matrix) == 0 && ~detener)
    empates = empates + 1;
    total = total + 1;
    actualizarVictorias(handles,victorias_uno,victorias_dos,empates,total);
    detener = true;
end

function cantidad = contarCeros(matrix)
   ceros = matrix == zeros(3);
   ceros = ceros(:);
   cantidad = sum(ceros);

% --- Executes on button press in btn11.
function btn11_Callback(hObject, ~, handles)
% hObject    handle to btn11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
realizarJugada(hObject,1,1,handles);

% --- Executes during object creation, after setting all properties.
function btn11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btn11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in btn12.
function btn12_Callback(hObject, eventdata, handles)
% hObject    handle to btn12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
realizarJugada(hObject,1,2,handles);

% --- Executes on button press in btn13.
function btn13_Callback(hObject, eventdata, handles)
% hObject    handle to btn13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
realizarJugada(hObject,1,3,handles);

% --- Executes on button press in btn21.
function btn21_Callback(hObject, eventdata, handles)
% hObject    handle to btn21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
realizarJugada(hObject,2,1,handles)
% --- Executes on button press in btn22.
function btn22_Callback(hObject, eventdata, handles)
% hObject    handle to btn22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
realizarJugada(hObject,2,2,handles);

% --- Executes on button press in btn23.
function btn23_Callback(hObject, eventdata, handles)
% hObject    handle to btn23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
realizarJugada(hObject,2,3,handles);

% --- Executes on button press in btn31.
function btn31_Callback(hObject, eventdata, handles)
% hObject    handle to btn31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
realizarJugada(hObject,3,1,handles);

% --- Executes on button press in btn32.
function btn32_Callback(hObject, eventdata, handles)
% hObject    handle to btn32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
realizarJugada(hObject,3,2,handles);

% --- Executes on button press in btn33.
function btn33_Callback(hObject, eventdata, handles)
% hObject    handle to btn33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
realizarJugada(hObject,3,3,handles);


% --- Executes on button press in btnnueva_partida.
function btnnueva_partida_Callback(hObject, eventdata, handles)
% hObject    handle to btnnueva_partida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global matrix;
global turno;
global detener;
global modo;
turno = setWhoGoesFirst();
matrix = zeros(3);
handles.btn11.String = '';
handles.btn12.String = '';
handles.btn13.String = '';
handles.btn21.String = '';
handles.btn22.String = '';
handles.btn23.String = '';
handles.btn31.String = '';
handles.btn32.String = '';
handles.btn33.String = '';

if(modo~=1)
    handles.estado_partida.String = strcat('Turno de:',int2str(turno));
end
detener = false;
if(turno == 1)
    IAplay(handles);
end
if(modo == 1)
    if(turno == 2)
        enemyPlay(handles);
    end
end


function estado_partida_Callback(hObject, eventdata, handles)
% hObject    handle to estado_partida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of estado_partida as text
%        str2double(get(hObject,'String')) returns contents of estado_partida as a double


% --- Executes during object creation, after setting all properties.
function estado_partida_CreateFcn(hObject, eventdata, handles)
% hObject    handle to estado_partida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
