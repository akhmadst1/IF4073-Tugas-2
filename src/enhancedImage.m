function enhancedImg = enhancedImage(image, brightnessValue, contrastValue)
    
    % Pilih gambar
    I = imread(image);
    
    % Pisah menjadi channel Red, Green, dan Blue
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
        
    % Modifikasi masing-masing channel     
    redEnhanced = dct(R, brightnessValue, contrastValue);
    greenEnhanced = dct(G, brightnessValue, contrastValue);
    blueEnhanced = dct(B, brightnessValue, contrastValue);
        
    % Menggabungkann channel warna
    enhancedImg = cat(3, redEnhanced, greenEnhanced, blueEnhanced);

    % Menampilkan gambar hasil enhanced
    figure;
    subplot(1,2,1); imshow(I); title('Original Image');
    subplot(1,2,2); imshow(enhancedImg); title('Enhanced Image');

end

