function resultImage = contraharmonicMeanFilter(image, kernel_size, Q)
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
                numerator = 0;
                denumerator = 0;

                for k = 1:kernel_size
                    for l = 1:kernel_size
                        row = i + k - kernelCenterRow;
                        col = j + l - kernelCenterCol;

                        % Check boundaries
                        if row >= 1 && row <= M && col >= 1 && col <= N
                            numerator = numerator + channel(row, col)^(Q + 1);  % Accumulate numerator
                            denumerator = denumerator + channel(row, col)^Q;  % Accumulate denominator
                        end
                    end
                end

                % Calculate contraharmonic mean
                if denumerator > 0
                    resultImage(i, j, c) = numerator / denumerator;  % Avoid division by zero
                else
                    resultImage(i, j, c) = 0;  % Fallback for undefined mean
                end
            end
        end
    end

    % Convert result image back to uint8 for displaying
    resultImage = uint8(resultImage * 255);
end
