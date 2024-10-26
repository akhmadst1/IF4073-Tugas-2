% Fungsi Max Filter
function output = maxFilter(img, kernel_size)
    % Menghitung ukuran padding berdasarkan ukuran kernel
    pad_size = floor(kernel_size / 2);
    
    % Menambahkan padding pada citra asli (img) dengan nilai -Inf di sekelilingnya
    % untuk memastikan bahwa nilai maksimum pada tepi citra dapat dihitung dengan benar
    img_padded = padarray(img, [pad_size pad_size], -Inf);
    
    % Menginisialisasi citra keluaran dengan ukuran yang sama seperti gambar asli
    % dan tipe data uint8.
    output = zeros(size(img), 'uint8');
    
    % Melakukan iterasi pada setiap piksel di citra asli
    for i = 1:size(img, 1)
        for j = 1:size(img, 2)
            % Mengambil wilayah (region) di sekitar piksel sesuai ukuran kernel
            region = img_padded(i:i+kernel_size-1, j:j+kernel_size-1);
            
            % Menetapkan nilai maksimum dari elemen di dalam region ke piksel (i, j)
            % di citra keluaran
            output(i, j) = max(region(:));
        end
    end
end
