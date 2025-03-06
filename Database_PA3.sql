-- Database creation
CREATE DATABASE IF NOT EXISTS Database_PA3;
USE Database_PA3;

-- provinces table
CREATE TABLE provinces (
    prov_id INT AUTO_INCREMENT PRIMARY KEY,
    prov_name VARCHAR(100) NOT NULL,
    location_id INT,
    STATUS VARCHAR(20),
    notes TEXT
);

-- cities table
CREATE TABLE cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    prov_id INT,
    FOREIGN KEY (prov_id) REFERENCES provinces(prov_id)
);

-- districts table
CREATE TABLE districts (
    dis_id INT AUTO_INCREMENT PRIMARY KEY,
    dis_name VARCHAR(100) NOT NULL,
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

-- subdistricts table
CREATE TABLE subdistricts (
    subdis_id INT AUTO_INCREMENT PRIMARY KEY,
    subdis_name VARCHAR(100) NOT NULL,
    dis_id INT,
    FOREIGN KEY (dis_id) REFERENCES districts(dis_id)
);

-- jenis_lahan table
CREATE TABLE jenis_lahan (
    id_jenis_lahan INT AUTO_INCREMENT PRIMARY KEY,
    nama_jenis_lahan VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    is_deleted BOOLEAN DEFAULT FALSE
);

-- lahan table
CREATE TABLE lahan (
    id_lahan INT AUTO_INCREMENT PRIMARY KEY,
    nama_lahan VARCHAR(100),
    id_jenis_lahan INT,
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    is_deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_jenis_lahan) REFERENCES jenis_lahan(id_jenis_lahan)
);

-- kelompok_tani table
CREATE TABLE kelompok_tani (
    id_kelompok_tani INT AUTO_INCREMENT PRIMARY KEY,
    nama_kelompok_tani VARCHAR(100) NOT NULL,
    tanggal_berdiri VARCHAR(50),
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    is_deleted BOOLEAN DEFAULT FALSE
);

-- petani table
CREATE TABLE petani (
    id_petani INT AUTO_INCREMENT PRIMARY KEY,
    nama_depan VARCHAR(100) NOT NULL,
    nama_belakang VARCHAR(100) NOT NULL,
    alamat_rumah VARCHAR(100),
    id_kelompok_tani INT,
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    is_deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_kelompok_tani) REFERENCES kelompok_tani(id_kelompok_tani)
);

-- jenis_komoditas table
CREATE TABLE jenis_komoditas (
    id_jenis_komoditas INT AUTO_INCREMENT PRIMARY KEY,
    nama_jenis_komoditas VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    is_deleted BOOLEAN DEFAULT FALSE
);

-- komoditas table
CREATE TABLE komoditas (
    id_komoditas INT AUTO_INCREMENT PRIMARY KEY,
    nama_komoditas VARCHAR(100) NOT NULL,
    id_jenis_komoditas INT,
    estimasi_panen VARCHAR(100),
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    is_deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_jenis_komoditas) REFERENCES jenis_komoditas(id_jenis_komoditas)
);

-- user_types table
CREATE TABLE user_types (
    user_type_id INT AUTO_INCREMENT PRIMARY KEY,
    user_type_name VARCHAR(50) NOT NULL,
    DESCRIPTION TEXT,
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    is_deleted BOOLEAN DEFAULT FALSE
);

-- user_roles table
CREATE TABLE user_roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(255),
    DESCRIPTION VARCHAR(255),
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    isDeleted BOOLEAN
);

-- golongan pangkat_table
CREATE TABLE golonganPangkat (
    idGolonganPangkat INT AUTO_INCREMENT PRIMARY KEY,
    golongan VARCHAR(255),
    pangkat VARCHAR(255),
    keterangan TEXT,
    createdAt DATETIME DEFAULT NULL,
    updatedAt DATETIME DEFAULT NULL,
    isDeleted BOOLEAN
);

-- pegawai table
CREATE TABLE pegawai (
    idPegawai INT AUTO_INCREMENT PRIMARY KEY,
    nip VARCHAR(255),
    namaPegawai VARCHAR(255),
    idGolonganPangkat INT,
    idJabatanBidang INT,
    subdis_id INT,
    alamat VARCHAR(255),
    noPonsel VARCHAR(20),
    noWA VARCHAR(20),
    fileFoto VARCHAR(255),
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    isDeleted BOOLEAN,
    FOREIGN KEY (idGolonganPangkat) REFERENCES golonganPangkat(idGolonganPangkat)
);

-- jabatan table
CREATE TABLE jabatan (
    idJabatan INT AUTO_INCREMENT PRIMARY KEY,
    jabatan VARCHAR(255),
    keterangan TEXT,
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    isDeleted BOOLEAN
);

-- departemen table
CREATE TABLE departemen (
    idDepartemen INT AUTO_INCREMENT PRIMARY KEY,
    namaDepartmen VARCHAR(255),
    keterangan VARCHAR(255),
    createAt DATETIME DEFAULT NULL,
    updateAt DATETIME DEFAULT NULL,
    isDeleted BOOLEAN
);

-- bidang table
CREATE TABLE bidang (
    id_bidang INT AUTO_INCREMENT PRIMARY KEY,
    idDepartemen INT,
    parent_bidang VARCHAR(100),
    nama_bidang VARCHAR(100),
    keterangan VARCHAR(255),
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    is_deleted BOOLEAN DEFAULT FALSE
);

-- jabatan bidang table
CREATE TABLE jabatanBidang (
    idJabatanBidang INT AUTO_INCREMENT PRIMARY KEY,
    idJabatan INT,
    id_bidang INT,
    namaJabatanBidang VARCHAR(255),
    keterangan TEXT,
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    isDeleted BOOLEAN,
    FOREIGN KEY (idJabatan) REFERENCES jabatan(idJabatan)
    
);

-- users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    personal_id VARCHAR(20),
    user_type_id INT,
    token VARCHAR(100),
    PASSWORD VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    role_id INT,
    idPegawai INT,
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    is_deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_type_id) REFERENCES user_types(user_type_id),
    FOREIGN KEY (role_id) REFERENCES user_roles(role_id),
    FOREIGN KEY (idPegawai) REFERENCES pegawai(idPegawai)
);

-- data_pertanian table
CREATE TABLE data_pertanian (
    id_data_pertanian INT AUTO_INCREMENT PRIMARY KEY,
    id_petani INT,
    id_lahan INT,
    id_komoditas INT,
    luas_lahan DECIMAL(10, 2),
    subdis_id INT,
    tanggal_tanam VARCHAR(50),
    tanggal_pencatatan VARCHAR(50),
    user_id INT,
    alamat_lengkap VARCHAR(255),
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    is_deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_petani) REFERENCES petani(id_petani),
    FOREIGN KEY (id_lahan) REFERENCES lahan(id_lahan),
    FOREIGN KEY (id_komoditas) REFERENCES komoditas(id_komoditas),
    FOREIGN KEY (subdis_id) REFERENCES subdistricts(subdis_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- pasar table
CREATE TABLE pasar (
    id_pasar INT AUTO_INCREMENT PRIMARY KEY,
    nama_pasar VARCHAR(255),
    lokasi VARCHAR(255),
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    isDeleted BOOLEAN
);

-- berita table
CREATE TABLE berita (
    idBerita INT AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(255),
    deskripsi TEXT,
    foto VARCHAR(255),
    tanggal VARCHAR(50),
    user_id INT,
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    isDeleted BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- harga_komoditas table
CREATE TABLE harga_komoditas (
    id_harga INT AUTO_INCREMENT PRIMARY KEY,
    harga VARCHAR(100),
    tanggal VARCHAR(50),
    id_pasar INT,
    id_komoditas INT,
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    isDeleted BOOLEAN,
    FOREIGN KEY (id_pasar) REFERENCES pasar(id_pasar),
    FOREIGN KEY (id_komoditas) REFERENCES komoditas(id_komoditas)
);

-- bantuan table
CREATE TABLE bantuan (
    id_bantuan INT AUTO_INCREMENT PRIMARY KEY,
    jenis_bantuan VARCHAR(255),
    tanggal VARCHAR(50),
    id_kelompok_tani INT,
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    isDeleted BOOLEAN,
    FOREIGN KEY (id_kelompok_tani) REFERENCES kelompok_tani(id_kelompok_tani)
);

-- jabatan petani table
CREATE TABLE jabatan_petani (
    id_jabatan_petani INT AUTO_INCREMENT PRIMARY KEY,
    idJabatanBidang INT,
    id_kelompok_tani INT,
    id_petani INT,
    created_at DATETIME DEFAULT NULL,
    updated_at DATETIME DEFAULT NULL,
    isDeleted BOOLEAN,
    FOREIGN KEY (idJabatanBidang) REFERENCES jabatanBidang(idJabatanBidang),
    FOREIGN KEY (id_kelompok_tani) REFERENCES kelompok_tani(id_kelompok_tani),
    FOREIGN KEY (id_petani) REFERENCES petani(id_petani)
);

-- Menambahkan foreign key ke tabel pegawai
ALTER TABLE pegawai
ADD CONSTRAINT fk_idJabatanBidang
FOREIGN KEY (idJabatanBidang) REFERENCES jabatanBidang(idJabatanBidang);

-- Menambahkan foreign key ke tabel bidang
ALTER TABLE bidang
ADD CONSTRAINT fk_idDepartemen
FOREIGN KEY (idDepartemen) REFERENCES departemen(idDepartemen);

-- Menambahkan foreign key ke tabel jabatanBidang
ALTER TABLE jabatanBidang
ADD CONSTRAINT fk_idBidang
FOREIGN KEY (id_bidang) REFERENCES bidang(id_bidang);

