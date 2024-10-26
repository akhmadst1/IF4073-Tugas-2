function filter = BLPFFilter(rows, cols, D0, n)
    % Fungsi untuk membuat Butterworth Low-Pass Filter (BLPF) dalam domain frekuensi
    % Input:
    % - rows: jumlah baris dari filter (ukuran citra hasil padding)
    % - cols: jumlah kolom dari filter (ukuran citra hasil padding)
    % - D0: radius cutoff untuk filter low-pass
    % - n: orde filter Butterworth
    % Output:
    % - filter: filter Butterworth low-pass berbentuk lingkaran di domain frekuensi
    
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

    % Buat filter Butterworth H
    % Filter ini akan memberikan bobot yang lebih tinggi pada frekuensi rendah
    % dan mengurangi bobot pada frekuensi tinggi, sehingga menghasilkan efek smoothing
    H = 1 ./ (1 + (D ./ D0).^(2 * n));

    % Kembalikan hasil filter
    filter = H;
end
