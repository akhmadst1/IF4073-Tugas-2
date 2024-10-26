function resultImage = harmonicMeanFilter(image, kernel_size)
    % Convert image to double
    image = im2double(image);
    [M, N, C] = size(image);  % Get dimensions (C will be 1 for grayscale)

    % Initialize result image
    resultImage = zeros(M, N, C);  % Keep as double for accuracy

    % Calculate kernel center
    kernelCenterRow = floor(kernel_size / 2) + 1;
    kernelCenterCol = floor(kernel_size / 2) + 1;

    % Perform convolution for each channel (handles grayscale too)
    for c = 1:C
        channel = image(:, :, c);  % Extract channel
        for i = 1:M
            for j = 1:N
                sum = 0;
                el = 0;

                for k = 1:kernel_size
                    for l = 1:kernel_size
                        row = i + k - kernelCenterRow;
                        col = j + l - kernelCenterCol;

                        % Check boundaries
                        if row >= 1 && row <= M && col >= 1 && col <= N
                            el = el + 1;  % Count valid elements
                            sum = sum + (1 / channel(row, col));  % Sum of inverses
                        end
                    end
                end

                % Calculate harmonic mean
                resultImage(i, j, c) = (sum > 0) * (el / sum);  % Use logical indexing
            end
        end
    end

    % Convert result image back to uint8 for displaying
    resultImage = uint8(resultImage * 255);
end
