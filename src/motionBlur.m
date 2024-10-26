function [imageMotionBlur, imageDeblurred] = motionBlur(image, len, theta)

    % Pilih gambar
    I = imread(image);
    I = im2double(I); 
    
    % Melakukan motion blur
    PSF = fspecial('motion', len, theta);
    imageMotionBlur = imfilter(I, PSF, 'conv', 'circular');
    
    % Menampilkan gambar blur
    figure, imshow(imageMotionBlur), title('Motion-Blurred Image');
    
    % Dekonvolusi Citra dengan Penapis Wiener
    % Ubah PSF ke domain frekuensi
    PSFfreq = psf2otf(PSF, size(imageMotionBlur));
    
    % Set Noise to Signal Ratio (NSR)
    NSR = 0.01; 
    
    % Penapis Wiener
    Hconj = conj(PSFfreq);
    Wienerfilter = Hconj ./ (abs(PSFfreq).^2 + NSR);
    imageMotionBlurFreq = fft2(imageMotionBlur);
    imageDeblurredFreq = Wienerfilter .* imageMotionBlurFreq;
    
    % Ubah menjadi domain spasial
    imageDeblurred = real(ifft2(imageDeblurredFreq));
    
    % Menampilkan citra hasil deblur
    figure, imshow(imageDeblurred), title('Deblurred Image using Wiener Filter');
    
    % Perbedaan citra original dan citra deblur
    figure; imshow(imabsdiff(I, imageDeblurred));
    title('Differences between Original Image and Blurred Image')

end

