function resultImage = GHPF(inputImage, D0)
    % Fungsi untuk melakukan high-pass filtering menggunakan Gaussian High-Pass Filter (GHPF)
    
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

    % Step 3: Membuat filter Gaussian high-pass
    % Filter GHPF dibuat dengan mengurangkan hasil Gaussian low-pass dari 1
    H = 1 - GLPFFilter(P, Q, D0);

    % Step 4: Terapkan filter pada citra di domain frekuensi
    fourierImage = fourierImage .* H;

    % Step 5: Transformasi balik Fourier untuk mendapatkan citra hasil
    resultImage = real(ifft2(fourierImage));

    % Ambil kembali bagian awal citra agar sesuai dengan ukuran asli
    resultImage = resultImage(1:M, 1:N);
end
