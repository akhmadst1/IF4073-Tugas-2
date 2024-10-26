% Arithmetic Mean Filter Function
function output = arithmeticMeanFilter(img, kernel_size)
    % Create an average filter kernel of the specified size
    h = fspecial('average', kernel_size);
    
    % Check if the image is grayscale or RGB
    if size(img, 3) == 1
        % Grayscale image: apply filter directly
        output = imfilter(img, h, 'replicate');
    else
        % RGB image: apply filter to each channel separately
        output = zeros(size(img), 'like', img);  % Initialize output with same type and size as input
        for c = 1:3
            output(:, :, c) = imfilter(img(:, :, c), h, 'replicate');
        end
    end
end
