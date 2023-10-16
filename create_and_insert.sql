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



