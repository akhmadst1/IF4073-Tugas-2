% Fungsi Midpoint Filter
function output = midpointFilter(img, kernel_size)
    % Menghitung ukuran padding berdasarkan ukuran kernel
    pad_size = floor(kernel_size / 2);
    
    % Menambahkan padding pada citra asli (img) untuk menangani batas gambar
    % dengan metode 'replicate', yang mereplikasi piksel tepi.
    img_padded = padarray(img, [pad_size pad_size], 'replicate');
    
    % Menginisialisasi citra keluaran dengan ukuran yang sama seperti gambar asli
    % dan tipe data uint8.
    output = zeros(size(img), 'uint8');
    
    % Melakukan iterasi pada setiap piksel di citra asli
    for i = 1:size(img, 1)
        for j = 1:size(img, 2)
            % Mengambil wilayah (region) di sekitar piksel sesuai ukuran kernel
            region = img_padded(i:i+kernel_size-1, j:j+kernel_size-1);
            
            % Menghitung nilai tengah (midpoint) dari wilayah yang dipilih,
            % yaitu rata-rata antara nilai minimum dan maksimum dalam wilayah tersebut
            output(i, j) = uint8((min(region(:)) + max(region(:))) / 2);
        end
    end
end
