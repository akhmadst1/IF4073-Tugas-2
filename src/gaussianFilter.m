function gaussian_filtered_image = gaussianFilter(image, n, sigma)
    % Membuat filter Gaussian ukuran n x n dengan standar deviasi sigma
    [x, y] = meshgrid(-(n-1)/2:(n-1)/2, -(n-1)/2:(n-1)/2); % Matriks koordinat
    gaussian_filter = exp(-(x.^2 + y.^2) / (2 * sigma^2)); % Rumus Gaussian
    gaussian_filter = gaussian_filter / sum(gaussian_filter(:)); % Normalisasi

    % Melakukan konvolusi mean_filter dengan gambar
    gaussian_filtered_image = convolution(image, gaussian_filter);
end