function filter = ILPFFilter(rows, cols, D0)
    % Fungsi untuk membuat Ideal Low-Pass Filter (ILPF) dalam domain frekuensi
    % Input:
    % - rows: jumlah baris dari filter (ukuran citra hasil padding)
    % - cols: jumlah kolom dari filter (ukuran citra hasil padding)
    % - D0: radius cutoff untuk filter low-pass
    % Output:
    % - filter: filter ideal low-pass berbentuk lingkaran di domain frekuensi
    
    % Inisialisasi ukuran dari filter
    P = rows;
    Q = cols;
    
    % Buat vektor koordinat u dan v
    u = 0:(P-1);
    v = 0:(Q-1);

    % Sesuaikan nilai u dan v sehingga pusat berada di koordinat tengah
    % Caranya adalah menggeser indeks yang lebih besar dari setengah ukuran matriks
    idx = find(u > P/2);
    u(idx) = u(idx) - P;
    idy = find(v > Q/2);
    v(idy) = v(idy) - Q;

    % Buat grid dua dimensi dari koordinat u dan v
    [V, U] = meshgrid(v, u);
    % Hitung jarak D setiap titik dalam filter dari pusat
    D = sqrt(U.^2 + V.^2);

    % Buat filter ideal low-pass H
    % Filter ini akan bernilai 1 untuk frekuensi yang jaraknya lebih kecil dari D0 (low frequency),
    % dan 0 untuk frekuensi yang lebih tinggi dari D0 (high frequency)
    H = double(D <= D0);

    % Kembalikan hasil filter
    filter = H;
end
