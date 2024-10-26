function resultImage = geometricMeanFilter(image, kernel_size)
    % Convert image to double for processing
    image = im2double(image);

    % Get image dimensions
    [M, N, C] = size(image);

    % Initialize resultImage
    resultImage = zeros(M, N, C);  % Initialize result image for RGB

    % Calculate kernel center
    kernelCenterRow = floor(kernel_size / 2) + 1;
    kernelCenterCol = floor(kernel_size / 2) + 1;

    % Perform convolution
    for c = 1:C  % Loop through each channel for RGB images
        for i = 1:M
            for j = 1:N
                % Initialize variables for geometric mean calculation
                product = 1;  % Start with multiplicative identity
                el = 0;  % Element counter

                for k = 1:kernel_size
                    for l = 1:kernel_size
                        % Check if within boundaries of the image
                        row = i + k - kernelCenterRow;
                        col = j + l - kernelCenterCol;

                        if row >= 1 && row <= M && col >= 1 && col <= N
                            el = el + 1;  % Count valid elements
                            product = product * image(row, col);  % Multiply values
                        end
                    end
                end

                % Calculate the geometric mean if at least one valid element
                if el > 0
                    resultImage(i, j, c) = nthroot(product, el);  % Geometric mean
                else
                    resultImage(i, j, c) = 0;  % Avoid undefined mean
                end
            end
        end
    end

    % Convert the result to uint8 format for displaying
    resultImage = uint8(resultImage * 255);  % Scale back to uint8 range
end
