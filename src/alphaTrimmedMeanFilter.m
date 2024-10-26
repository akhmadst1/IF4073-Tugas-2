% Alpha-Trimmed Mean Filter Function
function output = alphaTrimmedMeanFilter(img, kernel_size, d)
    % Calculate padding size based on kernel
    pad_size = floor(kernel_size / 2);
    
    % Initialize output with the same type as the input image
    output = zeros(size(img), 'like', img);
    
    % Check if the image is grayscale or RGB
    if size(img, 3) == 1
        % Grayscale image: apply filter directly
        img_padded = padarray(double(img), [pad_size pad_size], 'replicate');
        output = applyAlphaTrimmed(img_padded, kernel_size, d);
    else
        % RGB image: apply filter to each channel separately
        for c = 1:3
            img_padded = padarray(double(img(:, :, c)), [pad_size pad_size], 'replicate');
            output(:, :, c) = applyAlphaTrimmed(img_padded, kernel_size, d);
        end
    end
end

% Helper function to apply alpha-trimmed mean filter to a single channel
function filtered = applyAlphaTrimmed(img_padded, kernel_size, d)
    % Initialize the filtered image
    filtered = zeros(size(img_padded) - kernel_size + 1, 'double');
    
    % Iterate over each pixel in the original image
    for i = 1:size(filtered, 1)
        for j = 1:size(filtered, 2)
            % Extract region around the current pixel
            region = img_padded(i:i+kernel_size-1, j:j+kernel_size-1);
            
            % Sort the pixels in the region and trim `d` pixels
            sorted_region = sort(region(:));
            trimmed_region = sorted_region(ceil(d/2)+1 : end-floor(d/2));
            
            % Calculate the mean of the trimmed region
            filtered(i, j) = mean(trimmed_region);
        end
    end
    
    % Convert back to uint8 for display
    filtered = uint8(filtered);
end
