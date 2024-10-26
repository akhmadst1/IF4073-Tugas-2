% Fungsi Harmonic Mean Filter
function output = harmonicMeanFilter(img, kernel_size)
    % Menghitung ukuran padding berdasarkan ukuran kernel
    pad_size = floor(kernel_size / 2);
    
    % Menambahkan padding pada citra asli (img) setelah dikonversi ke tipe
    % double untuk meningkatkan presisi perhitungan. Padding menggunakan metode 
    % 'replicate' untuk mereplikasi piksel di tepi.
    img_padded = padarray(double(img), [pad_size pad_size], 'replicate');
    
    % Menginisialisasi citra keluaran dengan ukuran yang sama seperti gambar asli
    % dan tipe data uint8.
    output = zeros(size(img), 'uint8');
    
    % Melakukan iterasi pada setiap piksel di citra asli
    for i = 1:size(img, 1)
        for j = 1:size(img, 2)
            % Mengambil wilayah (region) di sekitar piksel sesuai ukuran kernel
            region = img_padded(i:i+kernel_size-1, j:j+kernel_size-1);
            
            % Menghitung nilai Harmonic Mean dari wilayah tersebut.
            % Penggunaan 'eps' (nilai kecil mendekati nol) mencegah pembagian
            % dengan nol untuk piksel yang bernilai nol dalam region.
            output(i, j) = uint8(kernel_size^2 / sum(1 ./ (region(:) + eps)));
        end
    end
end
