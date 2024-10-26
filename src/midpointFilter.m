% Midpoint Filter Function
function output = midpointFilter(img, kernel_size)
    % Calculate padding size based on kernel
    pad_size = floor(kernel_size / 2);

    % Initialize output with the same size as input, in double format
    output = zeros(size(img), 'double');

    % Check if the image is grayscale or RGB
    if size(img, 3) == 1
        % Grayscale image: apply filter directly
        img_padded = padarray(img, [pad_size, pad_size], 'replicate');

        for i = 1:size(img, 1)
            for j = 1:size(img, 2)
                region = img_padded(i:i+kernel_size-1, j:j+kernel_size-1);
                output(i, j) = (min(region(:)) + max(region(:))) / 2;
            end
        end
    else
        % RGB image: apply filter to each channel separately
        for c = 1:3
            img_channel = img(:, :, c);
            img_padded = padarray(img_channel, [pad_size, pad_size], 'replicate');

            for i = 1:size(img, 1)
                for j = 1:size(img, 2)
                    region = img_padded(i:i+kernel_size-1, j:j+kernel_size-1);
                    output(i, j, c) = (min(region(:)) + max(region(:))) / 2;
                end
            end
        end
    end
end
