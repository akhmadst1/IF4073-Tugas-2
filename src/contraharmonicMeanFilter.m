% Fungsi Contraharmonic Mean Filter
function output = contraharmonicMeanFilter(img, kernel_size, Q)
    % Menghitung ukuran padding berdasarkan ukuran kernel
    pad_size = floor(kernel_size / 2);
    
    % Menambahkan padding pada citra asli (img) setelah dikonversi ke tipe
    % double untuk presisi lebih tinggi dalam perhitungan. Padding menggunakan
    % metode 'replicate' untuk mereplikasi piksel di tepi.
    img_padded = padarray(double(img), [pad_size pad_size], 'replicate');
    
    % Menginisialisasi citra keluaran dengan ukuran yang sama seperti gambar asli
    % dan tipe data uint8.
    output = zeros(size(img), 'uint8');
    
    % Melakukan iterasi pada setiap piksel di citra asli
    for i = 1:size(img, 1)
        for j = 1:size(img, 2)
            % Mengambil wilayah (region) di sekitar piksel sesuai ukuran kernel
            region = img_padded(i:i+kernel_size-1, j:j+kernel_size-1);
            
            % Menghitung nilai pembilang (num) sebagai jumlah dari setiap elemen
            % dalam region dipangkatkan (Q + 1).
            num = sum(region(:).^(Q + 1));
            
            % Menghitung nilai penyebut (den) sebagai jumlah dari setiap elemen
            % dalam region dipangkatkan Q, ditambah eps untuk mencegah pembagian
            % dengan nol.
            den = sum(region(:).^Q + eps);
            
            % Menghitung nilai Contraharmonic Mean untuk piksel (i, j)
            % dan menetapkannya pada citra keluaran
            output(i, j) = uint8(num / den);
        end
    end
end
