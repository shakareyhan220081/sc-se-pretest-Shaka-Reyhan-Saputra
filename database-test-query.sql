-- DDL
CREATE TABLE IF NOT EXISTS kategori (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(150) NOT NULL,
    alamat TEXT NOT NULL,
    no_ktp VARCHAR(50) NOT NULL,
    no_hp VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS buku (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kategori_id INT NOT NULL,
    judul VARCHAR(200) NOT NULL,
    pengarang VARCHAR(150) NOT NULL,
    penerbit VARCHAR(150) NOT NULL,
    isbn VARCHAR(50) NOT NULL,
    tahun_terbit INT NOT NULL,
    jumlah_tersedia INT NOT NULL,
    CONSTRAINT fk_buku_kategori FOREIGN KEY (kategori_id) REFERENCES kategori(id)
);

CREATE TABLE IF NOT EXISTS peminjaman (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    buku_id INT NOT NULL,
    tanggal_pinjam DATE NOT NULL,
    tanggal_jatuh_tempo DATE NOT NULL,
    tanggal_kembali DATE,
    CONSTRAINT fk_peminjaman_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_peminjaman_buku FOREIGN KEY (buku_id) REFERENCES buku(id)
);

-- DML Seed Data
INSERT INTO kategori (nama_kategori) VALUES
('Teknologi'),
('Sains'),
('Fiksi'),
('Sejarah'),
('Bisnis');

INSERT INTO users (nama, alamat, no_ktp, no_hp, email) VALUES
('User 1', 'Jl. Merdeka No. 1', '3273010101010001', '081234567891', 'user1@email.com'),
('User 2', 'Jl. Merdeka No. 2', '3273010101010002', '081234567892', 'user2@email.com'),
('User 3', 'Jl. Merdeka No. 3', '3273010101010003', '081234567893', 'user3@email.com'),
('User 4', 'Jl. Merdeka No. 4', '3273010101010004', '081234567894', 'user4@email.com'),
('User 5', 'Jl. Merdeka No. 5', '3273010101010005', '081234567895', 'user5@email.com');

INSERT INTO buku (kategori_id, judul, pengarang, penerbit, isbn, tahun_terbit, jumlah_tersedia) VALUES
(1, 'Buku 1', 'Pengarang 1', 'Penerbit A', '978-0-01', 2021, 5),
(1, 'Buku 2', 'Pengarang 2', 'Penerbit A', '978-0-02', 2021, 4),
(2, 'Buku 3', 'Pengarang 3', 'Penerbit B', '978-0-03', 2022, 3),
(2, 'Buku 4', 'Pengarang 4', 'Penerbit B', '978-0-04', 2022, 2),
(3, 'Buku 5', 'Pengarang 5', 'Penerbit C', '978-0-05', 2020, 6),
(3, 'Buku 6', 'Pengarang 6', 'Penerbit C', '978-0-06', 2023, 7),
(4, 'Buku 7', 'Pengarang 7', 'Penerbit D', '978-0-07', 2019, 3),
(4, 'Buku 8', 'Pengarang 8', 'Penerbit D', '978-0-08', 2020, 5),
(5, 'Buku 9', 'Pengarang 9', 'Penerbit E', '978-0-09', 2024, 2),
(5, 'Buku 10', 'Pengarang 10', 'Penerbit E', '978-0-10', 2024, 8);

INSERT INTO peminjaman (user_id, buku_id, tanggal_pinjam, tanggal_jatuh_tempo, tanggal_kembali) VALUES
(1, 1, '2026-03-01', '2026-03-08', '2026-03-07'),
(1, 2, '2026-03-02', '2026-03-09', '2026-03-09'),
(1, 3, '2026-03-03', '2026-03-10', '2026-03-08'),
(2, 4, '2026-03-04', '2026-03-11', '2026-03-11'),
(2, 5, '2026-03-05', '2026-03-12', '2026-03-10'),
(2, 6, '2026-03-06', '2026-03-13', '2026-03-12'),
(3, 7, '2026-03-01', '2026-03-08', '2026-03-13'),
(3, 8, '2026-03-02', '2026-03-09', '2026-03-08'),
(3, 9, '2026-03-03', '2026-03-10', '2026-03-09');

-- Soal 2
SELECT 
    b.judul AS Buku
FROM buku b
LEFT JOIN peminjaman p ON b.id = p.buku_id
WHERE p.id IS NULL;

-- Soal 3
SELECT 
    u.nama AS User,
    CONCAT('Rp', SUM(DATEDIFF(p.tanggal_kembali, p.tanggal_jatuh_tempo) * 1000)) AS Denda
FROM peminjaman p
JOIN users u ON p.user_id = u.id
WHERE p.tanggal_kembali > p.tanggal_jatuh_tempo
GROUP BY u.id, u.nama;

-- Soal 4
SELECT 
    ROW_NUMBER() OVER (ORDER BY u.id ASC) AS No,
    u.nama AS User,
    GROUP_CONCAT(b.judul ORDER BY b.id DESC SEPARATOR ', ') AS Buku
FROM peminjaman p
JOIN users u ON p.user_id = u.id
JOIN buku b ON p.buku_id = b.id
GROUP BY u.id, u.nama
ORDER BY u.id ASC;