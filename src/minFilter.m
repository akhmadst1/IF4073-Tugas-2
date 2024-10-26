% Fungsi Min Filter
function output = minFilter(img, kernel_size)
    % Menghitung ukuran padding berdasarkan ukuran kernel
    pad_size = floor(kernel_size / 2);
    
    % Menambahkan padding pada citra asli (img) untuk menangani batas gambar
    % dengan nilai tak hingga (Inf) sebagai nilai padding.
    % Penggunaan Inf memastikan bahwa nilai piksel di luar gambar tidak akan
    % mempengaruhi hasil minimum dari filter.
    img_padded = padarray(img, [pad_size pad_size], Inf);
    
    % Menginisialisasi citra keluaran dengan ukuran yang sama seperti gambar asli
    % dan tipe data uint8.
    output = zeros(size(img), 'uint8');
    
    % Melakukan iterasi pada setiap piksel di citra asli
    for i = 1:size(img, 1)
        for j = 1:size(img, 2)
            % Mengambil wilayah (region) di sekitar piksel sesuai ukuran kernel
            region = img_padded(i:i+kernel_size-1, j:j+kernel_size-1);
            
            % Menetapkan nilai minimum dari wilayah yang dipilih ke piksel yang
            % sesuai di output.
            output(i, j) = min(region(:));
        end
    end
end
