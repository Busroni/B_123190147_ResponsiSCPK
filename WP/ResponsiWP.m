
%data rating kecocokan dari masing-masing alternatif
%Mengimport data dari file Real estate valuation data set.xlsx
opts = detectImportOptions('Real estate valuation data set.xlsx');
%memilih kolom ke 3 4 5 dan 8
opts.SelectedVariableNames = [3:5 8];
%Memilih baris 50 data teratas, yaitu dari baris 2-51
opts.DataRange = '2:51';
%menyimpan data dalam bentuk matrix ke dalam variabel x
x = readmatrix('Real estate valuation data set.xlsx', opts);
%atribut tiap-tiap kriteria, 1=atrribut keuntungan, dan  0= atribut biaya
k = [0,0,1,0];
%Nilai bobot tiap kriteria 
w = [3,5,4,1];
 
%tahapan pertama, perbaikan bobot
[m n]=size (x); %inisialisasi ukuran x
%Perbaikan bobot yang mana total bobot harus = 1
%membagi bobot per kriteria dengan jumlah total seluruh bobot
w=w./sum(w); 

%tahapan kedua, melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n,
    %Jika berisi 0 atau cost maka bobot diubah menjadi negatif
    if k(j)==0, w(j)=-1*w(j);
    end;
end;

for i=1:m,
    %mengalikan seluruh kriteria 
    %bagi tiap alternatif dengan bobotnya menjadi pangkatnya
    S(i)=prod(x(i,:).^w);
end;

%tahapan ketiga, proses perangkingan
%mebagi hasil yg telah didapatkan denagn jumlah seluruh hasil
V = S/sum(S);

% tranpose matrix alternatif dari horizontal menjadi vertikal
VTranspose = V.'; 
%Mengimport data dari file Real estate valuation data set.xlsx
opts = detectImportOptions('Real estate valuation data set.xlsx');
%memilih kolom 1 yang berisi nomor rumah
opts.SelectedVariableNames = [1]; 
%Memilih baris 50 data teratas dari 2-51
opts.DataRange = '2:51';
%Menyimpan data yang dipilih dalam bentuk matrix kedalam rangking
rangking = readmatrix('Real estate valuation data set.xlsx', opts);
%mengkombinasikan rangking dengan VTranspose
rangking = [rangking VTranspose];
%sorting dari yang terbesar beradarkan kolom VTranspose atau kolom 2
rangking = sortrows(rangking,-2);
%memilih baris 1 sampai 10 kolom 1
rangking = rangking(1:10,1);
%menyimpan baris peratma kolom 1 kedalam rangkingTerbaik
rangkingTerbaik = rangking(1:1,1);

disp('Nomor Real Estate yang terbaik : ');
%Menampilkan isi rangkingTerbaik
disp(rangkingTerbaik);

disp('10 Nomor Real Estate dari yang terbaik : ');
%Menampilkan isi rangking
disp(rangking);
