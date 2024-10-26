function resultImage = BLPF(inputImage, D0, n)
    % Fungsi untuk melakukan smoothing/blurring menggunakan Butterworth Low-Pass Filter (BLPF)
    
    % Step 1: Persiapan padding citra
    % Ambil ukuran asli citra input
    [M, N] = size(inputImage);
    % Hitung ukuran baru setelah padding (dua kali ukuran asli)
    P = 2 * M;
    Q = 2 * N;
    
    % Konversi citra input ke tipe double untuk perhitungan presisi
    inputImage = im2double(inputImage);
    % Buat citra yang dipad (diperluas) dengan ukuran P x Q, diisi nol
    resultImage = zeros(P, Q);
    
    % Isi bagian awal dari citra hasil dengan data dari citra input
    for i = 1:P
        for j = 1:Q
            if i <= M && j <= N
                resultImage(i, j) = inputImage(i, j);
            else
                resultImage(i, j) = 0; % Sisa bagian citra diisi dengan nol
            end
        end
    end

    % Step 2: Transformasi Fourier ke domain frekuensi
    fourierImage = fft2(double(resultImage));

    % Step 3: Membuat filter Butterworth low-pass
    % D0 digunakan untuk menentukan ukuran filter berdasarkan frekuensi
    H = createBLPFFilter(P, Q, D0, n);

    % Step 4: Terapkan filter pada citra di domain frekuensi
    fourierImage = fourierImage .* H;

    % Step 5: Transformasi balik Fourier untuk mendapatkan citra hasil
    resultImage = real(ifft2(fourierImage));

    % Ambil kembali bagian awal citra agar sesuai dengan ukuran asli
    resultImage = resultImage(1:M, 1:N);
end
