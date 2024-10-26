function mean_filtered_image = meanFilter(image, n)
    % Membuat matriks filter rata-rata (mean filter) ukuran n x n
    mean_filter = ones(n, n) / (n * n);

    % Melakukan konvolusi mean_filter dengan gambar
    mean_filtered_image = convolution(image, mean_filter);
end