% Fungsi Arithmetic Mean Filter
function output = arithmeticMeanFilter(img, kernel_size)
    % Membuat kernel filter rata-rata (average) dengan ukuran sesuai kernel_size
    h = fspecial('average', kernel_size);
    
    % Menerapkan filter rata-rata pada citra (img) menggunakan kernel yang telah dibuat
    % Opsi 'replicate' digunakan untuk menangani piksel di tepi gambar dengan
    % mereplikasi nilai-nilai piksel terdekat.
    output = imfilter(img, h, 'replicate');
end
