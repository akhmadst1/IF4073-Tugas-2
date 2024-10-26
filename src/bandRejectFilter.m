function [imageFrequency, denoisedImage, denoisedImageFrequency] = bandRejectFilter(image, D0, w)
    % Step 1: Padding the image to avoid edge artifacts in frequency domain
    [M, N, ~] = size(image); % Original image dimensions
    paddedImage = padarray(image, [M, N], 0, "post"); % Zero-padding
    [P, Q, ~] = size(paddedImage); % Dimensions after padding

    % Step 2: Convert to double for FFT processing and take the Fourier Transform
    imageDouble = im2double(paddedImage); % Normalize pixel values to [0,1] range
    fftImage = fftshift(fft2(imageDouble)); % Shift zero frequency to center

    % Step 3: Create log-transformed magnitude spectrum for visualization
    imageFrequency = log(1 + abs(fftImage)) / 16; % Scale log spectrum for better visibility

    % Step 4: Generate meshgrid coordinates centered around the frequency domain origin
    u = 0:(P-1); % Row indices
    v = 0:(Q-1); % Column indices
    
    % Adjust row and column indices for circular frequency domain coordinates
    idx = find(u > P/2); % Rows beyond halfway point
    u(idx) = P - u(idx); % Wrap around indices for frequency domain symmetry
    idy = find(v > Q/2); % Columns beyond halfway point
    v(idy) = Q - v(idy); % Wrap around indices

    % Shift origin to the center for both row and column
    u = P/2 - u;
    v = Q/2 - v;
    [V, U] = meshgrid(v, u); % Generate grid for D calculation

    % Step 5: Calculate distance matrix D from the origin (frequency distance)
    D = sqrt(U.^2 + V.^2); % Distance formula from origin for each point

    % Step 6: Create Band-Reject Filter (H)
    % H is 1 where D is outside the range [D0 - w/2, D0 + w/2]
    % (i.e., retains frequencies outside this band)
    H = double(D <= (D0 - w / 2)) | double(D >= (D0 + w / 2));

    % Step 7: Apply the filter in the frequency domain
    denoisedImageFrequency = H .* imageFrequency; % Filtered frequency spectrum for visualization
    fftImageFiltered = H .* fftImage; % Apply filter to original Fourier Transform

    % Step 8: Inverse FFT to return to spatial domain and crop to original size
    denoisedImage = abs(ifft2(ifftshift(fftImageFiltered))); % Inverse FFT and take magnitude
    denoisedImage = denoisedImage(1:M, 1:N, :); % Crop back to original image size
end
