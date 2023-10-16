-- create table Nasabah
CREATE TABLE IF NOT EXISTS Nasabah (
    ID_Nasabah SERIAL PRIMARY KEY,
    Nama VARCHAR(255),
    Alamat VARCHAR(255),
    Nomor_Telepon VARCHAR(20),
    Email VARCHAR(100),
    Tanggal_Lahir DATE,
    createdAt TIMESTAMP NOT NULL DEFAULT NOW(),
    updatedAt TIMESTAMP DEFAULT NOW(),
    deletedAt TIMESTAMP
);

-- create table Akun
CREATE TABLE IF NOT EXISTS Akun (
    ID_Akun SERIAL PRIMARY KEY,
    ID_Nasabah INT,
    Jenis_Akun VARCHAR(50),
    Saldo DECIMAL(15, 2),
    FOREIGN KEY (ID_Nasabah) REFERENCES Nasabah(ID_Nasabah),
    createdAt TIMESTAMP NOT NULL DEFAULT NOW(),
    updatedAt TIMESTAMP DEFAULT NOW(),
    deletedAt TIMESTAMP
);

-- create table Transaksi
CREATE TABLE IF NOT EXISTS Transaksi (
    ID_Transaksi SERIAL PRIMARY KEY,
    ID_Akun INT,
    Tanggal_Transaksi DATE,
    Jumlah_Transaksi DECIMAL(15, 2),
    Keterangan VARCHAR(255),
    FOREIGN KEY (ID_Akun) REFERENCES Akun(ID_Akun),
    createdAt TIMESTAMP NOT NULL DEFAULT NOW(),
    updatedAt TIMESTAMP DEFAULT NOW(),
    deletedAt TIMESTAMP
);

-- Create
-- Menambahkan nasabah baru
INSERT INTO Nasabah (ID_Nasabah, Nama, Alamat, Nomor_Telepon, Email, Tanggal_Lahir)
VALUES (1, 'Saputra', 'Jl. Contoh No. 123', '081234567890', 'saputra@gmail.com', '2002-02-22');

-- Menambahkan akun baru untuk nasabah
INSERT INTO Akun (ID_Akun, ID_Nasabah, Jenis_Akun, Saldo)
VALUES (101, 1, 'Tabungan', 5000.00);

-- Mencatat transaksi
INSERT INTO Transaksi (ID_Transaksi, ID_Akun, Tanggal_Transaksi, Jumlah_Transaksi, Keterangan)
VALUES (1001, 101, '2023-10-16', 1000.00, 'Setoran');

-- Read
-- Membaca data nasabah
SELECT * FROM Nasabah;

-- Membaca data akun untuk seorang nasabah tertentu (misalnya, nasabah dengan ID_Nasabah=1)
SELECT * FROM Akun WHERE ID_Nasabah = 1;

-- Membaca data transaksi untuk sebuah akun tertentu (misalnya, akun dengan ID_Akun=101)
SELECT * FROM Transaksi WHERE ID_Akun = 101;

-- Update
-- Mengubah alamat seorang nasabah
UPDATE Nasabah
SET Alamat = 'Jl. Baru No. 456'
WHERE ID_Nasabah = 1;

-- Mengupdate saldo akun setelah transaksi
UPDATE Akun
SET Saldo = Saldo + 500.00
WHERE ID_Akun = 101;

-- Delete
-- Menghapus nasabah dan semua akun yang terkait dengannya
DELETE FROM Nasabah WHERE ID_Nasabah = 1;

-- Menghapus transaksi tertentu
DELETE FROM Transaksi WHERE ID_Transaksi = 1001;