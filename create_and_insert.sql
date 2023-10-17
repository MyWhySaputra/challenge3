-- create table Nasabah
CREATE TABLE IF NOT EXISTS nasabah (
    Id_Nasabah SERIAL PRIMARY KEY,
    Nama VARCHAR(255) NOT NULL,
    Alamat VARCHAR(255) NOT NULL,
    Nomor_Telepon VARCHAR(20) NOT NULL,
    Email VARCHAR(100),
    Tanggal_Lahir DATE NOT NULL,
    CreatedAt TIMESTAMP NOT NULL DEFAULT NOW(),
    UpdatedAt TIMESTAMP DEFAULT NOW(),
    DeletedAt TIMESTAMP
);

-- create table Akun
CREATE TABLE IF NOT EXISTS akun (
    Id_Akun SERIAL PRIMARY KEY,
    Id_Nasabah INT NOT NULL,
    Jenis_Akun VARCHAR(50) NOT NULL,
    Saldo DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (ID_Nasabah) REFERENCES Nasabah(ID_Nasabah),
    CreatedAt TIMESTAMP NOT NULL DEFAULT NOW(),
    UpdatedAt TIMESTAMP DEFAULT NOW(),
    DeletedAt TIMESTAMP
);

-- create table Transaksi
CREATE TABLE IF NOT EXISTS transaksi (
    Id_Transaksi SERIAL PRIMARY KEY,
    Id_Akun INT NOT NULL,
    Tanggal_Transaksi DATE NOT NULL,
    Jumlah_Transaksi DECIMAL(15, 2) NOT NULL,
    Keterangan VARCHAR(255),
    FOREIGN KEY (ID_Akun) REFERENCES Akun(ID_Akun),
    CreatedAt TIMESTAMP NOT NULL DEFAULT NOW(),
    UpdatedAt TIMESTAMP DEFAULT NOW(),
    DeletedAt TIMESTAMP
);

-- Create
-- Menambahkan nasabah baru
INSERT INTO nasabah (Nama, Alamat, Nomor_Telepon, Email, Tanggal_Lahir)
VALUES ('Saputra', 'Jl. Contoh No. 123', '081234567890', 'saputra@gmail.com', '2002-02-22'),
('Wahyu', 'Jl. Baru No. 456', '081234567890', 'wahyu@gmail.com', '2002-03-22'),
('Budi', 'Jl. Baru No. 789', '081234567890', 'budi@gmail.com', '2002-04-22');

-- Menambahkan akun baru untuk nasabah
INSERT INTO akun (Id_Nasabah, Jenis_Akun, Saldo)
VALUES (1, 'Tabungan', 5000.00),
(2, 'Tabungan', 6000.00),
(3, 'Tabungan', 7000.00);

-- Mencatat transaksi
INSERT INTO transaksi (Id_Akun, Tanggal_Transaksi, Jumlah_Transaksi, Keterangan)
VALUES (1, '2023-10-16', 1000.00, 'Setoran'),
(2, '2023-10-16', 2000.00, 'Setoran'),
(3, '2023-10-16', 3000.00, 'Setoran');

-- Read
-- Membaca data nasabah
SELECT * FROM nasabah;

-- Membaca data akun untuk seorang nasabah tertentu (misalnya, nasabah dengan ID_Nasabah=1)
SELECT * FROM akun WHERE Id_Nasabah = 1;

-- Membaca data transaksi untuk sebuah akun tertentu (misalnya, akun dengan ID_Akun=101)
SELECT * FROM transaksi WHERE Id_Akun = 1;

-- Update
-- Mengubah alamat seorang nasabah
UPDATE nasabah
SET Alamat = 'Jl. Baru No. 123'
WHERE Id_Nasabah = 1;

-- Mengupdate saldo akun setelah transaksi
UPDATE akun
SET Saldo = Saldo + 500.00
WHERE Id_Akun = 1;

-- Delete
-- Menghapus nasabah dan semua akun yang terkait dengannya
DELETE FROM nasabah WHERE Id_Nasabah = 1;

-- Menghapus transaksi tertentu
DELETE FROM transaksi WHERE Id_Transaksi = 1;