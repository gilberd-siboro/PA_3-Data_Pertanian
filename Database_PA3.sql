-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 31, 2025 at 01:26 PM
-- Server version: 8.0.30
-- PHP Version: 8.2.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database_pa3`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_dataPertanian` (IN `idDataPertanian` INT)   BEGIN
	#Routine body goes here...
	UPDATE data_pertanian SET data_pertanian.is_deleted = 1, data_pertanian.updated_at = NOW()
	WHERE data_pertanian.id_data_pertanian = idDataPertanian;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_pengguna` (IN `idPengguna` JSON)   BEGIN
	#Routine body goes here...
		UPDATE users SET users.is_deleted = 1, users.updated_at = NOW()
	WHERE users.user_id = idPengguna;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_bidang` (IN `dataBidang` JSON)   BEGIN
    -- Mengambil data dari JSON
    SET @nama_departmen = JSON_UNQUOTE(JSON_EXTRACT(dataBidang, '$.NamaDepartmen'));
    SET @nama_bidang = JSON_UNQUOTE(JSON_EXTRACT(dataBidang, '$.NamaBidang'));
    SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataBidang, '$.Keterangan'));

    -- Memasukkan data ke tabel
    INSERT INTO bidang (idDepartemen, nama_bidang, keterangan, created_at)
    VALUES (@nama_departmen, @nama_bidang, @keterangan, NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_dataPertanian` (IN `dataPertanian` JSON)   BEGIN
	#Routine body goes here...
	SET @petani = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.Petani'));
	SET @lahan = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.Lahan'));
	SET @komoditas = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.Komoditas'));
	SET @luasLahan = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.LuasLahan'));
	SET @desa = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.Desa'));
	SET @alamat = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.Alamat'));
	SET @tanggalTanam = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.TanggalTanam'));
	SET @tanggalCatat = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.TanggalCatat'));
	SET @pencatat = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.Pencatat'));
	
	INSERT INTO data_pertanian(`id_petani`,`id_lahan`,`id_komoditas`,`luas_lahan`,`subdis_id`,`alamat_lengkap`,`tanggal_tanam`,`tanggal_pencatatan`,`user_id`)
	VALUES(@petani, @lahan, @komoditas, @luasLahan, @desa, @alamat, @tanggalTanam, @tanggalCatat, @pencatat);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_departmen` (IN `dataDepartmen` JSON)   BEGIN
    -- Mengambil data dari JSON
    SET @nama_departmen = JSON_UNQUOTE(JSON_EXTRACT(dataDepartmen, '$.NamaDepartmen'));
    SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataDepartmen, '$.Keterangan'));

    -- Memasukkan data ke tabel
    INSERT INTO departemen (namaDepartmen, keterangan, createAt)
    VALUES (@nama_departmen, @keterangan, NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_desa` (IN `dataDesa` JSON)   BEGIN
	#Routine body goes here...
	SET @nama_desa = JSON_UNQUOTE(JSON_EXTRACT(dataDesa,'$.NamaDesa'));
	SET @kecamatan = JSON_UNQUOTE(JSON_EXTRACT(dataDesa,'$.Kecamatan'));

	INSERT INTO subdistricts(subdis_name,dis_id)
	VALUES(@nama_desa, @kecamatan);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_golonganPangkat` (IN `dataGolonganPangkat` JSON)   BEGIN
    -- Mengambil data dari JSON
    SET @golongan = JSON_UNQUOTE(JSON_EXTRACT(dataGolonganPangkat, '$.Golongan'));
    SET @pangkat = JSON_UNQUOTE(JSON_EXTRACT(dataGolonganPangkat, '$.Pangkat'));
    SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataGolonganPangkat, '$.Keterangan'));

    -- Memasukkan data ke tabel
    INSERT INTO golonganpangkat (golongan, pangkat,  keterangan, createdAt)
    VALUES (@golongan, @pangkat, @keterangan, NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_jabatan` (IN `dataJabatan` JSON)   BEGIN
    -- Mengambil data dari JSON
    SET @jabatan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatan, '$.Jabatan'));
    SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatan, '$.Keterangan'));

    -- Memasukkan data ke tabel
    INSERT INTO jabatan (jabatan, keterangan, created_at)
    VALUES (@jabatan, @keterangan, NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_jabatanBidang` (IN `dataJabatanBidang` JSON)   BEGIN
    -- Mengambil data dari JSON
    SET @jabatan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang, '$.Jabatan'));
    SET @bidang = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang, '$.Bidang'));
    SET @jabatanBidang = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang, '$.JabatanBidang'));
    SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang, '$.Keterangan'));

    -- Memasukkan data ke tabel
    INSERT INTO jabatanbidang (idJabatan, id_bidang, namaJabatanBidang, keterangan, created_at)
    VALUES (@jabatan, @bidang, @jabatanBidang, @keterangan, NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_jabatanPetani` (IN `dataJabatanPetani` JSON)   BEGIN
    -- Mengambil data dari JSON
    SET @jabatanBidang = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanPetani, '$.JabatanBidang'));
    SET @kelompokTani = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanPetani, '$.KelompokTani'));
    SET @petani = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanPetani, '$.Petani'));
		
    -- Memasukkan data ke tabel
    INSERT INTO jabatan_petani (idJabatanBidang, id_kelompok_tani,  id_petani, created_at)
    VALUES (@jabatanBidang , @kelompokTani, @petani, NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_jenisKomoditas` (IN `dataJenisKomoditas` JSON)   BEGIN
	#Routine body goes here...
	SET @nama_jenis_komoditas = JSON_UNQUOTE(JSON_EXTRACT(dataJenisKomoditas,'$.JenisKomoditas'));

	INSERT INTO jenis_komoditas(jenis_komoditas.nama_jenis_komoditas)
	VALUES(@nama_jenis_komoditas);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_jenisLahan` (IN `dataJenisLahan` JSON)   BEGIN
	#Routine body goes here...
	SET @jenis_lahan = JSON_UNQUOTE(JSON_EXTRACT(dataJenisLahan,'$.JenisLahan'));

	INSERT INTO jenis_lahan(`nama_jenis_lahan`)
	VALUES(@jenis_lahan);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_kecamatan` (IN `dataKecamatan` JSON)   BEGIN
	#Routine body goes here...
	SET @kecamatan = JSON_UNQUOTE(JSON_EXTRACT(dataKecamatan,'$.Kecamatan'));

	INSERT INTO districts(dis_name)
	VALUES(@kecamatan);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_kelompokTani` (IN `dataKelompokTani` JSON)   BEGIN
	#Routine body goes here...
	SET @nama_kelompok = JSON_UNQUOTE(JSON_EXTRACT(dataKelompokTani,'$.NamaKelompokTani'));
	SET @alamat = JSON_UNQUOTE(JSON_EXTRACT(dataKelompokTani,'$.AlamatSekretariat'));

	INSERT INTO kelompok_tani(`nama_kelompok_tani`,`alamat_sekretariat`)
	VALUES(@nama_kelompok, @alamat);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_komoditas` (IN `dataKomoditas` JSON)   BEGIN
	#Routine body goes here...
	SET @jenis_komoditas = JSON_UNQUOTE(JSON_EXTRACT(dataKomoditas,'$.JenisKomoditas'));
	SET @nama_komoditas = JSON_UNQUOTE(JSON_EXTRACT(dataKomoditas,'$.NamaKomoditas'));
	SET @estimasi_panen = JSON_UNQUOTE(JSON_EXTRACT(dataKomoditas,'$.EstimasiPanen'));

	INSERT INTO komoditas(`id_jenis_komoditas`,`nama_komoditas`,`estimasi_panen`)
	VALUES(@jenis_komoditas, @nama_komoditas, @estimasi_panen);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_lahan` (IN `dataLahan` JSON)   BEGIN
	#Routine body goes here...
	SET @jenis_lahan = JSON_UNQUOTE(JSON_EXTRACT(dataLahan,'$.JenisLahan'));
	SET @lahan = JSON_UNQUOTE(JSON_EXTRACT(dataLahan,'$.Lahan'));

	INSERT INTO lahan(lahan.id_jenis_lahan,lahan.nama_lahan)
	VALUES(@jenis_lahan, @lahan);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_pegawai` (IN `dataPegawai` JSON)   BEGIN
    -- Mengambil data dari JSON
    SET @nip = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai, '$.NIP'));
    SET @nama = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai, '$.Nama'));
    SET @golonganPangkat = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai, '$.GolonganPangkat'));
    SET @jabatanBidang = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai, '$.JabatanBidang'));
    SET @desa = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai, '$.Desa'));
    SET @alamat = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai, '$.Alamat'));
    SET @ponsel = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai, '$.Ponsel'));
    SET @wa = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai, '$.WA'));
    SET @foto = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai, '$.Foto'));

		
    -- Memasukkan data ke tabel
    INSERT INTO pegawai (nip, namaPegawai,  idGolonganPangkat, idJabatanBidang, subdis_id, alamat, noPonsel, noWA, fileFoto, created_at)
    VALUES (@nip , @nama, @golonganPangkat, @jabatanBidang, @desa, @alamat, @ponsel, @wa, @foto, NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_pengguna` (IN `dataPengguna` JSON)   BEGIN
    SET @username = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna, '$.Username'));
    SET @email = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna, '$.Email'));
    SET @`password` = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna, '$.Password'));
    SET @role = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna, '$.Role'));
    SET @pegawai = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna, '$.Pegawai'));

    INSERT INTO `users` (`username`, `email`, `password`, `role_id`, `personal_id`, `user_type_id`, `created_at`)
    VALUES (@username, @email, @`password`, @role, @pegawai, 1, NOW()); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_petani` (IN `dataPetani` JSON)   BEGIN
	#Routine body goes here...
	SET @nama_depan = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.NamaDepan'));
	SET @nama_belakang = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.NamaBelakang'));
	SET @alamat = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.AlamatRumah'));
	SET @kelompok_tani = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.KelompokTani'));

	INSERT INTO petani(`nama_depan`,`nama_belakang`,`alamat_rumah`,petani.id_kelompok_tani)
	VALUES(@nama_depan, @nama_belakang, @alamat, @kelompok_tani);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_bidang` (IN `dataBidang` JSON)   BEGIN
	#Routine body goes here...
	
	SET @idBidang = JSON_UNQUOTE(JSON_EXTRACT(dataBidang,'$.IdBidang'));
	SET @idDepartemen = JSON_UNQUOTE(JSON_EXTRACT(dataBidang,'$.IdDepartemen'));
	SET @bidang = JSON_UNQUOTE(JSON_EXTRACT(dataBidang,'$.NamaBidang'));
	SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataBidang,'$.Keterangan'));
		
	UPDATE bidang SET bidang.nama_bidang=@bidang, bidang.idDepartemen=@idDepartemen, bidang.keterangan = @keterangan, bidang.updated_at=NOW()
	WHERE bidang.id_bidang=@idBidang;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_dataPertanian` (IN `dataPertanian` JSON)   BEGIN
	#Routine body goes here...
	SET @idDataPertanian = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.IdDataPertanian'));
	SET @petani = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.Petani'));
	SET @lahan = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.Lahan'));
	SET @komoditas = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.Komoditas'));
	SET @luasLahan = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.LuasLahan'));
	SET @desa = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.Desa'));
	SET @alamat = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.Alamat'));
	SET @tanggalTanam = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.TanggalTanam'));
	SET @tanggalCatat = JSON_UNQUOTE(JSON_EXTRACT(dataPertanian,'$.TanggalCatat'));

	UPDATE data_pertanian SET data_pertanian.id_petani = @petani, data_pertanian.id_lahan = @lahan, data_pertanian.id_komoditas = @komoditas, data_pertanian.luas_lahan = @luasLahan, data_pertanian.subdis_id = @desa, data_pertanian.tanggal_tanam = @tanggalTanam, data_pertanian.tanggal_pencatatan = @tanggalCatat, data_pertanian.alamat_lengkap = @alamat, data_pertanian.updated_at = NOW()
	WHERE data_pertanian.id_data_pertanian = @idDataPertanian;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_departemen` (IN `dataDepartemen` JSON)   BEGIN
	#Routine body goes here...
	
	SET @idDepartemen = JSON_UNQUOTE(JSON_EXTRACT(dataDepartemen,'$.IdDepartemen'));
	SET @namaDepartemen = JSON_UNQUOTE(JSON_EXTRACT(dataDepartemen,'$.NamaDepartemen'));
	SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataDepartemen,'$.Keterangan'));
		
	UPDATE departemen SET departemen.namaDepartmen=@namaDepartemen, departemen.keterangan=@keterangan, departemen.updateAt=NOW()
	WHERE departemen.idDepartemen=@idDepartemen;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_desa` (IN `dataDesa` JSON)   BEGIN
	#Routine body goes here...
	SET @idDesa = JSON_UNQUOTE(JSON_EXTRACT(dataDesa,'$.IdDesa'));
	SET @desa = JSON_UNQUOTE(JSON_EXTRACT(dataDesa,'$.NamaDesa'));
	SET @kecamatan = JSON_UNQUOTE(JSON_EXTRACT(dataDesa,'$.Kecamatan'));
	
	UPDATE subdistricts SET subdistricts.subdis_name=@desa, subdistricts.dis_id = @kecamatan
	WHERE subdistricts.subdis_id=@idDesa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_golonganPangkat` (IN `dataGolonganPangkat` JSON)   BEGIN
	#Routine body goes here...
	SET @idGolonganPangkat = JSON_UNQUOTE(JSON_EXTRACT(dataGolonganPangkat,'$.IdGolonganPangkat'));
	SET @golongan = JSON_UNQUOTE(JSON_EXTRACT(dataGolonganPangkat,'$.Golongan'));
	SET @pangkat = JSON_UNQUOTE(JSON_EXTRACT(dataGolonganPangkat,'$.Pangkat'));
	SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataGolonganPangkat,'$.Keterangan'));
	
	UPDATE golonganpangkat SET golonganpangkat.golongan=@golongan, golonganpangkat.pangkat=@pangkat, golonganpangkat.keterangan=@keterangan, golonganpangkat.updatedAt=NOW()
	WHERE golonganpangkat.idGolonganPangkat=@idGolonganPangkat;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_jabatan` (IN `dataJabatan` JSON)   BEGIN
	#Routine body goes here...
	SET @idJabatan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatan,'$.IdJabatan'));
	SET @jabatan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatan,'$.Jabatan'));
	SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatan,'$.Keterangan'));
	
	UPDATE jabatan SET jabatan.jabatan=@jabatan, jabatan.keterangan=@keterangan, jabatan.updated_at=NOW()
	WHERE jabatan.idJabatan=@idJabatan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_jabatanBidang` (IN `dataJabatanBidang` JSON)   BEGIN
	#Routine body goes here...
	SET @idJabatanBidang = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang,'$.IdJabatanBidang'));
	SET @jabatan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang,'$.Jabatan'));
	SET @bidang = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang,'$.Bidang'));
	SET @jabatanBidang = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang,'$.JabatanBidang'));
	SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang,'$.Keterangan'));
	
	UPDATE jabatanbidang SET jabatanbidang.idJabatan=@jabatan, jabatanbidang.id_bidang=@bidang, jabatanbidang.namaJabatanBidang=@jabatanBidang, jabatanbidang.keterangan=@keterangan, jabatanbidang.updated_at=NOW()
	WHERE jabatanbidang.idJabatanBidang=@idJabatanBidang;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_jabatanPetani` (IN `dataJabatanPetani` JSON)   BEGIN
	#Routine body goes here...
	SET @idJabatanPetani = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanPetani,'$.IdJabatanPetani'));
	SET @jabatanBidang = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanPetani,'$.JabatanBidang'));
	SET @kelompokTani = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanPetani,'$.KelompokTani'));
	SET @petani = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanPetani,'$.Petani'));
		
	UPDATE jabatan_petani SET jabatan_petani.idJabatanBidang=@jabatanBidang, jabatan_petani.id_kelompok_tani=@kelompokTani, jabatan_petani.id_petani=@petani, jabatan_petani.updated_at=NOW()
	WHERE jabatan_petani.id_jabatan_petani=@idJabatanPetani;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_jenisKomoditas` (IN `dataJenisKomoditas` JSON)   BEGIN
	#Routine body goes here...
	SET @idJenisKomoditas = JSON_UNQUOTE(JSON_EXTRACT(dataJenisKomoditas,'$.IdJenisKomoditas'));
	SET @namaJenisKomoditas = JSON_UNQUOTE(JSON_EXTRACT(dataJeniskomoditas,'$.NamaJenisKomoditas'));
	
	UPDATE jenis_komoditas SET jenis_komoditas.nama_jenis_komoditas=@namaJenisKomoditas, jenis_komoditas.updated_at=NOW()
	WHERE jenis_komoditas.id_jenis_komoditas=@idJenisKomoditas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_jenisLahan` (IN `dataJenisLahan` JSON)   BEGIN
	#Routine body goes here...
	
	SET @idJenisLahan = JSON_UNQUOTE(JSON_EXTRACT(dataJenisLahan,'$.IdJenisLahan'));
	SET @namaJenisLahan = JSON_UNQUOTE(JSON_EXTRACT(dataJenisLahan,'$.NamaJenisLahan'));
	
	UPDATE jenis_lahan SET jenis_lahan.nama_jenis_lahan=@namaJenisLahan, jenis_lahan.updated_at=NOW()
	WHERE jenis_lahan.id_jenis_lahan=@idJenisLahan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_kecamatan` (IN `dataKecamatan` JSON)   BEGIN
	#Routine body goes here...
	SET @idKecamatan = JSON_UNQUOTE(JSON_EXTRACT(dataKecamatan,'$.IdKecamatan'));
	SET @kecamatan = JSON_UNQUOTE(JSON_EXTRACT(dataKecamatan,'$.Kecamatan'));
	
	UPDATE districts SET districts.dis_name=@kecamatan
	WHERE districts.dis_id=@idKecamatan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_kelompokTani` (IN `dataKelompokTani` JSON)   BEGIN
	#Routine body goes here...
	SET @idKelompokTani = JSON_UNQUOTE(JSON_EXTRACT(dataKelompokTani,'$.IdKelompokTani'));
	SET @kelompokTani = JSON_UNQUOTE(JSON_EXTRACT(dataKelompokTani,'$.KelompokTani'));
	SET @alamat = JSON_UNQUOTE(JSON_EXTRACT(dataKelompokTani,'$.Alamat'));
	
	UPDATE kelompok_tani SET kelompok_tani.nama_kelompok_tani=@kelompokTani, kelompok_tani.alamat_sekretariat=@alamat,kelompok_tani.updated_at=NOW()
	WHERE kelompok_tani.id_kelompok_tani=@idKelompokTani;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_komoditas` (IN `dataKomoditas` JSON)   BEGIN
	#Routine body goes here...
	
	SET @idKomoditas = JSON_UNQUOTE(JSON_EXTRACT(dataKomoditas,'$.IdKomoditas'));
	SET @namaKomoditas = JSON_UNQUOTE(JSON_EXTRACT(dataKomoditas,'$.NamaKomoditas'));
	SET @jenisKomoditas = JSON_UNQUOTE(JSON_EXTRACT(dataKomoditas,'$.IdJenisKomoditas'));
	SET @estimasiPanen = JSON_UNQUOTE(JSON_EXTRACT(dataKomoditas,'$.EstimasiPanen'));
	
	UPDATE komoditas SET komoditas.nama_komoditas=@namaKomoditas, komoditas.id_jenis_komoditas=@jenisKomoditas, komoditas.estimasi_panen=@estimasiPanen, komoditas.updated_at=NOW()
	WHERE komoditas.id_komoditas=@idKomoditas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_lahan` (IN `dataLahan` JSON)   BEGIN
	#Routine body goes here...
	
	SET @idLahan = JSON_UNQUOTE(JSON_EXTRACT(dataLahan,'$.IdLahan'));
	SET @namaLahan = JSON_UNQUOTE(JSON_EXTRACT(dataLahan,'$.NamaLahan'));
	SET @jenisLahan = JSON_UNQUOTE(JSON_EXTRACT(dataLahan,'$.IdJenisLahan'));
		
	UPDATE lahan SET lahan.nama_lahan=@namaLahan, lahan.id_jenis_lahan=@jenisLahan, lahan.updated_at=NOW()
	WHERE lahan.id_lahan=@idLahan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_pegawai` (IN `dataPegawai` JSON)   BEGIN
	#Routine body goes here...
	SET @idPegawai = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai,'$.IdPegawai'));
	SET @nip = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai,'$.Nip'));
	SET @namaPegawai = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai,'$.NamaPegawai'));
	SET @golonganPangkat = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai,'$.GolonganPangkat'));
	SET @jabatanBidang = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai,'$.JabatanBidang'));
	SET @alamat = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai,'$.Alamat'));
	SET @ponsel = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai,'$.Ponsel'));	
	SET @wa = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai,'$.WA'));	
	SET @desa = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai,'$.Desa'));	
	SET @foto = JSON_UNQUOTE(JSON_EXTRACT(dataPegawai,'$.Foto'));
	
	UPDATE pegawai SET pegawai.nip=@nip, pegawai.namaPegawai=@namaPegawai, pegawai.idGolonganPangkat=@golonganPangkat, pegawai.idJabatanBidang=@jabatanBidang, pegawai.alamat=@alamat, pegawai.noPonsel=@ponsel, pegawai.noWA=@wa, pegawai.subdis_id=@desa, pegawai.fileFoto=@foto, pegawai.updated_at=NOW()
	WHERE pegawai.idPegawai=@idPegawai;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_pengguna` (IN `dataPengguna` JSON)   BEGIN
	#Routine body goes here...
	SET @idPengguna = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna,'$.IdPengguna'));
	SET @username = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna,'$.Username'));
	SET @email = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna,'$.Email'));
	SET @`password` = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna,'$.Password'));
	SET @role = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna,'$.Role'));
	
	UPDATE `users` SET `users`.username=@username, `users`.email=@email, `users`.`password`=@`password`, `users`.role_id=@role, `users`.updated_at=NOW()
	WHERE `users`.user_id=@idPengguna;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_petani` (IN `dataPetani` JSON)   BEGIN
	#Routine body goes here...
	SET @idPetani = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.IdPetani'));
	SET @namaDepan = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.NamaDepan'));
	SET @namaBelakang = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.NamaBelakang'));
	SET @alamat = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.Alamat'));
	SET @kelompokTani = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.KelompokTani'));
	
	UPDATE petani SET petani.nama_depan=@namaDepan, petani.nama_belakang=@namaBelakang, petani.alamat_rumah=@alamat, petani.id_kelompok_tani=@kelompokTani, petani.updated_at=NOW()
	WHERE petani.id_petani=@idPetani;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_bidang` ()   BEGIN
    -- Menampilkan bidang yang tidak dihapus
    SELECT
        departemen.namaDepartmen, 
        bidang.id_bidang, 
        bidang.nama_bidang, 
        bidang.keterangan
    FROM
        departemen
    INNER JOIN
        bidang
    ON 
        departemen.idDepartemen = bidang.idDepartemen
    WHERE bidang.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_dataPertanian` ()   BEGIN
	#Routine body goes here...
    SELECT
        data_pertanian.id_data_pertanian,
        petani.nama_depan, 
        petani.nama_belakang, 
        lahan.nama_lahan, 
        komoditas.nama_komoditas, 
        data_pertanian.luas_lahan, 
        subdistricts.subdis_name, 
        data_pertanian.tanggal_tanam, 
        data_pertanian.tanggal_pencatatan, 
        pegawai.namaPegawai, 
        data_pertanian.alamat_lengkap, 
        komoditas.estimasi_panen,  
        DATE_ADD(STR_TO_DATE(data_pertanian.tanggal_tanam, '%d %b, %Y'), INTERVAL komoditas.estimasi_panen DAY) AS estimasi_panen_final
    FROM
        data_pertanian
    INNER JOIN
        petani ON data_pertanian.id_petani = petani.id_petani
    INNER JOIN
        lahan ON data_pertanian.id_lahan = lahan.id_lahan
    INNER JOIN
        komoditas ON data_pertanian.id_komoditas = komoditas.id_komoditas
    INNER JOIN
        subdistricts ON data_pertanian.subdis_id = subdistricts.subdis_id
    INNER JOIN
        users ON data_pertanian.user_id = users.user_id
    INNER JOIN
        pegawai ON users.personal_id = pegawai.idPegawai
    WHERE 
        data_pertanian.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_departemen` ()   BEGIN
	#Routine body goes here...
SELECT * FROM departemen;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_desa` ()   BEGIN
SELECT
	subdistricts.subdis_id,
	subdistricts.subdis_name, 
	districts.dis_name
FROM
	subdistricts
	INNER JOIN
	districts
	ON 
		subdistricts.dis_id = districts.dis_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_golonganPangkat` ()   BEGIN
	#Routine body goes here...
SELECT * FROM golonganpangkat;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_jabatan` ()   BEGIN
	#Routine body goes here...
SELECT * FROM jabatan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_jabatanBidang` ()   BEGIN
	#Routine body goes here...
SELECT
	jabatanbidang.idJabatanBidang,
	jabatan.jabatan, 
	bidang.nama_bidang, 
	jabatanbidang.namaJabatanBidang, 
	jabatanbidang.keterangan
FROM
	jabatanbidang
	INNER JOIN
	bidang
	ON 
		jabatanbidang.id_bidang = bidang.id_bidang
	INNER JOIN
	jabatan
	ON 
		jabatanbidang.idJabatan = jabatan.idJabatan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_jabatanBidangPokTan` ()   BEGIN
    SELECT
        jabatanbidang.idJabatanBidang,
        jabatan.jabatan, 
        bidang.nama_bidang, 
        jabatanbidang.namaJabatanBidang, 
        jabatanbidang.keterangan
    FROM
        jabatanbidang
    INNER JOIN bidang ON jabatanbidang.id_bidang = bidang.id_bidang
    INNER JOIN jabatan ON jabatanbidang.idJabatan = jabatan.idJabatan
    WHERE jabatanbidang.id_bidang = 8;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_jabatanPetani` ()   BEGIN
	#Routine body goes here...
SELECT
	jabatanbidang.namaJabatanBidang,
	kelompok_tani.nama_kelompok_tani,
	petani.nama_depan,
	petani.nama_belakang,
	kelompok_tani.alamat_sekretariat,
	jabatan_petani.id_jabatan_petani 
FROM
	jabatan_petani
	INNER JOIN jabatanbidang ON jabatan_petani.idJabatanBidang = jabatanbidang.idJabatanBidang
	INNER JOIN kelompok_tani ON jabatan_petani.id_kelompok_tani = kelompok_tani.id_kelompok_tani
	INNER JOIN petani ON jabatan_petani.id_petani = petani.id_petani;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_jenisKomoditas` ()   BEGIN
	#Routine body goes here...
SELECT * FROM jenis_komoditas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_jenisLahan` ()   BEGIN
	#Routine body goes here...
SELECT * FROM jenis_lahan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_kabupaten` ()   BEGIN
SELECT * FROM cities;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_kecamatan` ()   BEGIN
SELECT * FROM districts;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_kelompokTani` ()   BEGIN
	#Routine body goes here...
SELECT 
    kelompok_tani.nama_kelompok_tani,
    kelompok_tani.alamat_sekretariat,
		kelompok_tani.id_kelompok_tani,
    petani.nama_depan,
    petani.nama_belakang
FROM 
    kelompok_tani
    LEFT JOIN jabatan_petani ON kelompok_tani.id_kelompok_tani = jabatan_petani.id_kelompok_tani
    LEFT JOIN petani ON jabatan_petani.id_petani = petani.id_petani
		WHERE kelompok_tani.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_kelompokTaniFull` ()   BEGIN
SELECT * FROM kelompok_tani;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_Komoditas` ()   BEGIN
SELECT
	komoditas.id_komoditas,
	komoditas.nama_komoditas, 
	jenis_komoditas.nama_jenis_komoditas, 
	komoditas.estimasi_panen
FROM
	komoditas
	INNER JOIN
	jenis_komoditas
	ON 
		komoditas.id_jenis_komoditas = jenis_komoditas.id_jenis_komoditas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_lahan` ()   BEGIN
SELECT
	lahan.id_lahan,
	lahan.nama_lahan, 
	jenis_lahan.nama_jenis_lahan
FROM
	lahan
	INNER JOIN
	jenis_lahan
	ON 
		lahan.id_jenis_lahan = jenis_lahan.id_jenis_lahan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_pegawai` ()   BEGIN
	#Routine body goes here...
SELECT
	pegawai.idPegawai, 
	pegawai.namaPegawai
FROM
	pegawai;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_pegawaiFull` ()   BEGIN#Routine body goes here...
	SELECT
	pegawai.idPegawai,
		pegawai.nip,
		pegawai.namaPegawai,
		golonganpangkat.golongan,
		golonganpangkat.pangkat,
		jabatanbidang.namaJabatanBidang,
		subdistricts.subdis_name,
		pegawai.alamat,
		pegawai.noPonsel,
		pegawai.noWA,
		pegawai.fileFoto 
	FROM
		pegawai
		INNER JOIN golonganpangkat ON pegawai.idGolonganPangkat = golonganpangkat.idGolonganPangkat
		INNER JOIN jabatanbidang ON pegawai.idJabatanBidang = jabatanbidang.idJabatanBidang
		INNER JOIN subdistricts ON pegawai.subdis_id = subdistricts.subdis_id;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_Pengguna` ()   BEGIN
	#Routine body goes here...
SELECT
	users.user_id,
	users.username,
	users.email,
	users.`password`,
	users.role_id,
	pegawai.fileFoto,
	pegawai.idPegawai,
	users.personal_id,
	user_roles.role_name,
	pegawai.namaPegawai 
FROM
	users
	INNER JOIN pegawai ON pegawai.idPegawai = users.personal_id
	INNER JOIN user_roles ON users.role_id = user_roles.role_id
	WHERE users.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_petani` ()   BEGIN
SELECT
	petani.id_petani,
	petani.nama_depan, 
	petani.nama_belakang, 
	petani.alamat_rumah, 
	kelompok_tani.nama_kelompok_tani
FROM
	petani
	INNER JOIN
	kelompok_tani
	ON 
		petani.id_kelompok_tani = kelompok_tani.id_kelompok_tani;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_provinsi` ()   BEGIN
SELECT * FROM provinces;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `viewAll_role` ()   BEGIN
	#Routine body goes here...
SELECT
	user_roles.role_id, 
	user_roles.role_name
FROM
	user_roles;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_bidangById` (IN `id` INT)   BEGIN
	SELECT
		departemen.namaDepartmen,
		bidang.idDepartemen,
		bidang.id_bidang,
		bidang.nama_bidang,
		bidang.keterangan 
	FROM
		departemen
		INNER JOIN bidang ON departemen.idDepartemen = bidang.idDepartemen 
	WHERE
		bidang.is_deleted = 0 
		AND bidang.id_bidang = id;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_dataPertanianById` (IN `id` INT)   BEGIN
	#Routine body goes here...
SELECT
	data_pertanian.id_data_pertanian,
	petani.id_petani,
	petani.nama_depan, 
	petani.nama_belakang,
	komoditas.id_komoditas, 
	komoditas.nama_komoditas, 
	data_pertanian.luas_lahan,
	data_pertanian.id_lahan,
	data_pertanian.subdis_id,
	subdistricts.subdis_name, 
	data_pertanian.id_data_pertanian, 
	data_pertanian.tanggal_tanam, 
	data_pertanian.tanggal_pencatatan, 
	data_pertanian.alamat_lengkap
FROM
	data_pertanian
	INNER JOIN
	petani
	ON 
		data_pertanian.id_petani = petani.id_petani
	INNER JOIN
	lahan
	ON 
		data_pertanian.id_lahan = lahan.id_lahan
	INNER JOIN
	komoditas
	ON 
		data_pertanian.id_komoditas = komoditas.id_komoditas
	INNER JOIN
	subdistricts
	ON 
		data_pertanian.subdis_id = subdistricts.subdis_id
		WHERE
    data_pertanian.id_data_pertanian = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_departemenById` (IN `id` INT)   BEGIN
	SELECT
		* 
	FROM
		departemen
	WHERE
		departemen.idDepartemen = id;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_desaById` (IN `id` INT)   BEGIN
	SELECT
		subdistricts.subdis_id,
		subdistricts.dis_id,
		subdistricts.subdis_name,
		districts.dis_name 
	FROM
		subdistricts
		INNER JOIN districts ON subdistricts.dis_id = districts.dis_id 
	WHERE
		districts.dis_id = id;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_golonganPangkatById` (IN `id` INT)   BEGIN
	SELECT
		* 
	FROM
		golonganpangkat
	
	WHERE
		golonganpangkat.idGolonganPangkat = id;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_jabatanBidangById` (IN `id` INT)   BEGIN
SELECT
	jabatanbidang.idJabatanBidang,
	jabatan.jabatan, 
	jabatan.idJabatan,
	bidang.nama_bidang,
	bidang.id_bidang,
	jabatanbidang.namaJabatanBidang, 
	jabatanbidang.keterangan
FROM
	jabatanbidang
	INNER JOIN
	bidang
	ON 
		jabatanbidang.id_bidang = bidang.id_bidang
	INNER JOIN
	jabatan
	ON 
		jabatanbidang.idJabatan = jabatan.idJabatan
	WHERE
		jabatanBidang.idJabatanBidang = id;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_jabatanById` (IN `id` INT)   BEGIN
	SELECT
		* 
	FROM
		jabatan
	WHERE
		jabatan.idJabatan = id;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_jabatanPetaniById` (IN `id` INT)   BEGIN
SELECT
	jabatanbidang.namaJabatanBidang,
	kelompok_tani.nama_kelompok_tani,
	petani.nama_depan,
	petani.nama_belakang,
	kelompok_tani.alamat_sekretariat,
	jabatan_petani.idJabatanBidang,
	jabatan_petani.id_kelompok_tani,
	jabatan_petani.id_petani,
	jabatan_petani.id_jabatan_petani
FROM
	jabatan_petani
	INNER JOIN jabatanbidang ON jabatan_petani.idJabatanBidang = jabatanbidang.idJabatanBidang
	INNER JOIN kelompok_tani ON jabatan_petani.id_kelompok_tani = kelompok_tani.id_kelompok_tani
	INNER JOIN petani ON jabatan_petani.id_petani = petani.id_petani
	WHERE
		jabatan_petani.id_jabatan_petani = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_jenisKomoditasById` (IN `id` INT)   BEGIN
	SELECT
		* 
	FROM
		jenis_komoditas 
	WHERE
		jenis_komoditas.id_jenis_komoditas = id;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_jenisLahanById` (IN `id` INT)   BEGIN
	SELECT
		* 
	FROM
		jenis_lahan 
	WHERE
		jenis_lahan.id_jenis_lahan = id;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_kecamatanById` (IN `id` INT)   BEGIN
	SELECT
		* 
	FROM
		districts 
	WHERE
		districts.dis_id = id;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_kelompokTaniById` (IN `id` INT)   BEGIN
	SELECT
		* 
	FROM
		kelompok_tani	
	WHERE
		kelompok_tani.id_kelompok_tani = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_komoditasById` (IN `id` INT)   BEGIN
SELECT
	komoditas.id_komoditas,
	komoditas.nama_komoditas,
	komoditas.id_jenis_komoditas, 
	jenis_komoditas.nama_jenis_komoditas, 
	komoditas.estimasi_panen
FROM
	komoditas
	INNER JOIN
	jenis_komoditas
	ON 
		komoditas.id_jenis_komoditas = jenis_komoditas.id_jenis_komoditas
	WHERE
		komoditas.id_komoditas = id;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_lahanById` (IN `id` INT)   BEGIN
	SELECT
		lahan.id_lahan,
		lahan.nama_lahan,
		lahan.id_jenis_lahan,
		jenis_lahan.nama_jenis_lahan 
	FROM
		lahan
		INNER JOIN jenis_lahan ON lahan.id_jenis_lahan = jenis_lahan.id_jenis_lahan
	
	WHERE
		lahan.id_lahan = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_pegawaiById` (IN `id` INT)   BEGIN
	SELECT
		pegawai.nip,
		pegawai.namaPegawai,
		golonganpangkat.golongan,
		golonganpangkat.pangkat,
		jabatanbidang.namaJabatanBidang,
		subdistricts.subdis_name,
		pegawai.alamat,
		pegawai.noPonsel,
		pegawai.noWA,
		pegawai.fileFoto,
		pegawai.idGolonganPangkat,
		pegawai.idJabatanBidang,
		pegawai.subdis_id,
		pegawai.idPegawai
	FROM
		pegawai
		INNER JOIN golonganpangkat ON pegawai.idGolonganPangkat = golonganpangkat.idGolonganPangkat
		INNER JOIN jabatanbidang ON pegawai.idJabatanBidang = jabatanbidang.idJabatanBidang
		INNER JOIN subdistricts ON pegawai.subdis_id = subdistricts.subdis_id 
	WHERE
		pegawai.idPegawai = id;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_penggunaById` (IN `id` INT)   BEGIN
SELECT
	users.user_id,
	users.username,
	users.email,
	users.`password`,
	users.role_id,
	user_roles.role_name 
FROM
	users
	INNER JOIN user_roles ON users.role_id = user_roles.role_id 
WHERE
	users.user_id = id;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_petaniById` (IN `id` INT)   BEGIN
	SELECT
		petani.id_petani,
		petani.nama_depan,
		petani.nama_belakang,
		petani.alamat_rumah,
		petani.id_kelompok_tani,
		kelompok_tani.nama_kelompok_tani 
	FROM
		petani
		INNER JOIN kelompok_tani ON petani.id_kelompok_tani = kelompok_tani.id_kelompok_tani 
	WHERE
		petani.id_petani = id;
	
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bantuan`
--

CREATE TABLE `bantuan` (
  `id_bantuan` int NOT NULL,
  `jenis_bantuan` varchar(255) DEFAULT NULL,
  `tanggal` varchar(50) DEFAULT NULL,
  `id_kelompok_tani` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `berita`
--

CREATE TABLE `berita` (
  `idBerita` int NOT NULL,
  `judul` varchar(255) DEFAULT NULL,
  `deskripsi` text,
  `foto` varchar(255) DEFAULT NULL,
  `tanggal` varchar(50) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bidang`
--

CREATE TABLE `bidang` (
  `id_bidang` int NOT NULL,
  `idDepartemen` int DEFAULT NULL,
  `parent_bidang` varchar(100) DEFAULT NULL,
  `nama_bidang` varchar(100) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bidang`
--

INSERT INTO `bidang` (`id_bidang`, `idDepartemen`, `parent_bidang`, `nama_bidang`, `keterangan`, `created_at`, `updated_at`, `is_deleted`) VALUES
(1, 1, NULL, 'Dinas', 'Mengelola dinas pertanian Tapanuli Utara', NULL, '2025-03-30 18:51:19', 0),
(2, 1, NULL, 'UPT', 'Lembaga yang menjalankan sebagian fungsi teknis operasional dari suatu instansi atau lembaga induk', NULL, NULL, 0),
(3, 1, NULL, 'Tanaman Pangan', 'Mengelola tanaman pangan', NULL, NULL, 0),
(4, 1, NULL, 'Hortikultura', 'Mengelola tanaman hortikultura', NULL, NULL, 0),
(5, 1, NULL, 'Perkebunan', 'Mengelola tanaman perkebunan', NULL, NULL, 0),
(6, 1, NULL, 'Sarana dan Prasarana', 'Mengelola sarana dan prasarana', NULL, NULL, 0),
(7, 1, NULL, 'Penyuluhan', 'Mengelola penyuluhan data pertanian', NULL, NULL, 0),
(8, 2, NULL, 'Non Bidang', 'Tidak termasuk dalam bidang', NULL, NULL, 0),
(9, 1, NULL, 'Kesekretariatan', 'Bertanggung jawab atas administrasi, kepegawaian, keuangan, dan layanan umum untuk mendukung kelancaran operasional serta pengambilan keputusan pimpinan.', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `city_id` int NOT NULL,
  `city_name` varchar(100) NOT NULL,
  `prov_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`city_id`, `city_name`, `prov_id`) VALUES
(1, 'Tapanuli Utara', 1);

-- --------------------------------------------------------

--
-- Table structure for table `data_pertanian`
--

CREATE TABLE `data_pertanian` (
  `id_data_pertanian` int NOT NULL,
  `id_petani` int DEFAULT NULL,
  `id_lahan` int DEFAULT NULL,
  `id_komoditas` int DEFAULT NULL,
  `luas_lahan` decimal(10,2) DEFAULT NULL,
  `subdis_id` int DEFAULT NULL,
  `tanggal_tanam` varchar(50) DEFAULT NULL,
  `tanggal_pencatatan` varchar(50) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `alamat_lengkap` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `data_pertanian`
--

INSERT INTO `data_pertanian` (`id_data_pertanian`, `id_petani`, `id_lahan`, `id_komoditas`, `luas_lahan`, `subdis_id`, `tanggal_tanam`, `tanggal_pencatatan`, `user_id`, `alamat_lengkap`, `created_at`, `updated_at`, `is_deleted`) VALUES
(1, 1, 1, 1, 1000.00, 1, '11 Mar, 2025', '19 Mar, 2025', 2, 'Lumban Jaean', NULL, '2025-03-20 14:23:03', 1),
(2, 1, 1, 1, 1000.00, 1, '04 Mar, 2025', '19 Mar, 2025', 2, 'Tarutung', NULL, '2025-03-30 21:03:36', 0);

-- --------------------------------------------------------

--
-- Table structure for table `departemen`
--

CREATE TABLE `departemen` (
  `idDepartemen` int NOT NULL,
  `namaDepartmen` varchar(255) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `createAt` datetime DEFAULT NULL,
  `updateAt` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `departemen`
--

INSERT INTO `departemen` (`idDepartemen`, `namaDepartmen`, `keterangan`, `createAt`, `updateAt`, `isDeleted`) VALUES
(1, 'Dinas Pertanian Tapanuli Utara', 'Instansi pemerintah daerah yang menangani pertanian', NULL, '2025-03-27 16:30:49', 0),
(2, 'Non Departemen', 'Tidak tergabung dalam departemen apapun', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `districts`
--

CREATE TABLE `districts` (
  `dis_id` int NOT NULL,
  `dis_name` varchar(100) NOT NULL,
  `city_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `districts`
--

INSERT INTO `districts` (`dis_id`, `dis_name`, `city_id`) VALUES
(1, 'Tarutung', 1),
(2, 'Muara', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `golonganpangkat`
--

CREATE TABLE `golonganpangkat` (
  `idGolonganPangkat` int NOT NULL,
  `golongan` varchar(255) DEFAULT NULL,
  `pangkat` varchar(255) DEFAULT NULL,
  `keterangan` text,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `golonganpangkat`
--

INSERT INTO `golonganpangkat` (`idGolonganPangkat`, `golongan`, `pangkat`, `keterangan`, `createdAt`, `updatedAt`, `isDeleted`) VALUES
(1, 'IV/d', 'Pembina Utama Madya', 'Jabatan tertinggi dalam struktural ASN', NULL, '2025-03-31 09:39:56', 0),
(2, 'IV/c', 'Pembina Utama Muda', 'Jabatan tinggi dalam struktural ASN', NULL, NULL, 0),
(3, 'IV/a', 'Pembina', 'Jabatan dalam struktural ASN', NULL, NULL, 0),
(4, 'III/d', 'Penata Tingkat I', 'Jabatan dalam fungsional ASN', NULL, NULL, 0),
(5, 'III/c', 'Penata', 'Jabatan dalam fungsional ASN', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `harga_komoditas`
--

CREATE TABLE `harga_komoditas` (
  `id_harga` int NOT NULL,
  `harga` varchar(100) DEFAULT NULL,
  `tanggal` varchar(50) DEFAULT NULL,
  `id_pasar` int DEFAULT NULL,
  `id_komoditas` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jabatan`
--

CREATE TABLE `jabatan` (
  `idJabatan` int NOT NULL,
  `jabatan` varchar(255) DEFAULT NULL,
  `keterangan` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `jabatan`
--

INSERT INTO `jabatan` (`idJabatan`, `jabatan`, `keterangan`, `created_at`, `updated_at`, `isDeleted`) VALUES
(1, 'Kepala', 'Jabatan tertinggi dalam struktur organisasi', NULL, '2025-03-30 19:03:53', 0),
(2, 'Staff', 'Mendukung perencanaan, pelaksanaan, administrasi, serta monitoring program dan kebijakan pertanian', NULL, NULL, 0),
(3, 'Fungsional', 'Jabatan dalam pemerintahan yang berisi tugas dan fungsi tertentu berdasarkan keahlian dan keterampilan', NULL, NULL, 0),
(4, 'KASUBBAG', 'Jabatan struktural yang bertanggung jawab mengkoordinasikan, mengawasi, dan melaksanakan tugas administrasi, kepegawaian, keuangan, serta penyusunan laporan dalam suatu unit kerja untuk mendukung kelancaran operasional instansi.', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `jabatanbidang`
--

CREATE TABLE `jabatanbidang` (
  `idJabatanBidang` int NOT NULL,
  `idJabatan` int DEFAULT NULL,
  `id_bidang` int DEFAULT NULL,
  `namaJabatanBidang` varchar(255) DEFAULT NULL,
  `keterangan` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `jabatanbidang`
--

INSERT INTO `jabatanbidang` (`idJabatanBidang`, `idJabatan`, `id_bidang`, `namaJabatanBidang`, `keterangan`, `created_at`, `updated_at`, `isDeleted`) VALUES
(9, 1, 1, 'Kepala Dinas Pertanian Tapanuli Utara', 'Pimpinan yang mempunyai tugas memimpin mengkoordinasikan, menyelenggarakan, mengevaluasi dan pelaporan kegiatan bidang pertanian.', NULL, '2025-03-31 09:12:42', 0),
(10, 1, 2, 'Kepala UPT Alsintan', 'Mengelola, mengoperasikan, dan mengawasi unit layanan alat dan mesin pertanian.', NULL, NULL, 0),
(11, 1, 2, 'Kepala UPT Laboratorium dan POPT', 'Pengelolaan laboratorium serta pengendalian organisme pengganggu tumbuhan', NULL, NULL, 0),
(12, 1, 3, 'Kepala Bidang Tanaman Pangan', 'Merencanakan, mengkoordinasikan, mengawasi, dan mengevaluasi program serta kebijakan di bidang tanaman pangan', NULL, NULL, 0),
(13, 1, 4, 'Kepala Bidang Hortikultura', 'Merencanakan, mengkoordinasikan, mengawasi, dan mengevaluasi program serta kebijakan di bidang tanaman hortikultura', NULL, NULL, 0),
(14, 1, 5, 'Kepala Bidang Perkebunan', 'Merencanakan, mengkoordinasikan, mengawasi, dan mengevaluasi program serta kebijakan di bidang perkebunan', NULL, NULL, 0),
(15, 1, 6, 'Kepala Bidang Sarana dan Prasarana', 'Merencanakan, mengkoordinasikan, mengawasi, dan mengevaluasi program serta kebijakan di bidang sarana dan prasarana', NULL, NULL, 0),
(16, 1, 7, 'Kepala Bidang Penyuluhan', 'Merencanakan, mengkoordinasikan, mengawasi, dan mengevaluasi program serta kebijakan di bidang penyuluhan', NULL, NULL, 0),
(18, 1, 8, 'Kepala Kelompok Tani', 'Pemimpin yang bertanggung jawab atas semua kegiatan kelompok tani.', '2025-03-23 19:07:02', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `jabatan_petani`
--

CREATE TABLE `jabatan_petani` (
  `id_jabatan_petani` int NOT NULL,
  `idJabatanBidang` int DEFAULT NULL,
  `id_kelompok_tani` int DEFAULT NULL,
  `id_petani` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `jabatan_petani`
--

INSERT INTO `jabatan_petani` (`id_jabatan_petani`, `idJabatanBidang`, `id_kelompok_tani`, `id_petani`, `created_at`, `updated_at`, `isDeleted`) VALUES
(3, 18, 2, 1, '2025-03-23 19:40:43', '2025-03-31 18:25:50', 0),
(7, 18, 3, 2, '2025-03-23 20:14:58', NULL, 0),
(8, 18, 4, 3, '2025-03-23 20:20:57', NULL, 0),
(9, 18, 5, 4, '2025-03-31 12:37:44', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `jenis_komoditas`
--

CREATE TABLE `jenis_komoditas` (
  `id_jenis_komoditas` int NOT NULL,
  `nama_jenis_komoditas` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `jenis_komoditas`
--

INSERT INTO `jenis_komoditas` (`id_jenis_komoditas`, `nama_jenis_komoditas`, `created_at`, `updated_at`, `is_deleted`) VALUES
(1, 'Tanaman Pangan', NULL, '2025-03-27 15:40:15', 0),
(2, 'Hortikultura', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `jenis_lahan`
--

CREATE TABLE `jenis_lahan` (
  `id_jenis_lahan` int NOT NULL,
  `nama_jenis_lahan` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `jenis_lahan`
--

INSERT INTO `jenis_lahan` (`id_jenis_lahan`, `nama_jenis_lahan`, `created_at`, `updated_at`, `is_deleted`) VALUES
(1, 'Lahan Basah', NULL, '2025-03-27 16:02:24', 0);

-- --------------------------------------------------------

--
-- Table structure for table `kelompok_tani`
--

CREATE TABLE `kelompok_tani` (
  `id_kelompok_tani` int NOT NULL,
  `nama_kelompok_tani` varchar(100) NOT NULL,
  `alamat_sekretariat` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kelompok_tani`
--

INSERT INTO `kelompok_tani` (`id_kelompok_tani`, `nama_kelompok_tani`, `alamat_sekretariat`, `created_at`, `updated_at`, `is_deleted`) VALUES
(2, 'Sejahtera', 'Lumban Jaean', NULL, '2025-03-31 17:51:22', 0),
(3, 'Setia', 'Lumban Jaean', NULL, NULL, 0),
(4, 'DOSROHA LUMBAN JAEAN', 'Lumban Jaean', NULL, NULL, 0),
(5, 'Maju Bersama', 'Lumban Jaean', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `komoditas`
--

CREATE TABLE `komoditas` (
  `id_komoditas` int NOT NULL,
  `nama_komoditas` varchar(100) NOT NULL,
  `id_jenis_komoditas` int DEFAULT NULL,
  `estimasi_panen` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `komoditas`
--

INSERT INTO `komoditas` (`id_komoditas`, `nama_komoditas`, `id_jenis_komoditas`, `estimasi_panen`, `created_at`, `updated_at`, `is_deleted`) VALUES
(1, 'Padi', 1, '151', NULL, '2025-03-31 12:27:49', 0);

-- --------------------------------------------------------

--
-- Table structure for table `lahan`
--

CREATE TABLE `lahan` (
  `id_lahan` int NOT NULL,
  `nama_lahan` varchar(100) DEFAULT NULL,
  `id_jenis_lahan` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `lahan`
--

INSERT INTO `lahan` (`id_lahan`, `nama_lahan`, `id_jenis_lahan`, `created_at`, `updated_at`, `is_deleted`) VALUES
(1, 'Sawah', 1, NULL, '2025-03-27 16:17:56', 0);

-- --------------------------------------------------------

--
-- Table structure for table `pasar`
--

CREATE TABLE `pasar` (
  `id_pasar` int NOT NULL,
  `nama_pasar` varchar(255) DEFAULT NULL,
  `lokasi` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `idPegawai` int NOT NULL,
  `nip` varchar(255) DEFAULT NULL,
  `namaPegawai` varchar(255) DEFAULT NULL,
  `idGolonganPangkat` int DEFAULT NULL,
  `idJabatanBidang` int DEFAULT NULL,
  `subdis_id` int DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `noPonsel` varchar(20) DEFAULT NULL,
  `noWA` varchar(20) DEFAULT NULL,
  `fileFoto` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`idPegawai`, `nip`, `namaPegawai`, `idGolonganPangkat`, `idJabatanBidang`, `subdis_id`, `alamat`, `noPonsel`, `noWA`, `fileFoto`, `created_at`, `updated_at`, `isDeleted`) VALUES
(1, '123123123', 'Gilberd Siboro', 2, 9, 1, 'IT Del', '081260951690', '877381928382', '1743426081_req.jpg', NULL, '2025-03-31 20:01:21', 0),
(2, '123981238', 'Erichson Berutu', 4, 16, 1, 'Tarutung', '088238192', '231231423', 'reza.jpg', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `petani`
--

CREATE TABLE `petani` (
  `id_petani` int NOT NULL,
  `nama_depan` varchar(100) NOT NULL,
  `nama_belakang` varchar(100) NOT NULL,
  `alamat_rumah` varchar(100) DEFAULT NULL,
  `id_kelompok_tani` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `petani`
--

INSERT INTO `petani` (`id_petani`, `nama_depan`, `nama_belakang`, `alamat_rumah`, `id_kelompok_tani`, `created_at`, `updated_at`, `is_deleted`) VALUES
(1, 'Erichson', 'Berutu', 'Lumban Jaean', 2, NULL, '2025-03-31 17:29:22', 0),
(2, 'Volwin', 'Sitompul', 'Lumban Jaean', 3, NULL, NULL, 0),
(3, 'Yanti', 'Sitompul', 'Lumban Jaean', 4, NULL, NULL, 0),
(4, 'Erika', 'Magdalena Simanungkalit', 'Lumban Jaean', 5, NULL, NULL, 0),
(5, 'Kevin', 'Simangunsong', 'Siantar', 2, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `provinces`
--

CREATE TABLE `provinces` (
  `prov_id` int NOT NULL,
  `prov_name` varchar(100) NOT NULL,
  `location_id` int DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `provinces`
--

INSERT INTO `provinces` (`prov_id`, `prov_name`, `location_id`, `status`) VALUES
(1, 'Sumatera Utara', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `subdistricts`
--

CREATE TABLE `subdistricts` (
  `subdis_id` int NOT NULL,
  `subdis_name` varchar(100) NOT NULL,
  `dis_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `subdistricts`
--

INSERT INTO `subdistricts` (`subdis_id`, `subdis_name`, `dis_id`) VALUES
(1, 'Hutatoruan VI', 1),
(2, 'Hapoltahan', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `personal_id` varchar(20) DEFAULT NULL,
  `user_type_id` int DEFAULT NULL,
  `token` varchar(100) DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `personal_id`, `user_type_id`, `token`, `password`, `email`, `role_id`, `created_at`, `updated_at`, `is_deleted`) VALUES
(1, 'pertanian', '1', 1, NULL, '$2y$12$c8roUKWHlDDuaRxREfJm9.9WxdZiDVc9w9CbhdLZTgS7mEek9Km8a', 'asdasd@gmail.com', 1, NULL, '2025-03-30 11:50:40', 0),
(2, 'penyuluh', '1', 1, NULL, '$2y$12$xWUr9RuFuOnEMH7rpdkAcOS1CnsrJkWXOqTfbBUctPyxz6B6.4dqi', 'asd@gmail.com', 2, NULL, '2025-03-26 08:27:24', 0),
(4, 'eric', '2', 1, NULL, '$2y$12$IREI7ZXob3wVDBFhYOSCQujRi0CoZt1UmmX1ajvXa0OOxVnR/OBk.', 'eric@gmail.com', 1, '2025-03-18 10:07:06', '2025-03-24 11:11:44', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `role_id` int NOT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`role_id`, `role_name`, `DESCRIPTION`, `created_at`, `updated_at`, `isDeleted`) VALUES
(1, 'Admin', 'Tingkat akses dan kontrol tertinggi dalam suatu sistem', NULL, NULL, 0),
(2, 'Penyuluh', 'Akses untuk melakukan penyuluhan data pertanian', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_types`
--

CREATE TABLE `user_types` (
  `user_type_id` int NOT NULL,
  `user_type_name` varchar(50) NOT NULL,
  `DESCRIPTION` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_types`
--

INSERT INTO `user_types` (`user_type_id`, `user_type_name`, `DESCRIPTION`, `created_at`, `updated_at`, `is_deleted`) VALUES
(1, 'pegawai', 'Pengguna dalam sistem yang memiliki akses dan peran sesuai dengan statusnya sebagai pegawai', NULL, NULL, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bantuan`
--
ALTER TABLE `bantuan`
  ADD PRIMARY KEY (`id_bantuan`),
  ADD KEY `id_kelompok_tani` (`id_kelompok_tani`);

--
-- Indexes for table `berita`
--
ALTER TABLE `berita`
  ADD PRIMARY KEY (`idBerita`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `bidang`
--
ALTER TABLE `bidang`
  ADD PRIMARY KEY (`id_bidang`),
  ADD KEY `fk_idDepartemen` (`idDepartemen`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`city_id`),
  ADD KEY `prov_id` (`prov_id`);

--
-- Indexes for table `data_pertanian`
--
ALTER TABLE `data_pertanian`
  ADD PRIMARY KEY (`id_data_pertanian`),
  ADD KEY `id_petani` (`id_petani`),
  ADD KEY `id_lahan` (`id_lahan`),
  ADD KEY `id_komoditas` (`id_komoditas`),
  ADD KEY `subdis_id` (`subdis_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `departemen`
--
ALTER TABLE `departemen`
  ADD PRIMARY KEY (`idDepartemen`);

--
-- Indexes for table `districts`
--
ALTER TABLE `districts`
  ADD PRIMARY KEY (`dis_id`),
  ADD KEY `city_id` (`city_id`);

--
-- Indexes for table `golonganpangkat`
--
ALTER TABLE `golonganpangkat`
  ADD PRIMARY KEY (`idGolonganPangkat`);

--
-- Indexes for table `harga_komoditas`
--
ALTER TABLE `harga_komoditas`
  ADD PRIMARY KEY (`id_harga`),
  ADD KEY `id_pasar` (`id_pasar`),
  ADD KEY `id_komoditas` (`id_komoditas`);

--
-- Indexes for table `jabatan`
--
ALTER TABLE `jabatan`
  ADD PRIMARY KEY (`idJabatan`);

--
-- Indexes for table `jabatanbidang`
--
ALTER TABLE `jabatanbidang`
  ADD PRIMARY KEY (`idJabatanBidang`),
  ADD KEY `idJabatan` (`idJabatan`),
  ADD KEY `fk_idBidang` (`id_bidang`);

--
-- Indexes for table `jabatan_petani`
--
ALTER TABLE `jabatan_petani`
  ADD PRIMARY KEY (`id_jabatan_petani`),
  ADD KEY `idJabatanBidang` (`idJabatanBidang`),
  ADD KEY `id_kelompok_tani` (`id_kelompok_tani`),
  ADD KEY `id_petani` (`id_petani`);

--
-- Indexes for table `jenis_komoditas`
--
ALTER TABLE `jenis_komoditas`
  ADD PRIMARY KEY (`id_jenis_komoditas`);

--
-- Indexes for table `jenis_lahan`
--
ALTER TABLE `jenis_lahan`
  ADD PRIMARY KEY (`id_jenis_lahan`);

--
-- Indexes for table `kelompok_tani`
--
ALTER TABLE `kelompok_tani`
  ADD PRIMARY KEY (`id_kelompok_tani`);

--
-- Indexes for table `komoditas`
--
ALTER TABLE `komoditas`
  ADD PRIMARY KEY (`id_komoditas`),
  ADD KEY `id_jenis_komoditas` (`id_jenis_komoditas`);

--
-- Indexes for table `lahan`
--
ALTER TABLE `lahan`
  ADD PRIMARY KEY (`id_lahan`),
  ADD KEY `id_jenis_lahan` (`id_jenis_lahan`);

--
-- Indexes for table `pasar`
--
ALTER TABLE `pasar`
  ADD PRIMARY KEY (`id_pasar`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`idPegawai`),
  ADD KEY `idGolonganPangkat` (`idGolonganPangkat`),
  ADD KEY `fk_idJabatanBidang` (`idJabatanBidang`),
  ADD KEY `subdis_id` (`subdis_id`);

--
-- Indexes for table `petani`
--
ALTER TABLE `petani`
  ADD PRIMARY KEY (`id_petani`),
  ADD KEY `id_kelompok_tani` (`id_kelompok_tani`);

--
-- Indexes for table `provinces`
--
ALTER TABLE `provinces`
  ADD PRIMARY KEY (`prov_id`);

--
-- Indexes for table `subdistricts`
--
ALTER TABLE `subdistricts`
  ADD PRIMARY KEY (`subdis_id`),
  ADD KEY `dis_id` (`dis_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_type_id` (`user_type_id`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `user_types`
--
ALTER TABLE `user_types`
  ADD PRIMARY KEY (`user_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bantuan`
--
ALTER TABLE `bantuan`
  MODIFY `id_bantuan` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `berita`
--
ALTER TABLE `berita`
  MODIFY `idBerita` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bidang`
--
ALTER TABLE `bidang`
  MODIFY `id_bidang` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `city_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `data_pertanian`
--
ALTER TABLE `data_pertanian`
  MODIFY `id_data_pertanian` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `departemen`
--
ALTER TABLE `departemen`
  MODIFY `idDepartemen` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `districts`
--
ALTER TABLE `districts`
  MODIFY `dis_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `golonganpangkat`
--
ALTER TABLE `golonganpangkat`
  MODIFY `idGolonganPangkat` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `harga_komoditas`
--
ALTER TABLE `harga_komoditas`
  MODIFY `id_harga` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jabatan`
--
ALTER TABLE `jabatan`
  MODIFY `idJabatan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `jabatanbidang`
--
ALTER TABLE `jabatanbidang`
  MODIFY `idJabatanBidang` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `jabatan_petani`
--
ALTER TABLE `jabatan_petani`
  MODIFY `id_jabatan_petani` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `jenis_komoditas`
--
ALTER TABLE `jenis_komoditas`
  MODIFY `id_jenis_komoditas` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jenis_lahan`
--
ALTER TABLE `jenis_lahan`
  MODIFY `id_jenis_lahan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `kelompok_tani`
--
ALTER TABLE `kelompok_tani`
  MODIFY `id_kelompok_tani` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `komoditas`
--
ALTER TABLE `komoditas`
  MODIFY `id_komoditas` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lahan`
--
ALTER TABLE `lahan`
  MODIFY `id_lahan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pasar`
--
ALTER TABLE `pasar`
  MODIFY `id_pasar` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pegawai`
--
ALTER TABLE `pegawai`
  MODIFY `idPegawai` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `petani`
--
ALTER TABLE `petani`
  MODIFY `id_petani` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `provinces`
--
ALTER TABLE `provinces`
  MODIFY `prov_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `subdistricts`
--
ALTER TABLE `subdistricts`
  MODIFY `subdis_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `role_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_types`
--
ALTER TABLE `user_types`
  MODIFY `user_type_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bantuan`
--
ALTER TABLE `bantuan`
  ADD CONSTRAINT `bantuan_ibfk_1` FOREIGN KEY (`id_kelompok_tani`) REFERENCES `kelompok_tani` (`id_kelompok_tani`);

--
-- Constraints for table `berita`
--
ALTER TABLE `berita`
  ADD CONSTRAINT `berita_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `bidang`
--
ALTER TABLE `bidang`
  ADD CONSTRAINT `fk_idDepartemen` FOREIGN KEY (`idDepartemen`) REFERENCES `departemen` (`idDepartemen`);

--
-- Constraints for table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`prov_id`) REFERENCES `provinces` (`prov_id`);

--
-- Constraints for table `data_pertanian`
--
ALTER TABLE `data_pertanian`
  ADD CONSTRAINT `data_pertanian_ibfk_1` FOREIGN KEY (`id_petani`) REFERENCES `petani` (`id_petani`),
  ADD CONSTRAINT `data_pertanian_ibfk_2` FOREIGN KEY (`id_lahan`) REFERENCES `lahan` (`id_lahan`),
  ADD CONSTRAINT `data_pertanian_ibfk_3` FOREIGN KEY (`id_komoditas`) REFERENCES `komoditas` (`id_komoditas`),
  ADD CONSTRAINT `data_pertanian_ibfk_4` FOREIGN KEY (`subdis_id`) REFERENCES `subdistricts` (`subdis_id`),
  ADD CONSTRAINT `data_pertanian_ibfk_5` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `districts`
--
ALTER TABLE `districts`
  ADD CONSTRAINT `districts_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`city_id`);

--
-- Constraints for table `harga_komoditas`
--
ALTER TABLE `harga_komoditas`
  ADD CONSTRAINT `harga_komoditas_ibfk_1` FOREIGN KEY (`id_pasar`) REFERENCES `pasar` (`id_pasar`),
  ADD CONSTRAINT `harga_komoditas_ibfk_2` FOREIGN KEY (`id_komoditas`) REFERENCES `komoditas` (`id_komoditas`);

--
-- Constraints for table `jabatanbidang`
--
ALTER TABLE `jabatanbidang`
  ADD CONSTRAINT `fk_idBidang` FOREIGN KEY (`id_bidang`) REFERENCES `bidang` (`id_bidang`),
  ADD CONSTRAINT `jabatanbidang_ibfk_1` FOREIGN KEY (`idJabatan`) REFERENCES `jabatan` (`idJabatan`);

--
-- Constraints for table `jabatan_petani`
--
ALTER TABLE `jabatan_petani`
  ADD CONSTRAINT `jabatan_petani_ibfk_1` FOREIGN KEY (`idJabatanBidang`) REFERENCES `jabatanbidang` (`idJabatanBidang`),
  ADD CONSTRAINT `jabatan_petani_ibfk_2` FOREIGN KEY (`id_kelompok_tani`) REFERENCES `kelompok_tani` (`id_kelompok_tani`),
  ADD CONSTRAINT `jabatan_petani_ibfk_3` FOREIGN KEY (`id_petani`) REFERENCES `petani` (`id_petani`);

--
-- Constraints for table `komoditas`
--
ALTER TABLE `komoditas`
  ADD CONSTRAINT `komoditas_ibfk_1` FOREIGN KEY (`id_jenis_komoditas`) REFERENCES `jenis_komoditas` (`id_jenis_komoditas`);

--
-- Constraints for table `lahan`
--
ALTER TABLE `lahan`
  ADD CONSTRAINT `lahan_ibfk_1` FOREIGN KEY (`id_jenis_lahan`) REFERENCES `jenis_lahan` (`id_jenis_lahan`);

--
-- Constraints for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD CONSTRAINT `fk_idJabatanBidang` FOREIGN KEY (`idJabatanBidang`) REFERENCES `jabatanbidang` (`idJabatanBidang`),
  ADD CONSTRAINT `pegawai_ibfk_1` FOREIGN KEY (`idGolonganPangkat`) REFERENCES `golonganpangkat` (`idGolonganPangkat`),
  ADD CONSTRAINT `pegawai_ibfk_2` FOREIGN KEY (`subdis_id`) REFERENCES `subdistricts` (`subdis_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `petani`
--
ALTER TABLE `petani`
  ADD CONSTRAINT `petani_ibfk_1` FOREIGN KEY (`id_kelompok_tani`) REFERENCES `kelompok_tani` (`id_kelompok_tani`);

--
-- Constraints for table `subdistricts`
--
ALTER TABLE `subdistricts`
  ADD CONSTRAINT `subdistricts_ibfk_1` FOREIGN KEY (`dis_id`) REFERENCES `districts` (`dis_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`user_type_id`) REFERENCES `user_types` (`user_type_id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
