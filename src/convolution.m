function result = convolution(image, mask)
    % Mendapatkan ukuran citra dan mask
    % M, N adalah ukuran citra; C adalah jumlah channel
    [M, N, C] = size(image);
    
    % n adalah ukuran mask (diasumsikan mask berbentuk kotak)
    [n, ~] = size(mask);
    
    % Menentukan padding yang diperlukan berdasarkan ukuran mask
    pad = floor(n / 2);
    
    % Melakukan padding nilai 0 pada citra
    paddedImage = padarray(double(image), [pad pad], 0, 'both');
    
    % Inisialisasi hasil konvolusi
    result = zeros(M, N, C);
    
    % Looping untuk setiap pixel citra
    for channel = 1:C % Jika citra berwarna, lakukan per channel
        for i = 1:M
            for j = 1:N
                % Mendapatkan region citra sesuai dengan ukuran mask
                region = paddedImage(i:i + 2*pad, j:j + 2*pad, channel);
                
                % Menghitung hasil konvolusi dengan melakukan perkalian elemenwise dan menjumlahkan hasilnya
                result(i, j, channel) = sum(sum(region .* mask));
            end
        end
    end
    
    % Konversi hasil kembali ke tipe uint8 jika input adalah uint8
    if isa(image, 'uint8')
        result = uint8(result);
    end
end