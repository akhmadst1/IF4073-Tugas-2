% Fungsi Alpha-Trimmed Mean Filter
function output = alphaTrimmedMeanFilter(img, kernel_size, d)
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
            
            % Mengurutkan piksel dalam region dari terkecil ke terbesar
            sorted_region = sort(region(:));
            
            % Memangkas (trim) piksel yang berjumlah d dari bagian atas dan bawah
            % daerah yang sudah diurutkan
            trimmed_region = sorted_region(ceil(d/2)+1 : end-floor(d/2));
            
            % Menghitung rata-rata dari piksel yang tersisa setelah pemangkasan
            % dan menetapkannya ke piksel yang sesuai di output.
            output(i, j) = uint8(mean(trimmed_region));
        end
    end
end
