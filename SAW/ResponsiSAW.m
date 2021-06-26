function varargout = ResponsiSAW(varargin)
% RESPONSISAW MATLAB code for ResponsiSAW.fig
%      RESPONSISAW, by itself, creates a new RESPONSISAW or raises the existing
%      singleton*.
%
%      H = RESPONSISAW returns the handle to a new RESPONSISAW or the handle to
%      the existing singleton*.
%
%      RESPONSISAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSISAW.M with the given input arguments.
%
%      RESPONSISAW('Property','Value',...) creates a new RESPONSISAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ResponsiSAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ResponsiSAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ResponsiSAW

% Last Modified by GUIDE v2.5 25-Jun-2021 16:51:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ResponsiSAW_OpeningFcn, ...
                   'gui_OutputFcn',  @ResponsiSAW_OutputFcn, ...
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


% --- Executes just before ResponsiSAW is made visible.
function ResponsiSAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ResponsiSAW (see VARARGIN)

% Choose default command line output for ResponsiSAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ResponsiSAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ResponsiSAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = [1:8];
data = readtable('DATA RUMAH.xlsx', opts);
data = table2cell(data);
set (handles.uitable1,'data',data)


% --- Executes on button press in pushbutton1.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Mengimport data dari file DATA RUMAH.xlsx
opts = detectImportOptions('DATA RUMAH.xlsx');
%Memilih kolom 3 sampai 8 yang akan digunakan sebagai kriteria
opts.SelectedVariableNames = (3:8);
%x  = merupakan input data berdasarkan kriteria
x = readmatrix('DATA RUMAH.xlsx', opts); 
%k = nilai atribut, dimana value 0 =  atribut biaya & 1= atribut keuntungan
k = [0 1 1 1 1 1];
%w = bobot untuk masing-masing kriteria
w=[0.3, 0.2, 0.23, 0.1, 0.07, 0.1];

%tahapan 1. normalisasi matriks
%matriks m x n dengan ukuran sebanyak variabel x (input)
[m n]=size (x); 
%membuat matriks R, yang merupakan matriks kosong
R=zeros (m,n); 
%membuat matriks Y, yang merupakan titik kosong
Y=zeros (m,n); 

for j=1:n,
    %statement untuk kriteria dengan atribut keuntungan
 if k(j)==1, 
     %Jika keuntungan maka kriteria dibagi maksimum kirteria yg ada
  R(:,j)=x(:,j)./max(x(:,j));
 else
     %jika cost maka kriteria minimum yang ada dibagi dengan krietria
  R(:,j)=min(x(:,j))./x(:,j);
 end;
end;

%tahapan kedua, proses perangkingan
for i=1:m,
    %Menjumlahkan tiap baris alternatif
    %dengan mengalikan bobot dengan mengalikan kriteria denganbobotnya
    alternatif(i)= sum(w.*R(i,:))
end;

% tranpose matrix alternatif dari baris menjadi kolom 
alternatifTranspose = alternatif.';
%Convert array menjadi cell array
alternatifTranspose = num2cell(alternatifTranspose); 
%import data dari file
opts = detectImportOptions('DATA RUMAH.xlsx');
%memilih kolom 1 sampai 8
opts.SelectedVariableNames = [1:8];
rangking = readtable('DATA RUMAH.xlsx', opts);
%Convert array menjadi cell array
rangking = table2cell(rangking);
%Menggabungkan array rangking dan alternatifTranspose
rangking = [rangking alternatifTranspose];
%Melakukan sorting data berdasarkan kolom alternatif di kolom 9
rangking = sortrows(rangking,-9);
%Memilih baris 1-20 kolom 1 - 8
rangking = rangking(1:20,1:8);
%Menampilkan matrik rangking pada table uitable2
set(handles.uitable2,'Data', rangking);
