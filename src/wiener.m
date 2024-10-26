% Function to perform Wiener deconvolution with a given PSF
function result = wiener(image, PSF, NSR)
    % Ensure the input image is in double format
    image = im2double(image);

    % Calculate the Fourier transforms of the input image and PSF
    F_image = fft2(image);
    F_PSF = fft2(PSF, size(image, 1), size(image, 2));

    % Calculate the Wiener filter transfer function
    H = conj(F_PSF) ./ (abs(F_PSF).^2 + NSR);

    % Apply the Wiener filter in the frequency domain
    F_deconvolved = F_image .* H;

    % Inverse Fourier transform to obtain the deconvolved image
    deconvolved_image = ifft2(F_deconvolved);

    % Ensure the result is real and in the range [0, 1]
    deconvolved_image = real(deconvolved_image);
    result = max(0, min(1, deconvolved_image));
end
