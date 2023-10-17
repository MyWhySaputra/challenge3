-- create table Nasabah
CREATE TABLE IF NOT EXISTS nasabah (
    Id SERIAL PRIMARY KEY,
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
    Id SERIAL PRIMARY KEY,
    Id_Nasabah INT NOT NULL,
    Jenis_Akun VARCHAR(50) NOT NULL,
    Saldo DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (ID_Nasabah) REFERENCES Nasabah(Id),
    CreatedAt TIMESTAMP NOT NULL DEFAULT NOW(),
    UpdatedAt TIMESTAMP DEFAULT NOW(),
    DeletedAt TIMESTAMP
);

-- create table Transaksi
CREATE TABLE IF NOT EXISTS transaksi (
    Id SERIAL PRIMARY KEY,
    Id_Akun INT NOT NULL,
    Tanggal_Transaksi DATE NOT NULL,
    Keterangan VARCHAR(255),
    FOREIGN KEY (ID_Akun) REFERENCES Akun(Id),
    CreatedAt TIMESTAMP NOT NULL DEFAULT NOW(),
    UpdatedAt TIMESTAMP DEFAULT NOW(),
    DeletedAt TIMESTAMP
);

-- ubah tipe data pada table nasabah kolom no_telp
-- ALTER TABLE nasabah
-- ALTER COLUMN Nomor_Telepon TYPE VARCHAR(20);

-- CRUD nasabah
-- CREATE
-- Menambahkan nasabah baru
INSERT INTO nasabah (Nama, Alamat, Nomor_Telepon, Email, Tanggal_Lahir)
VALUES ('Saputra', 'Jl. Contoh No. 123', '081234567890', 'saputra@gmail.com', '2002-02-22'),
('Wahyu', 'Jl. Baru No. 456', '081234567890', 'wahyu@gmail.com', '2002-03-22'),
('Budi', 'Jl. Baru No. 789', '081234567890', 'budi@gmail.com', '2002-04-22'),
('Rudi', 'Jl. Baru No. 987', '081234567890', 'rudi@gmail.com', '2002-05-22'),
('Andi', 'Jl. Baru No. 123', '081234567890', 'andi@gmail.com', '2002-06-22');

-- Indexing
CREATE INDEX idx_nasabah ON nasabah (Nama);

-- READ
-- Menampilkan seluruh data nasabah
SELECT * FROM nasabah ORDER BY Nama ASC;

-- UPDATE
-- Mengubah alamat seorang nasabah
UPDATE nasabah
SET Alamat = 'Jl. Baru No. 123'
WHERE Id = 1;

-- DELETE
-- Menghapus nasabah
DELETE FROM nasabah WHERE Id = 1;

-- CRUD akun
-- CREATE
-- Menambahkan akun baru untuk nasabah
INSERT INTO akun (Id_Nasabah, Jenis_Akun, Saldo)
VALUES (2, 'Tabungan', 6000.00),
(3, 'Tabungan', 7000.00),
(4, 'Tabungan', 8000.00),
(5, 'Tabungan', 9000.00);

-- Indexing
CREATE INDEX idx_akun ON akun (Jenis_Akun);

-- READ
-- Membaca data nasabah dan data akun
SELECT * FROM nasabah INNER JOIN akun ON nasabah.Id = akun.Id_Nasabah;

-- UPDATE
CREATE OR REPLACE PROCEDURE transfer (
    idPengirim INT,
    idPenerima INT,
    nominal DECIMAL(15, 2)
)
LANGUAGE plpgsql
as $$
BEGIN
    -- Mengupdate saldo akun pengirim
    UPDATE akun
    SET Saldo = Saldo - nominal
    WHERE Id = idPengirim;
    -- Mengupdate saldo akun penerima
    UPDATE akun
    SET Saldo = Saldo + nominal
    WHERE Id = idPenerima;

    COMMIT;
END;
$$;

-- transfer dari id_akun 2 ke id_akun 3
CALL transfer(2, 3, 1000.00);

-- QUERY CTE
WITH nasabah_saldo AS (
    SELECT nama,saldo
    FROM nasabah INNER JOIN akun
    ON nasabah.Id = akun.Id_Nasabah;
)

SELECT nama, saldo FROM nasabah_saldo
ORDER BY nama ASC;

-- DELETE
-- Menghapus akun
DELETE FROM akun WHERE Id = 5;

-- CRUD transaksi
-- CREATE
-- Menambahkan transaksi baru
INSERT INTO transaksi (Id_Akun, Tanggal_Transaksi, Keterangan)
VALUES(2, '2023-10-16', 'Belanja'),
(3, '2023-10-16', 'Menabung'),
(4, '2023-10-16', 'Setoran');

-- Indexing
CREATE INDEX idx_transaksi ON transaksi (Keterangan);

-- READ
-- Membaca data transaksi
SELECT * FROM transaksi WHERE Id_Akun = 3;

-- UPDATE
-- Mengubah keterangan transaksi
UPDATE transaksi
SET Keterangan = 'Setoran dari tabungan'
WHERE Id_Transaksi = 3;

-- DELETE
-- Menghapus transaksi
DELETE FROM transaksi WHERE Id = 4;