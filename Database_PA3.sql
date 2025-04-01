/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306_1
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : database_pa3

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 01/04/2025 14:37:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bantuan
-- ----------------------------
DROP TABLE IF EXISTS `bantuan`;
CREATE TABLE `bantuan`  (
  `id_bantuan` int NOT NULL AUTO_INCREMENT,
  `jenis_bantuan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tanggal` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_kelompok_tani` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `isDeleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id_bantuan`) USING BTREE,
  INDEX `id_kelompok_tani`(`id_kelompok_tani` ASC) USING BTREE,
  CONSTRAINT `bantuan_ibfk_1` FOREIGN KEY (`id_kelompok_tani`) REFERENCES `kelompok_tani` (`id_kelompok_tani`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bantuan
-- ----------------------------

-- ----------------------------
-- Table structure for berita
-- ----------------------------
DROP TABLE IF EXISTS `berita`;
CREATE TABLE `berita`  (
  `idBerita` int NOT NULL AUTO_INCREMENT,
  `judul` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tanggal` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `isDeleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`idBerita`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `berita_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of berita
-- ----------------------------

-- ----------------------------
-- Table structure for bidang
-- ----------------------------
DROP TABLE IF EXISTS `bidang`;
CREATE TABLE `bidang`  (
  `id_bidang` int NOT NULL AUTO_INCREMENT,
  `idDepartemen` int NULL DEFAULT NULL,
  `parent_bidang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nama_bidang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id_bidang`) USING BTREE,
  INDEX `fk_idDepartemen`(`idDepartemen` ASC) USING BTREE,
  CONSTRAINT `fk_idDepartemen` FOREIGN KEY (`idDepartemen`) REFERENCES `departemen` (`idDepartemen`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bidang
-- ----------------------------
INSERT INTO `bidang` VALUES (1, 1, NULL, 'Dinas', 'Mengelola dinas pertanian Tapanuli Utara', NULL, '2025-04-01 14:01:15', 0);
INSERT INTO `bidang` VALUES (2, 1, NULL, 'UPT', 'Lembaga yang menjalankan sebagian fungsi teknis operasional dari suatu instansi atau lembaga induk', NULL, NULL, 0);
INSERT INTO `bidang` VALUES (3, 1, NULL, 'Tanaman Pangan', 'Mengelola tanaman pangan', NULL, NULL, 0);
INSERT INTO `bidang` VALUES (4, 1, NULL, 'Hortikultura', 'Mengelola tanaman hortikultura', NULL, NULL, 0);
INSERT INTO `bidang` VALUES (5, 1, NULL, 'Perkebunan', 'Mengelola tanaman perkebunan', NULL, NULL, 0);
INSERT INTO `bidang` VALUES (6, 1, NULL, 'Sarana dan Prasarana', 'Mengelola sarana dan prasarana', NULL, NULL, 0);
INSERT INTO `bidang` VALUES (7, 1, NULL, 'Penyuluhan', 'Mengelola penyuluhan data pertanian', NULL, NULL, 0);
INSERT INTO `bidang` VALUES (8, 2, NULL, 'Non Bidang', 'Tidak termasuk dalam bidang', NULL, NULL, 0);
INSERT INTO `bidang` VALUES (9, 1, NULL, 'Kesekretariatan', 'Bertanggung jawab atas administrasi, kepegawaian, keuangan, dan layanan umum untuk mendukung kelancaran operasional serta pengambilan keputusan pimpinan.', NULL, NULL, 0);

-- ----------------------------
-- Table structure for cities
-- ----------------------------
DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities`  (
  `city_id` int NOT NULL AUTO_INCREMENT,
  `city_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `prov_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`city_id`) USING BTREE,
  INDEX `prov_id`(`prov_id` ASC) USING BTREE,
  CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`prov_id`) REFERENCES `provinces` (`prov_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cities
-- ----------------------------
INSERT INTO `cities` VALUES (1, 'Tapanuli Utara', 1);

-- ----------------------------
-- Table structure for data_pertanian
-- ----------------------------
DROP TABLE IF EXISTS `data_pertanian`;
CREATE TABLE `data_pertanian`  (
  `id_data_pertanian` int NOT NULL AUTO_INCREMENT,
  `id_petani` int NULL DEFAULT NULL,
  `id_lahan` int NULL DEFAULT NULL,
  `id_komoditas` int NULL DEFAULT NULL,
  `luas_lahan` decimal(10, 2) NULL DEFAULT NULL,
  `subdis_id` int NULL DEFAULT NULL,
  `tanggal_tanam` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tanggal_pencatatan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `alamat_lengkap` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id_data_pertanian`) USING BTREE,
  INDEX `id_petani`(`id_petani` ASC) USING BTREE,
  INDEX `id_lahan`(`id_lahan` ASC) USING BTREE,
  INDEX `id_komoditas`(`id_komoditas` ASC) USING BTREE,
  INDEX `subdis_id`(`subdis_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `data_pertanian_ibfk_1` FOREIGN KEY (`id_petani`) REFERENCES `petani` (`id_petani`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `data_pertanian_ibfk_2` FOREIGN KEY (`id_lahan`) REFERENCES `lahan` (`id_lahan`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `data_pertanian_ibfk_3` FOREIGN KEY (`id_komoditas`) REFERENCES `komoditas` (`id_komoditas`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `data_pertanian_ibfk_4` FOREIGN KEY (`subdis_id`) REFERENCES `subdistricts` (`subdis_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `data_pertanian_ibfk_5` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of data_pertanian
-- ----------------------------
INSERT INTO `data_pertanian` VALUES (1, 1, 1, 1, 1000.00, 1, '11 Mar, 2025', '19 Mar, 2025', 2, 'Lumban Jaean', NULL, '2025-03-20 14:23:03', 1);
INSERT INTO `data_pertanian` VALUES (2, 1, 1, 1, 1000.00, 1, '04 Mar, 2025', '19 Mar, 2025', 2, 'Tarutung', NULL, '2025-03-30 21:03:36', 0);

-- ----------------------------
-- Table structure for departemen
-- ----------------------------
DROP TABLE IF EXISTS `departemen`;
CREATE TABLE `departemen`  (
  `idDepartemen` int NOT NULL AUTO_INCREMENT,
  `namaDepartmen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `createAt` datetime NULL DEFAULT NULL,
  `updateAt` datetime NULL DEFAULT NULL,
  `isDeleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`idDepartemen`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of departemen
-- ----------------------------
INSERT INTO `departemen` VALUES (1, 'Dinas Pertanian Tapanuli Utara', 'Instansi pemerintah daerah yang menangani pertanian', NULL, '2025-03-27 16:30:49', 0);
INSERT INTO `departemen` VALUES (2, 'Non Departemen', 'Tidak tergabung dalam departemen apapun', NULL, '2025-04-01 13:58:05', 0);

-- ----------------------------
-- Table structure for districts
-- ----------------------------
DROP TABLE IF EXISTS `districts`;
CREATE TABLE `districts`  (
  `dis_id` int NOT NULL AUTO_INCREMENT,
  `dis_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `city_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`dis_id`) USING BTREE,
  INDEX `city_id`(`city_id` ASC) USING BTREE,
  CONSTRAINT `districts_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`city_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of districts
-- ----------------------------
INSERT INTO `districts` VALUES (1, 'Tarutung', 1);
INSERT INTO `districts` VALUES (2, 'Muara', NULL);

-- ----------------------------
-- Table structure for golonganpangkat
-- ----------------------------
DROP TABLE IF EXISTS `golonganpangkat`;
CREATE TABLE `golonganpangkat`  (
  `idGolonganPangkat` int NOT NULL AUTO_INCREMENT,
  `golongan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pangkat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `createdAt` datetime NULL DEFAULT NULL,
  `updatedAt` datetime NULL DEFAULT NULL,
  `isDeleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`idGolonganPangkat`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of golonganpangkat
-- ----------------------------
INSERT INTO `golonganpangkat` VALUES (1, 'IV/d', 'Pembina Utama Madya', 'Jabatan tertinggi dalam struktural ASN', NULL, '2025-04-01 14:21:35', 0);
INSERT INTO `golonganpangkat` VALUES (2, 'IV/c', 'Pembina Utama Muda', 'Jabatan tinggi dalam struktural ASN', NULL, NULL, 0);
INSERT INTO `golonganpangkat` VALUES (3, 'IV/a', 'Pembina', 'Jabatan dalam struktural ASN', NULL, NULL, 0);
INSERT INTO `golonganpangkat` VALUES (4, 'III/d', 'Penata Tingkat I', 'Jabatan dalam fungsional ASN', NULL, NULL, 0);
INSERT INTO `golonganpangkat` VALUES (5, 'III/c', 'Penata', 'Jabatan dalam fungsional ASN', NULL, NULL, 0);

-- ----------------------------
-- Table structure for harga_komoditas
-- ----------------------------
DROP TABLE IF EXISTS `harga_komoditas`;
CREATE TABLE `harga_komoditas`  (
  `id_harga` int NOT NULL AUTO_INCREMENT,
  `harga` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tanggal` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_pasar` int NULL DEFAULT NULL,
  `id_komoditas` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `isDeleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id_harga`) USING BTREE,
  INDEX `id_pasar`(`id_pasar` ASC) USING BTREE,
  INDEX `id_komoditas`(`id_komoditas` ASC) USING BTREE,
  CONSTRAINT `harga_komoditas_ibfk_1` FOREIGN KEY (`id_pasar`) REFERENCES `pasar` (`id_pasar`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `harga_komoditas_ibfk_2` FOREIGN KEY (`id_komoditas`) REFERENCES `komoditas` (`id_komoditas`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of harga_komoditas
-- ----------------------------

-- ----------------------------
-- Table structure for jabatan
-- ----------------------------
DROP TABLE IF EXISTS `jabatan`;
CREATE TABLE `jabatan`  (
  `idJabatan` int NOT NULL AUTO_INCREMENT,
  `jabatan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `isDeleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`idJabatan`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jabatan
-- ----------------------------
INSERT INTO `jabatan` VALUES (1, 'Kepala', 'Jabatan tertinggi dalam struktur organisasi', NULL, '2025-04-01 14:04:54', 0);
INSERT INTO `jabatan` VALUES (2, 'Staff', 'Mendukung perencanaan, pelaksanaan, administrasi, serta monitoring program dan kebijakan pertanian', NULL, NULL, 0);
INSERT INTO `jabatan` VALUES (3, 'Fungsional', 'Jabatan dalam pemerintahan yang berisi tugas dan fungsi tertentu berdasarkan keahlian dan keterampilan', NULL, NULL, 0);
INSERT INTO `jabatan` VALUES (4, 'KASUBBAG', 'Jabatan struktural yang bertanggung jawab mengkoordinasikan, mengawasi, dan melaksanakan tugas administrasi, kepegawaian, keuangan, serta penyusunan laporan dalam suatu unit kerja untuk mendukung kelancaran operasional instansi.', NULL, NULL, 0);

-- ----------------------------
-- Table structure for jabatan_petani
-- ----------------------------
DROP TABLE IF EXISTS `jabatan_petani`;
CREATE TABLE `jabatan_petani`  (
  `id_jabatan_petani` int NOT NULL AUTO_INCREMENT,
  `idJabatanBidang` int NULL DEFAULT NULL,
  `id_kelompok_tani` int NULL DEFAULT NULL,
  `id_petani` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `isDeleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id_jabatan_petani`) USING BTREE,
  INDEX `idJabatanBidang`(`idJabatanBidang` ASC) USING BTREE,
  INDEX `id_kelompok_tani`(`id_kelompok_tani` ASC) USING BTREE,
  INDEX `id_petani`(`id_petani` ASC) USING BTREE,
  CONSTRAINT `jabatan_petani_ibfk_1` FOREIGN KEY (`idJabatanBidang`) REFERENCES `jabatanbidang` (`idJabatanBidang`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `jabatan_petani_ibfk_2` FOREIGN KEY (`id_kelompok_tani`) REFERENCES `kelompok_tani` (`id_kelompok_tani`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `jabatan_petani_ibfk_3` FOREIGN KEY (`id_petani`) REFERENCES `petani` (`id_petani`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jabatan_petani
-- ----------------------------
INSERT INTO `jabatan_petani` VALUES (3, 18, 2, 1, '2025-03-23 19:40:43', '2025-03-31 18:25:50', 0);
INSERT INTO `jabatan_petani` VALUES (7, 18, 3, 2, '2025-03-23 20:14:58', NULL, 0);
INSERT INTO `jabatan_petani` VALUES (8, 18, 4, 3, '2025-03-23 20:20:57', NULL, 0);
INSERT INTO `jabatan_petani` VALUES (9, 18, 5, 4, '2025-03-31 12:37:44', NULL, 0);

-- ----------------------------
-- Table structure for jabatanbidang
-- ----------------------------
DROP TABLE IF EXISTS `jabatanbidang`;
CREATE TABLE `jabatanbidang`  (
  `idJabatanBidang` int NOT NULL AUTO_INCREMENT,
  `idJabatan` int NULL DEFAULT NULL,
  `id_bidang` int NULL DEFAULT NULL,
  `namaJabatanBidang` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `isDeleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`idJabatanBidang`) USING BTREE,
  INDEX `idJabatan`(`idJabatan` ASC) USING BTREE,
  INDEX `fk_idBidang`(`id_bidang` ASC) USING BTREE,
  CONSTRAINT `fk_idBidang` FOREIGN KEY (`id_bidang`) REFERENCES `bidang` (`id_bidang`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `jabatanbidang_ibfk_1` FOREIGN KEY (`idJabatan`) REFERENCES `jabatan` (`idJabatan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jabatanbidang
-- ----------------------------
INSERT INTO `jabatanbidang` VALUES (9, 1, 1, 'Kepala Dinas Pertanian Tapanuli Utara', 'Pimpinan yang mempunyai tugas memimpin mengkoordinasikan, menyelenggarakan, mengevaluasi dan pelaporan kegiatan bidang pertanian.', NULL, '2025-03-31 09:12:42', 0);
INSERT INTO `jabatanbidang` VALUES (10, 1, 2, 'Kepala UPT Alsintan', 'Mengelola, mengoperasikan, dan mengawasi unit layanan alat dan mesin pertanian.', NULL, NULL, 0);
INSERT INTO `jabatanbidang` VALUES (11, 1, 2, 'Kepala UPT Laboratorium dan POPT', 'Pengelolaan laboratorium serta pengendalian organisme pengganggu tumbuhan', NULL, NULL, 0);
INSERT INTO `jabatanbidang` VALUES (12, 1, 3, 'Kepala Bidang Tanaman Pangan', 'Merencanakan, mengkoordinasikan, mengawasi, dan mengevaluasi program serta kebijakan di bidang tanaman pangan', NULL, NULL, 0);
INSERT INTO `jabatanbidang` VALUES (13, 1, 4, 'Kepala Bidang Hortikultura', 'Merencanakan, mengkoordinasikan, mengawasi, dan mengevaluasi program serta kebijakan di bidang tanaman hortikultura', NULL, NULL, 0);
INSERT INTO `jabatanbidang` VALUES (14, 1, 5, 'Kepala Bidang Perkebunan', 'Merencanakan, mengkoordinasikan, mengawasi, dan mengevaluasi program serta kebijakan di bidang perkebunan', NULL, NULL, 0);
INSERT INTO `jabatanbidang` VALUES (15, 1, 6, 'Kepala Bidang Sarana dan Prasarana', 'Merencanakan, mengkoordinasikan, mengawasi, dan mengevaluasi program serta kebijakan di bidang sarana dan prasarana', NULL, NULL, 0);
INSERT INTO `jabatanbidang` VALUES (16, 1, 7, 'Kepala Bidang Penyuluhan', 'Merencanakan, mengkoordinasikan, mengawasi, dan mengevaluasi program serta kebijakan di bidang penyuluhan', NULL, NULL, 0);
INSERT INTO `jabatanbidang` VALUES (18, 1, 8, 'Kepala Kelompok Tani', 'Pemimpin yang bertanggung jawab atas semua kegiatan kelompok tani.', '2025-03-23 19:07:02', '2025-04-01 14:15:37', 0);

-- ----------------------------
-- Table structure for jenis_komoditas
-- ----------------------------
DROP TABLE IF EXISTS `jenis_komoditas`;
CREATE TABLE `jenis_komoditas`  (
  `id_jenis_komoditas` int NOT NULL AUTO_INCREMENT,
  `nama_jenis_komoditas` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id_jenis_komoditas`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jenis_komoditas
-- ----------------------------
INSERT INTO `jenis_komoditas` VALUES (1, 'Tanaman Pangan', NULL, '2025-04-01 13:27:25', 0);
INSERT INTO `jenis_komoditas` VALUES (2, 'Hortikultura', NULL, NULL, 0);

-- ----------------------------
-- Table structure for jenis_lahan
-- ----------------------------
DROP TABLE IF EXISTS `jenis_lahan`;
CREATE TABLE `jenis_lahan`  (
  `id_jenis_lahan` int NOT NULL AUTO_INCREMENT,
  `nama_jenis_lahan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id_jenis_lahan`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jenis_lahan
-- ----------------------------
INSERT INTO `jenis_lahan` VALUES (1, 'Lahan Basah', NULL, '2025-04-01 13:42:00', 0);

-- ----------------------------
-- Table structure for kelompok_tani
-- ----------------------------
DROP TABLE IF EXISTS `kelompok_tani`;
CREATE TABLE `kelompok_tani`  (
  `id_kelompok_tani` int NOT NULL AUTO_INCREMENT,
  `nama_kelompok_tani` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `alamat_sekretariat` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id_kelompok_tani`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kelompok_tani
-- ----------------------------
INSERT INTO `kelompok_tani` VALUES (2, 'Sejahtera', 'Lumban Jaean', NULL, '2025-03-31 17:51:22', 0);
INSERT INTO `kelompok_tani` VALUES (3, 'Setia', 'Lumban Jaean', NULL, NULL, 0);
INSERT INTO `kelompok_tani` VALUES (4, 'DOSROHA LUMBAN JAEAN', 'Lumban Jaean', NULL, NULL, 0);
INSERT INTO `kelompok_tani` VALUES (5, 'Maju Bersama', 'Lumban Jaean', NULL, '2025-04-01 14:35:47', 0);

-- ----------------------------
-- Table structure for komoditas
-- ----------------------------
DROP TABLE IF EXISTS `komoditas`;
CREATE TABLE `komoditas`  (
  `id_komoditas` int NOT NULL AUTO_INCREMENT,
  `nama_komoditas` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_jenis_komoditas` int NULL DEFAULT NULL,
  `estimasi_panen` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id_komoditas`) USING BTREE,
  INDEX `id_jenis_komoditas`(`id_jenis_komoditas` ASC) USING BTREE,
  CONSTRAINT `komoditas_ibfk_1` FOREIGN KEY (`id_jenis_komoditas`) REFERENCES `jenis_komoditas` (`id_jenis_komoditas`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of komoditas
-- ----------------------------
INSERT INTO `komoditas` VALUES (1, 'Padi', 1, '151', NULL, '2025-04-01 13:37:09', 0);

-- ----------------------------
-- Table structure for lahan
-- ----------------------------
DROP TABLE IF EXISTS `lahan`;
CREATE TABLE `lahan`  (
  `id_lahan` int NOT NULL AUTO_INCREMENT,
  `nama_lahan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_jenis_lahan` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id_lahan`) USING BTREE,
  INDEX `id_jenis_lahan`(`id_jenis_lahan` ASC) USING BTREE,
  CONSTRAINT `lahan_ibfk_1` FOREIGN KEY (`id_jenis_lahan`) REFERENCES `jenis_lahan` (`id_jenis_lahan`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lahan
-- ----------------------------
INSERT INTO `lahan` VALUES (1, 'Sawah', 1, NULL, '2025-04-01 13:53:53', 0);

-- ----------------------------
-- Table structure for pasar
-- ----------------------------
DROP TABLE IF EXISTS `pasar`;
CREATE TABLE `pasar`  (
  `id_pasar` int NOT NULL AUTO_INCREMENT,
  `nama_pasar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `lokasi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `isDeleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id_pasar`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pasar
-- ----------------------------

-- ----------------------------
-- Table structure for pegawai
-- ----------------------------
DROP TABLE IF EXISTS `pegawai`;
CREATE TABLE `pegawai`  (
  `idPegawai` int NOT NULL AUTO_INCREMENT,
  `nip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `namaPegawai` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `idGolonganPangkat` int NULL DEFAULT NULL,
  `idJabatanBidang` int NULL DEFAULT NULL,
  `subdis_id` int NULL DEFAULT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `noPonsel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `noWA` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fileFoto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `isDeleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`idPegawai`) USING BTREE,
  INDEX `idGolonganPangkat`(`idGolonganPangkat` ASC) USING BTREE,
  INDEX `fk_idJabatanBidang`(`idJabatanBidang` ASC) USING BTREE,
  INDEX `subdis_id`(`subdis_id` ASC) USING BTREE,
  CONSTRAINT `fk_idJabatanBidang` FOREIGN KEY (`idJabatanBidang`) REFERENCES `jabatanbidang` (`idJabatanBidang`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `pegawai_ibfk_1` FOREIGN KEY (`idGolonganPangkat`) REFERENCES `golonganpangkat` (`idGolonganPangkat`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `pegawai_ibfk_2` FOREIGN KEY (`subdis_id`) REFERENCES `subdistricts` (`subdis_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pegawai
-- ----------------------------
INSERT INTO `pegawai` VALUES (1, '123123123', 'Gilberd Siboro', 2, 9, 1, 'IT Del', '081260951690', '877381928382', '1743481512_gil.jpg', NULL, '2025-04-01 14:25:25', 0);
INSERT INTO `pegawai` VALUES (2, '123981238', 'Erichson Berutu', 4, 16, 1, 'Tarutung', '088238192', '231231423', 'reza.jpg', NULL, NULL, 0);

-- ----------------------------
-- Table structure for petani
-- ----------------------------
DROP TABLE IF EXISTS `petani`;
CREATE TABLE `petani`  (
  `id_petani` int NOT NULL AUTO_INCREMENT,
  `nama_depan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_belakang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `alamat_rumah` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_kelompok_tani` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id_petani`) USING BTREE,
  INDEX `id_kelompok_tani`(`id_kelompok_tani` ASC) USING BTREE,
  CONSTRAINT `petani_ibfk_1` FOREIGN KEY (`id_kelompok_tani`) REFERENCES `kelompok_tani` (`id_kelompok_tani`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of petani
-- ----------------------------
INSERT INTO `petani` VALUES (1, 'Erichson', 'Berutu', 'Lumban Jaean', 2, NULL, '2025-03-31 17:29:22', 0);
INSERT INTO `petani` VALUES (2, 'Volwin', 'Sitompul', 'Lumban Jaean', 3, NULL, NULL, 0);
INSERT INTO `petani` VALUES (3, 'Yanti', 'Sitompul', 'Lumban Jaean', 4, NULL, NULL, 0);
INSERT INTO `petani` VALUES (4, 'Erika', 'Magdalena Simanungkalit', 'Lumban Jaean', 5, NULL, NULL, 0);
INSERT INTO `petani` VALUES (5, 'Kevin', 'Simangunsong', 'Siantar', 2, NULL, '2025-04-01 14:30:55', 0);

-- ----------------------------
-- Table structure for provinces
-- ----------------------------
DROP TABLE IF EXISTS `provinces`;
CREATE TABLE `provinces`  (
  `prov_id` int NOT NULL AUTO_INCREMENT,
  `prov_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `location_id` int NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`prov_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of provinces
-- ----------------------------
INSERT INTO `provinces` VALUES (1, 'Sumatera Utara', NULL, NULL);

-- ----------------------------
-- Table structure for subdistricts
-- ----------------------------
DROP TABLE IF EXISTS `subdistricts`;
CREATE TABLE `subdistricts`  (
  `subdis_id` int NOT NULL AUTO_INCREMENT,
  `subdis_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dis_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`subdis_id`) USING BTREE,
  INDEX `dis_id`(`dis_id` ASC) USING BTREE,
  CONSTRAINT `subdistricts_ibfk_1` FOREIGN KEY (`dis_id`) REFERENCES `districts` (`dis_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subdistricts
-- ----------------------------
INSERT INTO `subdistricts` VALUES (1, 'Hutatoruan VI', 1);
INSERT INTO `subdistricts` VALUES (2, 'Hapoltahan', 1);

-- ----------------------------
-- Table structure for user_roles
-- ----------------------------
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles`  (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `isDeleted` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_roles
-- ----------------------------
INSERT INTO `user_roles` VALUES (1, 'Admin', 'Tingkat akses dan kontrol tertinggi dalam suatu sistem', NULL, NULL, 0);
INSERT INTO `user_roles` VALUES (2, 'Penyuluh', 'Akses untuk melakukan penyuluhan data pertanian', NULL, NULL, 0);

-- ----------------------------
-- Table structure for user_types
-- ----------------------------
DROP TABLE IF EXISTS `user_types`;
CREATE TABLE `user_types`  (
  `user_type_id` int NOT NULL AUTO_INCREMENT,
  `user_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DESCRIPTION` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`user_type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_types
-- ----------------------------
INSERT INTO `user_types` VALUES (1, 'pegawai', 'Pengguna dalam sistem yang memiliki akses dan peran sesuai dengan statusnya sebagai pegawai', NULL, NULL, 0);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `personal_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_type_id` int NULL DEFAULT NULL,
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role_id` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `user_type_id`(`user_type_id` ASC) USING BTREE,
  INDEX `role_id`(`role_id` ASC) USING BTREE,
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`user_type_id`) REFERENCES `user_types` (`user_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`role_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'pertanian', '1', 1, NULL, '$2y$12$c8roUKWHlDDuaRxREfJm9.9WxdZiDVc9w9CbhdLZTgS7mEek9Km8a', 'asdasd@gmail.com', 1, NULL, '2025-04-01 12:57:04', 0);
INSERT INTO `users` VALUES (2, 'penyuluh', '1', 1, NULL, '$2y$12$xWUr9RuFuOnEMH7rpdkAcOS1CnsrJkWXOqTfbBUctPyxz6B6.4dqi', 'asd@gmail.com', 2, NULL, '2025-03-26 08:27:24', 0);
INSERT INTO `users` VALUES (4, 'eric', '2', 1, NULL, '$2y$12$IREI7ZXob3wVDBFhYOSCQujRi0CoZt1UmmX1ajvXa0OOxVnR/OBk.', 'eric@gmail.com', 1, '2025-03-18 10:07:06', '2025-03-24 11:11:44', 1);

-- ----------------------------
-- Procedure structure for delete_bidang
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_bidang`;
delimiter ;;
CREATE PROCEDURE `delete_bidang`(IN idBidang JSON)
BEGIN#Routine body goes here...
	UPDATE bidang 
	SET bidang.is_deleted = 1,
	bidang.updated_at = NOW() 
	WHERE
		bidang.id_bidang = idBidang;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_dataPertanian
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_dataPertanian`;
delimiter ;;
CREATE PROCEDURE `delete_dataPertanian`(IN `idDataPertanian` int)
BEGIN
	#Routine body goes here...
	UPDATE data_pertanian SET data_pertanian.is_deleted = 1, data_pertanian.updated_at = NOW()
	WHERE data_pertanian.id_data_pertanian = idDataPertanian;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_departemen
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_departemen`;
delimiter ;;
CREATE PROCEDURE `delete_departemen`(IN idDepartemen JSON)
BEGIN#Routine body goes here...
	UPDATE departemen 
	SET departemen.isDeleted = 1,
	departemen.updateAt = NOW() 
	WHERE
		departemen.idDepartemen = idDepartemen;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_golonganPangkat
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_golonganPangkat`;
delimiter ;;
CREATE PROCEDURE `delete_golonganPangkat`(IN idGolonganPangkat JSON)
BEGIN#Routine body goes here...
	UPDATE golonganpangkat 
	SET golonganpangkat.isDeleted = 1,
	golonganpangkat.updatedAt = NOW() 
	WHERE
		golonganpangkat.idGolonganPangkat = idGolonganPangkat;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_jabatan
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_jabatan`;
delimiter ;;
CREATE PROCEDURE `delete_jabatan`(IN idJabatan JSON)
BEGIN#Routine body goes here...
	UPDATE jabatan 
	SET jabatan.isDeleted = 1,
	jabatan.updated_at = NOW() 
	WHERE
		jabatan.idJabatan = idJabatan;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_jabatanBidang
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_jabatanBidang`;
delimiter ;;
CREATE PROCEDURE `delete_jabatanBidang`(IN idJabatanBidang JSON)
BEGIN#Routine body goes here...
	UPDATE jabatanbidang 
	SET jabatanbidang.isDeleted = 1,
	jabatanbidang.updated_at = NOW() 
	WHERE
		jabatanbidang.idJabatanBidang = idJabatanBidang;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_jenisKomoditas
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_jenisKomoditas`;
delimiter ;;
CREATE PROCEDURE `delete_jenisKomoditas`(IN idJenisKomoditas JSON)
BEGIN#Routine body goes here...
	UPDATE jenis_komoditas 
	SET jenis_komoditas.is_deleted = 1,
	jenis_komoditas.updated_at = NOW() 
	WHERE
		jenis_komoditas.id_jenis_komoditas = idJenisKomoditas;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_jenisLahan
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_jenisLahan`;
delimiter ;;
CREATE PROCEDURE `delete_jenisLahan`(IN idJenisLahan JSON)
BEGIN#Routine body goes here...
	UPDATE jenis_lahan 
	SET jenis_lahan.is_deleted = 1,
	jenis_lahan.updated_at = NOW() 
	WHERE
		jenis_lahan.id_jenis_lahan = idJenisLahan;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_kelompokTani
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_kelompokTani`;
delimiter ;;
CREATE PROCEDURE `delete_kelompokTani`(IN idKelompokTani JSON)
BEGIN#Routine body goes here...
	UPDATE kelompok_tani 
	SET kelompok_tani.is_deleted = 1,
	kelompok_tani.updated_at = NOW() 
	WHERE
		kelompok_tani.id_kelompok_tani = idKelompokTani;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_komoditas
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_komoditas`;
delimiter ;;
CREATE PROCEDURE `delete_komoditas`(IN idKomoditas JSON)
BEGIN#Routine body goes here...
	UPDATE komoditas 
	SET komoditas.is_deleted = 1,
	komoditas.updated_at = NOW() 
	WHERE
		komoditas.id_komoditas = idKomoditas;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_lahan
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_lahan`;
delimiter ;;
CREATE PROCEDURE `delete_lahan`(IN idLahan JSON)
BEGIN#Routine body goes here...
	UPDATE lahan 
	SET lahan.is_deleted = 1,
	lahan.updated_at = NOW() 
	WHERE
		lahan.id_lahan = idLahan;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_pegawai
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_pegawai`;
delimiter ;;
CREATE PROCEDURE `delete_pegawai`(IN idPegawai JSON)
BEGIN#Routine body goes here...
	UPDATE pegawai 
	SET pegawai.isDeleted = 1,
	pegawai.updated_at = NOW() 
	WHERE
		pegawai.idPegawai = idPegawai;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_pengguna
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_pengguna`;
delimiter ;;
CREATE PROCEDURE `delete_pengguna`(IN idPengguna JSON)
BEGIN
	#Routine body goes here...
		UPDATE users SET users.is_deleted = 1, users.updated_at = NOW()
	WHERE users.user_id = idPengguna;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_petani
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_petani`;
delimiter ;;
CREATE PROCEDURE `delete_petani`(IN idPetani JSON)
BEGIN#Routine body goes here...
	UPDATE petani 
	SET petani.is_deleted = 1,
	petani.updated_at = NOW() 
	WHERE
		petani.id_petani = idPetani;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_bidang
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_bidang`;
delimiter ;;
CREATE PROCEDURE `insert_bidang`(IN dataBidang JSON)
BEGIN
    -- Mengambil data dari JSON
    SET @nama_departmen = JSON_UNQUOTE(JSON_EXTRACT(dataBidang, '$.NamaDepartmen'));
    SET @nama_bidang = JSON_UNQUOTE(JSON_EXTRACT(dataBidang, '$.NamaBidang'));
    SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataBidang, '$.Keterangan'));

    -- Memasukkan data ke tabel
    INSERT INTO bidang (idDepartemen, nama_bidang, keterangan, created_at)
    VALUES (@nama_departmen, @nama_bidang, @keterangan, NOW());
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_dataPertanian
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_dataPertanian`;
delimiter ;;
CREATE PROCEDURE `insert_dataPertanian`(IN `dataPertanian` JSON)
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_departmen
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_departmen`;
delimiter ;;
CREATE PROCEDURE `insert_departmen`(IN dataDepartmen JSON)
BEGIN
    -- Mengambil data dari JSON
    SET @nama_departmen = JSON_UNQUOTE(JSON_EXTRACT(dataDepartmen, '$.NamaDepartmen'));
    SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataDepartmen, '$.Keterangan'));

    -- Memasukkan data ke tabel
    INSERT INTO departemen (namaDepartmen, keterangan, createAt)
    VALUES (@nama_departmen, @keterangan, NOW());
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_desa
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_desa`;
delimiter ;;
CREATE PROCEDURE `insert_desa`(IN dataDesa JSON)
BEGIN
	#Routine body goes here...
	SET @nama_desa = JSON_UNQUOTE(JSON_EXTRACT(dataDesa,'$.NamaDesa'));
	SET @kecamatan = JSON_UNQUOTE(JSON_EXTRACT(dataDesa,'$.Kecamatan'));

	INSERT INTO subdistricts(subdis_name,dis_id)
	VALUES(@nama_desa, @kecamatan);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_golonganPangkat
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_golonganPangkat`;
delimiter ;;
CREATE PROCEDURE `insert_golonganPangkat`(IN dataGolonganPangkat JSON)
BEGIN
    -- Mengambil data dari JSON
    SET @golongan = JSON_UNQUOTE(JSON_EXTRACT(dataGolonganPangkat, '$.Golongan'));
    SET @pangkat = JSON_UNQUOTE(JSON_EXTRACT(dataGolonganPangkat, '$.Pangkat'));
    SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataGolonganPangkat, '$.Keterangan'));

    -- Memasukkan data ke tabel
    INSERT INTO golonganpangkat (golongan, pangkat,  keterangan, createdAt)
    VALUES (@golongan, @pangkat, @keterangan, NOW());
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_jabatan
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_jabatan`;
delimiter ;;
CREATE PROCEDURE `insert_jabatan`(IN dataJabatan JSON)
BEGIN
    -- Mengambil data dari JSON
    SET @jabatan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatan, '$.Jabatan'));
    SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatan, '$.Keterangan'));

    -- Memasukkan data ke tabel
    INSERT INTO jabatan (jabatan, keterangan, created_at)
    VALUES (@jabatan, @keterangan, NOW());
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_jabatanBidang
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_jabatanBidang`;
delimiter ;;
CREATE PROCEDURE `insert_jabatanBidang`(IN dataJabatanBidang JSON)
BEGIN
    -- Mengambil data dari JSON
    SET @jabatan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang, '$.Jabatan'));
    SET @bidang = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang, '$.Bidang'));
    SET @jabatanBidang = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang, '$.JabatanBidang'));
    SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang, '$.Keterangan'));

    -- Memasukkan data ke tabel
    INSERT INTO jabatanbidang (idJabatan, id_bidang, namaJabatanBidang, keterangan, created_at)
    VALUES (@jabatan, @bidang, @jabatanBidang, @keterangan, NOW());
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_jabatanPetani
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_jabatanPetani`;
delimiter ;;
CREATE PROCEDURE `insert_jabatanPetani`(IN dataJabatanPetani JSON)
BEGIN
    -- Mengambil data dari JSON
    SET @jabatanBidang = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanPetani, '$.JabatanBidang'));
    SET @kelompokTani = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanPetani, '$.KelompokTani'));
    SET @petani = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanPetani, '$.Petani'));
		
    -- Memasukkan data ke tabel
    INSERT INTO jabatan_petani (idJabatanBidang, id_kelompok_tani,  id_petani, created_at)
    VALUES (@jabatanBidang , @kelompokTani, @petani, NOW());
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_jenisKomoditas
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_jenisKomoditas`;
delimiter ;;
CREATE PROCEDURE `insert_jenisKomoditas`(IN dataJenisKomoditas JSON)
BEGIN
	#Routine body goes here...
	SET @nama_jenis_komoditas = JSON_UNQUOTE(JSON_EXTRACT(dataJenisKomoditas,'$.JenisKomoditas'));

	INSERT INTO jenis_komoditas(jenis_komoditas.nama_jenis_komoditas, jenis_komoditas.created_at)
	VALUES(@nama_jenis_komoditas, NOW());
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_jenisLahan
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_jenisLahan`;
delimiter ;;
CREATE PROCEDURE `insert_jenisLahan`(IN dataJenisLahan JSON)
BEGIN
	#Routine body goes here...
	SET @jenis_lahan = JSON_UNQUOTE(JSON_EXTRACT(dataJenisLahan,'$.JenisLahan'));

	INSERT INTO jenis_lahan(`nama_jenis_lahan`, `created_at`)
	VALUES(@jenis_lahan, NOW());
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_kecamatan
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_kecamatan`;
delimiter ;;
CREATE PROCEDURE `insert_kecamatan`(IN dataKecamatan JSON)
BEGIN
	#Routine body goes here...
	SET @kecamatan = JSON_UNQUOTE(JSON_EXTRACT(dataKecamatan,'$.Kecamatan'));

	INSERT INTO districts(dis_name)
	VALUES(@kecamatan);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_kelompokTani
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_kelompokTani`;
delimiter ;;
CREATE PROCEDURE `insert_kelompokTani`(IN dataKelompokTani JSON)
BEGIN
	#Routine body goes here...
	SET @nama_kelompok = JSON_UNQUOTE(JSON_EXTRACT(dataKelompokTani,'$.NamaKelompokTani'));
	SET @alamat = JSON_UNQUOTE(JSON_EXTRACT(dataKelompokTani,'$.AlamatSekretariat'));

	INSERT INTO kelompok_tani(`nama_kelompok_tani`,`alamat_sekretariat`,`created_at`)
	VALUES(@nama_kelompok, @alamat, NOW());
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_komoditas
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_komoditas`;
delimiter ;;
CREATE PROCEDURE `insert_komoditas`(IN dataKomoditas JSON)
BEGIN
	#Routine body goes here...
	SET @jenis_komoditas = JSON_UNQUOTE(JSON_EXTRACT(dataKomoditas,'$.JenisKomoditas'));
	SET @nama_komoditas = JSON_UNQUOTE(JSON_EXTRACT(dataKomoditas,'$.NamaKomoditas'));
	SET @estimasi_panen = JSON_UNQUOTE(JSON_EXTRACT(dataKomoditas,'$.EstimasiPanen'));

	INSERT INTO komoditas(`id_jenis_komoditas`,`nama_komoditas`,`estimasi_panen`, `created_at`)
	VALUES(@jenis_komoditas, @nama_komoditas, @estimasi_panen, NOW());
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_lahan
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_lahan`;
delimiter ;;
CREATE PROCEDURE `insert_lahan`(IN dataLahan JSON)
BEGIN
	#Routine body goes here...
	SET @jenis_lahan = JSON_UNQUOTE(JSON_EXTRACT(dataLahan,'$.JenisLahan'));
	SET @lahan = JSON_UNQUOTE(JSON_EXTRACT(dataLahan,'$.Lahan'));

	INSERT INTO lahan(lahan.id_jenis_lahan,lahan.nama_lahan, lahan.created_at)
	VALUES(@jenis_lahan, @lahan, NOW());
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_pegawai
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_pegawai`;
delimiter ;;
CREATE PROCEDURE `insert_pegawai`(IN dataPegawai JSON)
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_pengguna
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_pengguna`;
delimiter ;;
CREATE PROCEDURE `insert_pengguna`(IN `dataPengguna` JSON)
BEGIN
    SET @username = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna, '$.Username'));
    SET @email = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna, '$.Email'));
    SET @`password` = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna, '$.Password'));
    SET @role = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna, '$.Role'));
    SET @pegawai = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna, '$.Pegawai'));

    INSERT INTO `users` (`username`, `email`, `password`, `role_id`, `personal_id`, `user_type_id`, `created_at`)
    VALUES (@username, @email, @`password`, @role, @pegawai, 1, NOW()); 
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for insert_petani
-- ----------------------------
DROP PROCEDURE IF EXISTS `insert_petani`;
delimiter ;;
CREATE PROCEDURE `insert_petani`(IN dataPetani JSON)
BEGIN
	#Routine body goes here...
	SET @nama_depan = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.NamaDepan'));
	SET @nama_belakang = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.NamaBelakang'));
	SET @alamat = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.AlamatRumah'));
	SET @kelompok_tani = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.KelompokTani'));

	INSERT INTO petani(`nama_depan`,`nama_belakang`,`alamat_rumah`,petani.id_kelompok_tani, petani.created_at)
	VALUES(@nama_depan, @nama_belakang, @alamat, @kelompok_tani, NOW());
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_bidang
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_bidang`;
delimiter ;;
CREATE PROCEDURE `update_bidang`(IN dataBidang JSON)
BEGIN
	#Routine body goes here...
	
	SET @idBidang = JSON_UNQUOTE(JSON_EXTRACT(dataBidang,'$.IdBidang'));
	SET @idDepartemen = JSON_UNQUOTE(JSON_EXTRACT(dataBidang,'$.IdDepartemen'));
	SET @bidang = JSON_UNQUOTE(JSON_EXTRACT(dataBidang,'$.NamaBidang'));
	SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataBidang,'$.Keterangan'));
		
	UPDATE bidang SET bidang.nama_bidang=@bidang, bidang.idDepartemen=@idDepartemen, bidang.keterangan = @keterangan, bidang.updated_at=NOW()
	WHERE bidang.id_bidang=@idBidang;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_dataPertanian
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_dataPertanian`;
delimiter ;;
CREATE PROCEDURE `update_dataPertanian`(IN `dataPertanian` JSON)
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_departemen
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_departemen`;
delimiter ;;
CREATE PROCEDURE `update_departemen`(IN dataDepartemen JSON)
BEGIN
	#Routine body goes here...
	
	SET @idDepartemen = JSON_UNQUOTE(JSON_EXTRACT(dataDepartemen,'$.IdDepartemen'));
	SET @namaDepartemen = JSON_UNQUOTE(JSON_EXTRACT(dataDepartemen,'$.NamaDepartemen'));
	SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataDepartemen,'$.Keterangan'));
		
	UPDATE departemen SET departemen.namaDepartmen=@namaDepartemen, departemen.keterangan=@keterangan, departemen.updateAt=NOW()
	WHERE departemen.idDepartemen=@idDepartemen;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_desa
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_desa`;
delimiter ;;
CREATE PROCEDURE `update_desa`(IN dataDesa JSON)
BEGIN
	#Routine body goes here...
	SET @idDesa = JSON_UNQUOTE(JSON_EXTRACT(dataDesa,'$.IdDesa'));
	SET @desa = JSON_UNQUOTE(JSON_EXTRACT(dataDesa,'$.NamaDesa'));
	SET @kecamatan = JSON_UNQUOTE(JSON_EXTRACT(dataDesa,'$.Kecamatan'));
	
	UPDATE subdistricts SET subdistricts.subdis_name=@desa, subdistricts.dis_id = @kecamatan
	WHERE subdistricts.subdis_id=@idDesa;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_golonganPangkat
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_golonganPangkat`;
delimiter ;;
CREATE PROCEDURE `update_golonganPangkat`(IN dataGolonganPangkat JSON)
BEGIN
	#Routine body goes here...
	SET @idGolonganPangkat = JSON_UNQUOTE(JSON_EXTRACT(dataGolonganPangkat,'$.IdGolonganPangkat'));
	SET @golongan = JSON_UNQUOTE(JSON_EXTRACT(dataGolonganPangkat,'$.Golongan'));
	SET @pangkat = JSON_UNQUOTE(JSON_EXTRACT(dataGolonganPangkat,'$.Pangkat'));
	SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataGolonganPangkat,'$.Keterangan'));
	
	UPDATE golonganpangkat SET golonganpangkat.golongan=@golongan, golonganpangkat.pangkat=@pangkat, golonganpangkat.keterangan=@keterangan, golonganpangkat.updatedAt=NOW()
	WHERE golonganpangkat.idGolonganPangkat=@idGolonganPangkat;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_jabatan
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_jabatan`;
delimiter ;;
CREATE PROCEDURE `update_jabatan`(IN dataJabatan JSON)
BEGIN
	#Routine body goes here...
	SET @idJabatan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatan,'$.IdJabatan'));
	SET @jabatan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatan,'$.Jabatan'));
	SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatan,'$.Keterangan'));
	
	UPDATE jabatan SET jabatan.jabatan=@jabatan, jabatan.keterangan=@keterangan, jabatan.updated_at=NOW()
	WHERE jabatan.idJabatan=@idJabatan;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_jabatanBidang
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_jabatanBidang`;
delimiter ;;
CREATE PROCEDURE `update_jabatanBidang`(IN dataJabatanBidang JSON)
BEGIN
	#Routine body goes here...
	SET @idJabatanBidang = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang,'$.IdJabatanBidang'));
	SET @jabatan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang,'$.Jabatan'));
	SET @bidang = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang,'$.Bidang'));
	SET @jabatanBidang = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang,'$.JabatanBidang'));
	SET @keterangan = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanBidang,'$.Keterangan'));
	
	UPDATE jabatanbidang SET jabatanbidang.idJabatan=@jabatan, jabatanbidang.id_bidang=@bidang, jabatanbidang.namaJabatanBidang=@jabatanBidang, jabatanbidang.keterangan=@keterangan, jabatanbidang.updated_at=NOW()
	WHERE jabatanbidang.idJabatanBidang=@idJabatanBidang;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_jabatanPetani
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_jabatanPetani`;
delimiter ;;
CREATE PROCEDURE `update_jabatanPetani`(IN dataJabatanPetani JSON)
BEGIN
	#Routine body goes here...
	SET @idJabatanPetani = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanPetani,'$.IdJabatanPetani'));
	SET @jabatanBidang = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanPetani,'$.JabatanBidang'));
	SET @kelompokTani = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanPetani,'$.KelompokTani'));
	SET @petani = JSON_UNQUOTE(JSON_EXTRACT(dataJabatanPetani,'$.Petani'));
		
	UPDATE jabatan_petani SET jabatan_petani.idJabatanBidang=@jabatanBidang, jabatan_petani.id_kelompok_tani=@kelompokTani, jabatan_petani.id_petani=@petani, jabatan_petani.updated_at=NOW()
	WHERE jabatan_petani.id_jabatan_petani=@idJabatanPetani;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_jenisKomoditas
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_jenisKomoditas`;
delimiter ;;
CREATE PROCEDURE `update_jenisKomoditas`(IN dataJenisKomoditas JSON)
BEGIN
	#Routine body goes here...
	SET @idJenisKomoditas = JSON_UNQUOTE(JSON_EXTRACT(dataJenisKomoditas,'$.IdJenisKomoditas'));
	SET @namaJenisKomoditas = JSON_UNQUOTE(JSON_EXTRACT(dataJeniskomoditas,'$.NamaJenisKomoditas'));
	
	UPDATE jenis_komoditas SET jenis_komoditas.nama_jenis_komoditas=@namaJenisKomoditas, jenis_komoditas.updated_at=NOW()
	WHERE jenis_komoditas.id_jenis_komoditas=@idJenisKomoditas;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_jenisLahan
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_jenisLahan`;
delimiter ;;
CREATE PROCEDURE `update_jenisLahan`(IN dataJenisLahan JSON)
BEGIN
	#Routine body goes here...
	
	SET @idJenisLahan = JSON_UNQUOTE(JSON_EXTRACT(dataJenisLahan,'$.IdJenisLahan'));
	SET @namaJenisLahan = JSON_UNQUOTE(JSON_EXTRACT(dataJenisLahan,'$.NamaJenisLahan'));
	
	UPDATE jenis_lahan SET jenis_lahan.nama_jenis_lahan=@namaJenisLahan, jenis_lahan.updated_at=NOW()
	WHERE jenis_lahan.id_jenis_lahan=@idJenisLahan;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_kecamatan
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_kecamatan`;
delimiter ;;
CREATE PROCEDURE `update_kecamatan`(IN dataKecamatan JSON)
BEGIN
	#Routine body goes here...
	SET @idKecamatan = JSON_UNQUOTE(JSON_EXTRACT(dataKecamatan,'$.IdKecamatan'));
	SET @kecamatan = JSON_UNQUOTE(JSON_EXTRACT(dataKecamatan,'$.Kecamatan'));
	
	UPDATE districts SET districts.dis_name=@kecamatan
	WHERE districts.dis_id=@idKecamatan;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_kelompokTani
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_kelompokTani`;
delimiter ;;
CREATE PROCEDURE `update_kelompokTani`(IN dataKelompokTani JSON)
BEGIN
	#Routine body goes here...
	SET @idKelompokTani = JSON_UNQUOTE(JSON_EXTRACT(dataKelompokTani,'$.IdKelompokTani'));
	SET @kelompokTani = JSON_UNQUOTE(JSON_EXTRACT(dataKelompokTani,'$.KelompokTani'));
	SET @alamat = JSON_UNQUOTE(JSON_EXTRACT(dataKelompokTani,'$.Alamat'));
	
	UPDATE kelompok_tani SET kelompok_tani.nama_kelompok_tani=@kelompokTani, kelompok_tani.alamat_sekretariat=@alamat,kelompok_tani.updated_at=NOW()
	WHERE kelompok_tani.id_kelompok_tani=@idKelompokTani;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_komoditas
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_komoditas`;
delimiter ;;
CREATE PROCEDURE `update_komoditas`(IN dataKomoditas JSON)
BEGIN
	#Routine body goes here...
	
	SET @idKomoditas = JSON_UNQUOTE(JSON_EXTRACT(dataKomoditas,'$.IdKomoditas'));
	SET @namaKomoditas = JSON_UNQUOTE(JSON_EXTRACT(dataKomoditas,'$.NamaKomoditas'));
	SET @jenisKomoditas = JSON_UNQUOTE(JSON_EXTRACT(dataKomoditas,'$.IdJenisKomoditas'));
	SET @estimasiPanen = JSON_UNQUOTE(JSON_EXTRACT(dataKomoditas,'$.EstimasiPanen'));
	
	UPDATE komoditas SET komoditas.nama_komoditas=@namaKomoditas, komoditas.id_jenis_komoditas=@jenisKomoditas, komoditas.estimasi_panen=@estimasiPanen, komoditas.updated_at=NOW()
	WHERE komoditas.id_komoditas=@idKomoditas;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_lahan
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_lahan`;
delimiter ;;
CREATE PROCEDURE `update_lahan`(IN dataLahan JSON)
BEGIN
	#Routine body goes here...
	
	SET @idLahan = JSON_UNQUOTE(JSON_EXTRACT(dataLahan,'$.IdLahan'));
	SET @namaLahan = JSON_UNQUOTE(JSON_EXTRACT(dataLahan,'$.NamaLahan'));
	SET @jenisLahan = JSON_UNQUOTE(JSON_EXTRACT(dataLahan,'$.IdJenisLahan'));
		
	UPDATE lahan SET lahan.nama_lahan=@namaLahan, lahan.id_jenis_lahan=@jenisLahan, lahan.updated_at=NOW()
	WHERE lahan.id_lahan=@idLahan;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_pegawai
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_pegawai`;
delimiter ;;
CREATE PROCEDURE `update_pegawai`(IN dataPegawai JSON)
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_pengguna
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_pengguna`;
delimiter ;;
CREATE PROCEDURE `update_pengguna`(IN `dataPengguna` JSON)
BEGIN
	#Routine body goes here...
	SET @idPengguna = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna,'$.IdPengguna'));
	SET @username = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna,'$.Username'));
	SET @email = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna,'$.Email'));
	SET @`password` = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna,'$.Password'));
	SET @role = JSON_UNQUOTE(JSON_EXTRACT(dataPengguna,'$.Role'));
	
	UPDATE `users` SET `users`.username=@username, `users`.email=@email, `users`.`password`=@`password`, `users`.role_id=@role, `users`.updated_at=NOW()
	WHERE `users`.user_id=@idPengguna;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_petani
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_petani`;
delimiter ;;
CREATE PROCEDURE `update_petani`(IN dataPetani JSON)
BEGIN
	#Routine body goes here...
	SET @idPetani = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.IdPetani'));
	SET @namaDepan = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.NamaDepan'));
	SET @namaBelakang = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.NamaBelakang'));
	SET @alamat = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.Alamat'));
	SET @kelompokTani = JSON_UNQUOTE(JSON_EXTRACT(dataPetani,'$.KelompokTani'));
	
	UPDATE petani SET petani.nama_depan=@namaDepan, petani.nama_belakang=@namaBelakang, petani.alamat_rumah=@alamat, petani.id_kelompok_tani=@kelompokTani, petani.updated_at=NOW()
	WHERE petani.id_petani=@idPetani;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_bidang
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_bidang`;
delimiter ;;
CREATE PROCEDURE `viewAll_bidang`()
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_dataPertanian
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_dataPertanian`;
delimiter ;;
CREATE PROCEDURE `viewAll_dataPertanian`()
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_departemen
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_departemen`;
delimiter ;;
CREATE PROCEDURE `viewAll_departemen`()
BEGIN
	#Routine body goes here...
SELECT * FROM departemen
		WHERE departemen.isDeleted = 0;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_desa
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_desa`;
delimiter ;;
CREATE PROCEDURE `viewAll_desa`()
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_golonganPangkat
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_golonganPangkat`;
delimiter ;;
CREATE PROCEDURE `viewAll_golonganPangkat`()
BEGIN#Routine body goes here...
	SELECT
		* 
	FROM
		golonganpangkat 
	WHERE
		golonganpangkat.isDeleted = 0;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_jabatan
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_jabatan`;
delimiter ;;
CREATE PROCEDURE `viewAll_jabatan`()
BEGIN
	#Routine body goes here...
SELECT * FROM jabatan
		WHERE jabatan.isDeleted = 0;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_jabatanBidang
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_jabatanBidang`;
delimiter ;;
CREATE PROCEDURE `viewAll_jabatanBidang`()
BEGIN
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
		jabatanbidang.idJabatan = jabatan.idJabatan
		WHERE jabatanbidang.isDeleted = 0;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_jabatanBidangPokTan
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_jabatanBidangPokTan`;
delimiter ;;
CREATE PROCEDURE `viewAll_jabatanBidangPokTan`()
BEGIN#Routine body goes here...
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
	WHERE
		jabatanbidang.id_bidang = 8 
			AND jabatanbidang.isDeleted = 0;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_jabatanPetani
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_jabatanPetani`;
delimiter ;;
CREATE PROCEDURE `viewAll_jabatanPetani`()
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_jenisKomoditas
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_jenisKomoditas`;
delimiter ;;
CREATE PROCEDURE `viewAll_jenisKomoditas`()
BEGIN#Routine body goes here...
	SELECT
		* 
	FROM
		jenis_komoditas 
	WHERE
		jenis_komoditas.is_deleted = 0;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_jenisLahan
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_jenisLahan`;
delimiter ;;
CREATE PROCEDURE `viewAll_jenisLahan`()
BEGIN
	#Routine body goes here...
SELECT * FROM jenis_lahan
		WHERE jenis_lahan.is_deleted = 0;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_kabupaten
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_kabupaten`;
delimiter ;;
CREATE PROCEDURE `viewAll_kabupaten`()
BEGIN
SELECT * FROM cities;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_kecamatan
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_kecamatan`;
delimiter ;;
CREATE PROCEDURE `viewAll_kecamatan`()
BEGIN
SELECT * FROM districts;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_kelompokTani
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_kelompokTani`;
delimiter ;;
CREATE PROCEDURE `viewAll_kelompokTani`()
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_kelompokTaniFull
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_kelompokTaniFull`;
delimiter ;;
CREATE PROCEDURE `viewAll_kelompokTaniFull`()
BEGIN#Routine body goes here...
	SELECT
		* 
	FROM
		kelompok_tani 
	WHERE
		kelompok_tani.is_deleted = 0;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_Komoditas
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_Komoditas`;
delimiter ;;
CREATE PROCEDURE `viewAll_Komoditas`()
BEGIN
	#Routine body goes here...
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
		komoditas.id_jenis_komoditas = jenis_komoditas.id_jenis_komoditas
		WHERE komoditas.is_deleted = 0;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_lahan
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_lahan`;
delimiter ;;
CREATE PROCEDURE `viewAll_lahan`()
BEGIN
	#Routine body goes here...
SELECT
	lahan.id_lahan,
	lahan.nama_lahan, 
	jenis_lahan.nama_jenis_lahan
FROM
	lahan
	INNER JOIN
	jenis_lahan
	ON 
		lahan.id_jenis_lahan = jenis_lahan.id_jenis_lahan
		WHERE lahan.is_deleted = 0;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_pegawai
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_pegawai`;
delimiter ;;
CREATE PROCEDURE `viewAll_pegawai`()
BEGIN#Routine body goes here...
SELECT
	pegawai.idPegawai, 
	pegawai.namaPegawai
FROM
	pegawai
	WHERE
		pegawai.isDeleted = 0;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_pegawaiFull
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_pegawaiFull`;
delimiter ;;
CREATE PROCEDURE `viewAll_pegawaiFull`()
BEGIN#Routine body goes here...
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
		INNER JOIN subdistricts ON pegawai.subdis_id = subdistricts.subdis_id
	WHERE
		pegawai.isDeleted = 0;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_Pengguna
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_Pengguna`;
delimiter ;;
CREATE PROCEDURE `viewAll_Pengguna`()
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_petani
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_petani`;
delimiter ;;
CREATE PROCEDURE `viewAll_petani`()
BEGIN#Routine body goes here...
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
		petani.id_kelompok_tani = kelompok_tani.id_kelompok_tani
	WHERE
		petani.is_deleted = 0;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_provinsi
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_provinsi`;
delimiter ;;
CREATE PROCEDURE `viewAll_provinsi`()
BEGIN
SELECT * FROM provinces;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for viewAll_role
-- ----------------------------
DROP PROCEDURE IF EXISTS `viewAll_role`;
delimiter ;;
CREATE PROCEDURE `viewAll_role`()
BEGIN
	#Routine body goes here...
SELECT
	user_roles.role_id, 
	user_roles.role_name
FROM
	user_roles;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_bidangById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_bidangById`;
delimiter ;;
CREATE PROCEDURE `view_bidangById`(IN id INT)
BEGIN
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
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_dataPertanianById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_dataPertanianById`;
delimiter ;;
CREATE PROCEDURE `view_dataPertanianById`(IN `id` int)
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_departemenById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_departemenById`;
delimiter ;;
CREATE PROCEDURE `view_departemenById`(IN id INT)
BEGIN
	SELECT
		* 
	FROM
		departemen
	WHERE
		departemen.idDepartemen = id;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_desaById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_desaById`;
delimiter ;;
CREATE PROCEDURE `view_desaById`(IN id INT)
BEGIN
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
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_golonganPangkatById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_golonganPangkatById`;
delimiter ;;
CREATE PROCEDURE `view_golonganPangkatById`(IN id INT)
BEGIN
	SELECT
		* 
	FROM
		golonganpangkat
	
	WHERE
		golonganpangkat.idGolonganPangkat = id;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_jabatanBidangById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_jabatanBidangById`;
delimiter ;;
CREATE PROCEDURE `view_jabatanBidangById`(IN id INT)
BEGIN
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
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_jabatanById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_jabatanById`;
delimiter ;;
CREATE PROCEDURE `view_jabatanById`(IN id INT)
BEGIN
	SELECT
		* 
	FROM
		jabatan
	WHERE
		jabatan.idJabatan = id;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_jabatanPetaniById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_jabatanPetaniById`;
delimiter ;;
CREATE PROCEDURE `view_jabatanPetaniById`(IN id INT)
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_jenisKomoditasById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_jenisKomoditasById`;
delimiter ;;
CREATE PROCEDURE `view_jenisKomoditasById`(IN `id` INT)
BEGIN
	SELECT
		* 
	FROM
		jenis_komoditas 
	WHERE
		jenis_komoditas.id_jenis_komoditas = id;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_jenisLahanById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_jenisLahanById`;
delimiter ;;
CREATE PROCEDURE `view_jenisLahanById`(IN id INT)
BEGIN
	SELECT
		* 
	FROM
		jenis_lahan 
	WHERE
		jenis_lahan.id_jenis_lahan = id;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_kecamatanById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_kecamatanById`;
delimiter ;;
CREATE PROCEDURE `view_kecamatanById`(IN id INT)
BEGIN
	SELECT
		* 
	FROM
		districts 
	WHERE
		districts.dis_id = id;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_kelompokTaniById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_kelompokTaniById`;
delimiter ;;
CREATE PROCEDURE `view_kelompokTaniById`(IN id INT)
BEGIN
	SELECT
		* 
	FROM
		kelompok_tani	
	WHERE
		kelompok_tani.id_kelompok_tani = id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_komoditasById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_komoditasById`;
delimiter ;;
CREATE PROCEDURE `view_komoditasById`(IN id INT)
BEGIN
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
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_lahanById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_lahanById`;
delimiter ;;
CREATE PROCEDURE `view_lahanById`(IN id INT)
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_pegawaiById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_pegawaiById`;
delimiter ;;
CREATE PROCEDURE `view_pegawaiById`(IN id INT)
BEGIN
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
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_penggunaById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_penggunaById`;
delimiter ;;
CREATE PROCEDURE `view_penggunaById`(IN `id` int)
BEGIN
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
	END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for view_petaniById
-- ----------------------------
DROP PROCEDURE IF EXISTS `view_petaniById`;
delimiter ;;
CREATE PROCEDURE `view_petaniById`(IN id INT)
BEGIN
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
	
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
