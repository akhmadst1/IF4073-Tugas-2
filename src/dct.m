function enhancedChannel = dct(channel, brightnessValue, contrastValue)

    % Memanfaatkan Discrete Cosine Transform
    dctChannel = dct2(double(channel));
    
    % Modifikasi nilai dari kecerahan
    dctChannel(1,1) = dctChannel(1,1) * brightnessValue;
    
    % Modifikasi nilai dari kontras
    [row, col] = size(dctChannel);
    for i = 1:row
        for j = 1:col
            if i > 1 || j > 1 
                dctChannel(i,j) = dctChannel(i,j) * contrastValue;
            end
        end
    end
    
    % inverse DCT
    enhancedChannel = uint8(idct2(dctChannel));

end