% Fungsi Median Filter
function output = medianFilter(img, kernel_size)
    % Menghitung ukuran padding berdasarkan ukuran kernel
    pad_size = floor(kernel_size / 2);
    
    % Menambahkan padding pada citra asli (img) untuk menangani batas gambar
    % dengan metode 'symmetric', yang mencerminkan piksel di tepi gambar.
    img_padded = padarray(img, [pad_size pad_size], 'symmetric');
    
    % Menginisialisasi citra keluaran dengan ukuran yang sama seperti gambar asli
    % dan tipe data uint8.
    output = zeros(size(img), 'uint8');
    
    % Melakukan iterasi pada setiap piksel di citra asli
    for i = 1:size(img, 1)
        for j = 1:size(img, 2)
            % Mengambil wilayah (region) di sekitar piksel sesuai ukuran kernel
            region = img_padded(i:i+kernel_size-1, j:j+kernel_size-1);
            
            % Menentukan nilai median dari piksel dalam wilayah yang dipilih
            % dan menetapkannya ke piksel yang sesuai di output
            output(i, j) = median(region(:));
        end
    end
end
