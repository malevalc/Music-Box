function varargout = testinterface(varargin)
% TESTINTERFACE MATLAB code for testinterface.fig
%      TESTINTERFACE, by itself, creates a new TESTINTERFACE or raises the existing
%      singleton*.
%
%      H = TESTINTERFACE returns the handle to a new TESTINTERFACE or the handle to
%      the existing singleton*.
%
%      TESTINTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTINTERFACE.M with the given input arguments.
%
%      TESTINTERFACE('Property','Value',...) creates a new TESTINTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testinterface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testinterface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testinterface

% Last Modified by GUIDE v2.5 01-May-2015 18:08:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;

gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @testinterface_OpeningFcn, ...
    'gui_OutputFcn',  @testinterface_OutputFcn, ...
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

%code slider
%slider_value = get(hObject,'Value');
%display(slider_value);

function figure1_ResizeFcn(hObject, eventdata, handles)

% --- Executes just before testinterface is made visible.
function testinterface_OpeningFcn(hObject, eventdata, handles, varargin)
%Declaration des handles
handles.output = hObject;
handles.bool=0;
handles.stopbool=0;
handles.effect=0;
handles.flanger_power = 0.0006;
handles.echo_time = 1;
handles.distortion_power = 11;
handles.modulator_frequency = 880;
handles.tremolo_frequency = 5;
handles.compressor_amplitude = 0.9;
handles.expander_amplitude = -0.5;
set(handles.slider2, 'min', 0.0005);
set(handles.slider2, 'max', 0.01);
set(handles.slider2, 'Value', handles.flanger_power);
set(handles.slider3, 'min', 0.1);
set(handles.slider3, 'max', 15);
set(handles.slider3, 'Value', handles.echo_time);
set(handles.slider4, 'min', 2);
set(handles.slider4, 'max', 12);
set(handles.slider4, 'Value', handles.distortion_power);
set(handles.slider5, 'min', 100);
set(handles.slider5, 'max', 2000);
set(handles.slider5, 'Value', handles.modulator_frequency);
set(handles.slider6, 'min', -1);
set(handles.slider6, 'max', 0);
set(handles.slider6, 'Value', handles.expander_amplitude);
set(handles.slider7, 'min', 0);
set(handles.slider7, 'max', 1);
set(handles.slider7, 'Value', handles.compressor_amplitude);
set(handles.slider8, 'min', 0);
set(handles.slider8, 'max', 25);
set(handles.slider8, 'Value', handles.tremolo_frequency);
global traceVal;
global son;
%Chargement des images pour les boutons
chargerimage(11,hObject, eventdata, handles);
chargerimage(18,hObject, eventdata, handles);
chargerimage(19,hObject, eventdata, handles);
chargerimage(20,hObject, eventdata, handles);
chargerimage(22,hObject, eventdata, handles);
chargerimage(1,hObject, eventdata, handles);
chargerimage(2,hObject, eventdata, handles);
son = 'TP1_sound.wav';
[x,Fe]=audioread(son);
setappdata(0, 'son', son);
axes(handles.axes1);
trace(x,Fe,'Raw Signal');
handles.obj1audio = audioplayer(x,Fe);
setappdata(0, 'traceVal', traceVal);
radiobutton4_Callback(hObject, eventdata, handles);
set(handles.sauvegarde_text,'String','Save');
handles.modifie = x;
axes(handles.axes4);
imagesc(imread('images/noeffectselected.png'));
guidata(hObject, handles);
clock(hObject, eventdata, handles);

%Création d'une fonction pour charger les images juste sur les boutons
function chargerimage(num,hObject, eventdata, handles)
chemin = 'images/';
switch num
    case 1
        set(handles.close_pushbutton, 'CData', imread(strcat(chemin,'close.jpg')));
    case 2
        set(handles.annulation, 'CData', imread(strcat(chemin,'cancel.png')));
    case 11
        set(handles.upload_button, 'CData', imread(strcat(chemin,'upload.jpg')));
    case 18
        set(handles.play, 'CData', imread(strcat(chemin,'play.jpg')));
    case 19
        set(handles.stop, 'CData', imread(strcat(chemin,'stop.jpg')));
    case 20
        set(handles.pause, 'CData', imread(strcat(chemin,'pause.jpg')));
    case 22
        set(handles.sauvegarde_button, 'CData', imread(strcat(chemin,'save.jpg')));
end

%On retrace la courbe sans effect
%Et en fonction de l'effect préalablement enregistré, on retrace la courbe
%after effect
function rafraichircourbes(hObject, eventdata, handles)
son=getappdata(0, 'son');
[x,Fe]=audioread(son);
cla(handles.axes4,'reset');
set(handles.sauvegarde_text,'String','Save');
switch handles.effect
    case 1
        echo_button_Callback(hObject, eventdata, handles);
    case 2
        distortion_button_Callback(hObject, eventdata, handles);
    case 3
        flanger_button_Callback(hObject, eventdata, handles);
    case 4
        ring_button_Callback(hObject, eventdata, handles);
    case 5
        wahwah_button_Callback(hObject, eventdata, handles);
    case 6
        vibrato_button_Callback(hObject, eventdata, handles);
    case 7
        chorus_button_Callback(hObject, eventdata, handles);
    case 8
        tremolo_button_Callback(hObject, eventdata, handles);
    case 9
        expander_button_Callback(hObject, eventdata, handles);
    case 10
        compression_button_Callback(hObject, eventdata, handles);
    otherwise
        imagesc(imread('images/noeffectselected.png'));
end
axes(handles.axes1);
trace(x,Fe,'Raw Signal');

function trace(x,Fe,choix)
traceVal=getappdata(0, 'traceVal');
%Plot en temporel
if(traceVal == 1)
    N=length(x);
    t=[0:N-1]/Fe;
    h=plot(t,x);
    xlabel('Seconds');title(choix);
    uistack(h,'top');
    %Plot en fréquentiel (seulement le module)
elseif (traceVal == 2)
    N=length(x);
    f=[0:N-1]*Fe/N-Fe/2;
    X=fft(x)/N;
    xshift=abs(X);
    h=plot(f,fftshift(xshift));xlabel('Hertz');legend('Amplitude spectrum');title(choix);
    uistack(h,'top');
end

% --- Outputs from this function are returned to the command line.
function varargout = testinterface_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = hObject;

%----On retrouve ces lignes dans tous les effects :----
%set(handles.text3,'String','Computing...');
%son=getappdata(0, 'son');
%[x,Fe,Nbits]=audioread(son);
%handles.effect = nombre;
%axes(handles.axes4);
%trace(y,Fe,'Altered Signal : nom de l'effect);
%set(handles.text3,'String','Computing done.');
%set(handles.sauvegarde_text,'String','Save');
% !!!! ELLES NE DOIVENT ETRE TOUCHEES SOUS AUCUN PRETEXTE !!!!

%================== Echo ==================================
function echo_button_Callback(hObject, eventdata, handles)
set(handles.text3,'String','Computing...');
son=getappdata(0, 'son');
[x,Fe]=audioread(son);
t = round(Fe*(handles.echo_time));
y(:,1) = zeros(size(x(:,1)));
for i = (t+1):length(x(:,1)),
    y(i) = (0.8)*(x(i-t,1));
end
% résultat final signal retardé + signal original
y(:,1) = y(:,1) + x(:,1);
handles.modifie = y;
handles.obj1audio = audioplayer(y(:,1),Fe);
handles.effect = 1;
axes(handles.axes4);
trace(y,Fe,sprintf('Altered Signal (Echo (%2.2f s delay))', handles.echo_time));
set(handles.text3,'String','Computing done.');
set(handles.sauvegarde_text,'String','Save');
guidata(hObject, handles);

%================== Flanger ===============================
function flanger_button_Callback(hObject, eventdata, handles)
set(handles.text3,'String','Computing...');
son=getappdata(0, 'son');
[x,Fe]=audioread(son);
taille = 1:length(x(:,1));
% sinusoidale modulante
modul = sin(2*pi*taille*(1/Fe));
% temps de retard -> 0,0008*Fs = 1/1250 de la fréquence soit extrèmement court
t = round(handles.flanger_power*Fe);
% Initialisation du signal final
y(:,1) = zeros(size(x(:,1)));
% jusqu'au retard : y(signal final) = x(signal audio)
y(1:t,1)=x(1:t,1);
% à partir du retard, jusqu'à la fin du signal, on applique la modulation
for i = (t+1):length(x(:,1)),
    %valeur absolue entière du signal modulant multiplié par le retard
    abs_modul_retard=round(abs(modul(i))*t);
    % signal final = signal audio original + signal retardé par rapport au retard temporel modulé
    y(i,1) = x(i,1) + 1.4*(x(i-abs_modul_retard,1));
end
handles.modifie = y;
handles.obj1audio = audioplayer(y,Fe);
axes(handles.axes4);
trace(y,Fe,'Altered Signal (Flanger)');
handles.effect = 3;
set(handles.text3,'String','Computing done.');
set(handles.sauvegarde_text,'String','Save');
guidata(hObject, handles);

%================== Chorus ================================
function chorus_button_Callback(hObject, eventdata, handles)
set(handles.text3,'String','Computing...');
son=getappdata(0, 'son');
[x,Fe]=audioread(son);
freq=0.15*Fe;
x=x(1:Fe*20);
delay_max=8;
d_max = ceil(delay_max*0.001*Fe);
%On créé un oscillateur
for i=1:length(x)
    oscillateur(i) = sin(2*pi*i*(freq/Fe));
end
for i=1:d_max
    y(i) = x(i);
end
for i=d_max+1:length(x)
    osc = abs(oscillateur(i));
    del = ceil(osc*delay_max);
    y(i) = (x(i) + x(i-del))/2;
end
handles.modifie = y;
handles.obj1audio = audioplayer(y,Fe);
axes(handles.axes4);
trace(y,Fe,'Altered Signal (Chorus)');
handles.effect = 7;
set(handles.text3,'String','Computing done.');
set(handles.sauvegarde_text,'String','Save');
guidata(hObject, handles);

%================== Wah-Wah ===============================
function wahwah_button_Callback(hObject, eventdata, handles)
set(handles.text3,'String','Computing...');
son=getappdata(0, 'son');
[x,Fe]=audioread(son);
% frequence min et max de l'effect wah wah
fmin=400;
fmax=4000;
% frequence de base de l'effect wah wah : (fmin+fmax)/2
Fw = (fmin+fmax)/2;
%delta fréquence entre base de l'effect et celle du signal audio
delta = Fw/Fe;
% Tableau de fréquence allant de fmin à fmax avec pour pas de variation delta
Fc=fmin:delta:fmax;
% Tant que la taille de Fc est inférieur à celle de x, Fc = variation de Fmax -> fmin et fmin -> fmax par
% pas de delta
while(length(Fc) < length(x) )
    Fc= [ Fc (fmax:-delta:fmin) ];
    Fc= [ Fc (fmin:delta:fmax) ];
end
% Taille de Fc = les valeurs de Fc(1) jusqu'à Fc(taille de x)
Fc = Fc(1:length(x(:,1)));
% Coeff Frequence : différent pour chaque valeur de Fc
F1 = 2*sin((pi*Fc(1))/Fe);
% Coeff d'amplitude du filtre
Q1 = 2*0.05;%2*0.4;
%vecteur resultat (3 pour correspondre à la fréquence trianglue du wah wah)
yh=zeros(size(x(:,1)));
yb(:,1)=zeros(size(x(:,1)));
yl=zeros(size(x(:,1)));
% Première valeur pour ne pas être nul à cause du retard n-1
yh(1) = x(1,1);
yb(1,1) = F1*yh(1);
yl(1) = F1*yb(1,1);
% Calcul
for n=2:length(x(:,1)),
    yh(n) = x(n,1) - yl(n-1) - Q1*yb(n-1,1);
    yb(n,1) = F1*yh(n) + yb(n-1,1);
    yl(n) = F1*yb(n,1) + yl(n-1);
    F1 = 2*sin((pi*Fc(n))/Fe);
end
handles.modifie = yh;
handles.obj1audio = audioplayer(yh,Fe);
axes(handles.axes4);
handles.effect = 5;
trace(yh,Fe,'Altered Signal (Wah-Wah)');
set(handles.text3,'String','Computing done.');
setappdata(0, 'son', son);
set(handles.sauvegarde_text,'String','Save');
guidata(hObject, handles);

%================== Distortion ============================
function distortion_button_Callback(hObject, eventdata, handles)
set(handles.text3,'String','Computing...');
son=getappdata(0, 'son');
[x,Fe]=audioread(son);
gain = handles.distortion_power;
mix= 1;
q(:,1)=x(:,1)*gain/max(abs(x(:,1)));
z=sign(-q).*(1-exp(sign(-q(:,1)).*q(:,1)));
y(:,1)=mix*z(:,1)*max(abs(x(:,1)))/max(abs(z(:,1)))+(1-mix)*x(:,1);
y(:,1)=y(:,1)*max(abs(x(:,1)))/max(abs(y(:,1)));
handles.modifie = y;
handles.obj1audio = audioplayer(y(:,1),Fe);
axes(handles.axes4);
trace(y,Fe,sprintf('Altered Signal (Distortion (%2.0f dB gain))',handles.distortion_power));
handles.effect = 2;
set(handles.text3,'String','Computing done.');
set(handles.sauvegarde_text,'String','Save');
guidata(hObject, handles);

%================== Vibrato ===============================
function vibrato_button_Callback(hObject, eventdata, handles)
set(handles.text3,'String','Computing...');
son=getappdata(0, 'son');
[x,Fe]=audioread(son);
SAMPLERATE=Fe;
Modfreq = 10; %10 Khz
Width = 0.0008; % 0.8 Milliseconds
ya_alt=0;
Delay=Width; % basic delay of input sample in sec
DELAY=round(Delay*SAMPLERATE); % basic delay in # samples
WIDTH=round(Width*SAMPLERATE); % modulation width in # samples
if WIDTH>DELAY
    error('delay greater than basic delay !!!');
    return;
end
MODFREQ=Modfreq/SAMPLERATE; % modulation frequency in # samples
LEN=length(x);        % # of samples in WAV-file
L=2+DELAY+WIDTH*2;    % length of the entire delay
Delayline=zeros(L,1); % memory allocation for delay
y=zeros(size(x));     % memory allocation for output vector
for n=1:(LEN-1)
    M=MODFREQ;
    MOD=sin(M*2*pi*n);
    ZEIGER=1+DELAY+WIDTH*MOD;
    i=floor(ZEIGER);
    frac=ZEIGER-i;
    Delayline=[x(n);Delayline(1:L-1)];
    %---Linear Interpolation-----------------------------
    y(n,1)=Delayline(i+1)*frac+Delayline(i)*(1-frac);
end
handles.modifie = y;
handles.obj1audio = audioplayer(y,Fe);
axes(handles.axes4);
trace(y,Fe,'Altered Signal (Vibrato)');
handles.effect = 6;
set(handles.text3,'String','Computing done.');
set(handles.sauvegarde_text,'String','Save');
guidata(hObject, handles);

%==================  Ring Modulator =======================
function ring_button_Callback(hObject, eventdata, handles)
set(handles.text3,'String','Computing...');
son=getappdata(0, 'son');
[x,Fe]=audioread(son);
taille = 1:length(x(:,1));
Fc = handles.modulator_frequency;
mod(:,1) = sin(2*pi*taille*(Fc/Fe));
% faire Ring Modulation
y(:,1) = x(:,1) .* mod;
handles.modifie = y;
handles.obj1audio = audioplayer(y,Fe);
axes(handles.axes4);
handles.effect = 4;
trace(y,Fe,sprintf('Altered Signal (Ring Modulator (%.0f Hz frequency))',handles.modulator_frequency));
set(handles.text3,'String','Computing done.');
set(handles.sauvegarde_text,'String','Save');
guidata(hObject, handles);

%================== Compressor ==============================
function expander_button_Callback(hObject, eventdata, handles)
set(handles.text3,'String','Computing...');
son=getappdata(0, 'son');
[x,Fe]=audioread(son);
comp = handles.compressor_amplitude;
a=0.09;
h=filter([(1-a)^2],[1.0000 -2*a a^2],abs(x(:,1)));
h=h/max(h);
h=h.^comp;
y(:,1)=x(:,1).*h(:,1);
y(:,1)=y(:,1)*max(abs(x(:,1)))/max(abs(y(:,1)));
handles.modifie = y;
handles.obj1audio = audioplayer(y,Fe);
axes(handles.axes4);
trace(y,Fe,sprintf('Altered Signal (Compressor (%2.0f %% compression))',100*comp));
handles.effect = 9;
set(handles.text3,'String','Computing done.');
set(handles.sauvegarde_text,'String','Save');
guidata(hObject, handles);

%================== Expander ===========================
function compression_button_Callback(hObject, eventdata, handles)
set(handles.text3,'String','Computing...');
son=getappdata(0, 'son');
[x,Fe]=audioread(son);
comp = handles.expander_amplitude;
a = 0.09;
h=filter([(1-a)^2],[1.0000 -2*a a^2],abs(x(:,1)));
h=h/max(h);
h=h.^comp;
y(:,1)=x(:,1).*h(:,1);
y(:,1)=y(:,1)*max(abs(x(:,1)))/max(abs(y(:,1)));
handles.modifie = y;
handles.obj1audio = audioplayer(y,Fe);
axes(handles.axes4);
traceVal=getappdata(0, 'traceVal');
if(traceVal == 2)
    imagesc(imread('images/nottraceable.png'));
elseif (traceVal == 1)
    trace(y,Fe,sprintf('Altered Signal (Expander (%2.0f %% expansion))',100*abs(comp)));
end
handles.effect = 10;
set(handles.text3,'String','Computing done.');
set(handles.sauvegarde_text,'String','Save');
guidata(hObject, handles);

%================== Tremolo ===============================
function tremolo_button_Callback(hObject, eventdata, handles)
set(handles.text3,'String','Computing...');
son=getappdata(0, 'son');
[x,Fe]=audioread(son);
index = 1:length(x(:,1));
Fc = handles.tremolo_frequency;
alpha = 0.5;
trem=(1+alpha*sin(2*pi*index*(Fc/Fe)))';
y(:,1) = trem.*x(:,1);
handles.modifie = y;
handles.obj1audio = audioplayer(y(:,1),Fe);
axes(handles.axes4);
trace(y,Fe,sprintf('Altered Signal (Tremolo (%2.1f Hz frequency))',handles.tremolo_frequency));
handles.effect = 8;
set(handles.text3,'String','Computing done.');
set(handles.sauvegarde_text,'String','Save');
guidata(hObject, handles);

%Sélection du fichier à partir du champ de texte editable
function edit1_Callback(hObject, eventdata, handles)
input = get(hObject,'String');
son=strcat(input,'.wav');
guidata(hObject, handles);
setappdata(0, 'son', son);

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Sélection du fichier à partir du bouton parcourir
function parcourir_Callback(hObject, eventdata, handles)
son =  uigetfile('*.wav', 'Choose a file (really)');
if son<0
    return;
end
setappdata(0, 'son', son);

%Sélection du fichier à partir de la liste
function popup_Callback(hObject, eventdata, handles)
items = get(hObject,'String');
index_selected = get(hObject,'Value');
item_selected = items{index_selected};
setappdata(0, 'son', item_selected);

%Crée la liste des sons disponibles
function popup_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
files = dir(fullfile(pwd,'*.wav'));
set(hObject,'String',{files.name});
items = get(hObject,'String');
index_selected = get(hObject,'Value');
while (~strcmp((items{index_selected}),'TP1_sound.wav'))
    set(hObject,'Value',index_selected+1);
    index_selected = get(hObject,'Value');
end

%L'action d'uploader équivaut à l'action d'annuler les effects
%-> même résultat
function upload_button_Callback(hObject, eventdata, handles)
annulation_Callback(hObject, eventdata, handles)

function axes1_CreateFcn(hObject, eventdata, handles)

%Bouton Play
function play_Callback(hObject, eventdata, handles)
handles.bool = 0;
play(handles.obj1audio);
handles.stopbool = 0;
guidata(hObject, handles);

%Bouton Stop
function stop_Callback(hObject, eventdata, handles)
stop(handles.obj1audio);
handles.stopbool = 1;
guidata(hObject, handles);

%Bouton Pause
function pause_Callback(hObject, eventdata, handles)
if(handles.bool == 1 && handles.stopbool == 0)
    resume(handles.obj1audio);
    handles.bool = 0;
elseif (handles.bool == 0 && handles.stopbool == 0)
    pause(handles.obj1audio);
    handles.bool = 1;
end
guidata(hObject,handles);

%Annulation des effects
function annulation_Callback(hObject, eventdata, handles)
son=getappdata(0, 'son');
[x,Fe]=audioread(son);
set(handles.slider2, 'Value', 0.0006);
set(handles.slider3, 'Value', 1);
set(handles.slider4, 'Value', 11);
set(handles.slider5, 'Value', 880);
set(handles.slider6, 'Value', -0.5);
set(handles.slider7, 'Value', 0.9);
set(handles.slider8, 'Value', 5);
handles.obj1audio = audioplayer(x,Fe);
axes(handles.axes1);
trace(x,Fe,'Raw Signal');
set(handles.text3,'String','Infos on effects...');
cla(handles.axes4,'reset');
set(handles.sauvegarde_text,'String','Save');
axes(handles.axes4);
imagesc(imread('images/noeffectselected.png'));
guidata(hObject, handles);

%Static text d'information de progression
%number vaut 1 au début du calcul et 2 à la fin
function text3_CreateFcn(hObject, eventdata, handles, number)

%Texte sous la disquette qui passe de Sauvegarde à Sauvegarder en affichant
%le nom du fichier sauvegardé
function sauvegarde_text_CreateFcn(hObject, eventdata, handles, number, nom)

function sauvegarde_Callback(hObject, eventdata, handles)
close(ancestor(hObject,'figure'));

%Sauvegarde du fichier
function sauvegarde_button_Callback(hObject, eventdata, handles)
son=getappdata(0, 'son');
[x,Fe,N]=audioread(son);
user_response = sauver('Title','Save as...');
switch user_response
    case 'Yes'
        nom = [datestr(now,'yyyy-mmm-dd_HH-MM'),'.wav'];
    case 'No'
        nom = uiputfile('*.wav', 'Save the edited file (make sure you do!)');
end
wavwrite(handles.modifie,Fe,N,nom); %#ok<DWVWR>
set(handles.popup,'String',[cellstr(get(handles.popup,'String'));{nom}]);
set(handles.sauvegarde_text,'String',['Saved as '...
    '',nom]);

%Plot en temporel
function radiobutton4_Callback(hObject, eventdata, handles)
setappdata(0, 'traceVal', 1);
rafraichircourbes(hObject, eventdata, handles);

%Plot en fréquentiel
function frequentiel_Callback(hObject, eventdata, handles)
setappdata(0, 'traceVal', 2);
rafraichircourbes(hObject, eventdata, handles);

%"Uploader"
function Untitled_1_Callback(hObject, eventdata, handles)
upload_button_Callback(hObject, eventdata, handles)

function close_Callback(hObject, eventdata, handles)
close(ancestor(hObject,'figure'));

%Vérifie si on veut bien quitter
function close_pushbutton_Callback(hObject, eventdata, handles)
user_response = modaldlg('Title','Confirm Close');
switch user_response
    case 'Yes'
        delete(handles.figure1)
end

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
handles.flanger_power = get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
handles.echo_time = get(hObject,'Value');
set(handles.echo_button,'String',sprintf('Echo (%2.2f s)',handles.echo_time));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
handles.distortion_power = get(hObject,'Value');
set(handles.distortion_button,'String',sprintf('Distortion (%2.1f dB)',handles.distortion_power));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
handles.modulator_frequency = get(hObject,'Value');
set(handles.ring_button,'String',sprintf('Ring Modulator (%.0f Hz)',handles.modulator_frequency));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
handles.expander_amplitude = get(hObject,'Value');
set(handles.compression_button,'String',sprintf('Expander (%2.0f %%)',100*handles.expander_amplitude));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
handles.compressor_amplitude = get(hObject,'Value');
set(handles.expander_button,'String',sprintf('Compressor (%2.0f %%)',100*handles.compressor_amplitude));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
handles.tremolo_frequency = get(hObject,'Value');
set(handles.tremolo_button,'String',sprintf('Tremolo (%2.1f Hz)',handles.tremolo_frequency));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function text5_CreateFcn(hObject, eventdata, handles)

function clock(hObject, eventdata, handles)
h = handles.axes1;
while ishandle(h)
    set(handles.text5,'String',[datestr(now,'dd/mm/yy'),' ',datestr(now,'HH:MM:SS')]);
    drawnow;
end
