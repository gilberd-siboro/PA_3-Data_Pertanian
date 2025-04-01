<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\PenyuluhController;
use App\Http\Controllers\UserController;


// ----------- USER -----------

Route::get('/', [UserController::class, 'index']);
Route::get('/tentang', [UserController::class, 'tentang']);
Route::get('/komoditas-kecamatan', [UserController::class, 'komoditas_kecamatan']);
Route::get('/persebaran-komoditas', [UserController::class, 'persebaran_komoditas']);


Route::get('/login', [AuthController::class, 'showLoginForm'])->name('login.form');
Route::post('/proses-login', [AuthController::class, 'proses_login'])->name('login.process');
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');



Route::middleware(['Role:Admin'])->group(function () {
    //  ------------------- Admin Utama ------------------------------------
    Route::get('/admin-dashboard', [AdminController::class, 'admin'])->name('admin.dashboard');

    // -- Pengguna --
    Route::get('/admin-pengguna', [AdminController::class, 'pengguna'])->name('pengguna.index');
    Route::post('/tambah-pengguna', [AdminController::class, 'create_pengguna']);
    Route::get('/admin-pengguna/edit/{id}', [AdminController::class, 'edit_pengguna'])->name('pengguna.edit');
    Route::post('/admin-pengguna/update/{id}', [AdminController::class, 'update_pengguna'])->name('pengguna.update');
    Route::post('/admin-pengguna/delete/{id}', [AdminController::class, 'delete_pengguna'])->name('pengguna.delete');

    // -- Data Pertanian
    Route::get('/admin-data-pertanian', [AdminController::class, 'data_pertanian'])->name('AdmindataPertanian.index');
    Route::post('/admin-tambah-data-pertanian', [AdminController::class, 'create_data_pertanian']);
    Route::get('/admin-data-pertanian/edit/{id}', [AdminController::class, 'edit'])->name('AdmindataPertanian.edit');
    Route::post('/admin-data-pertanian/update/{id}', [AdminController::class, 'update'])->name('AdmindataPertanian.update');
    Route::post('/admin-data-pertanian/delete/{id}', [AdminController::class, 'delete'])->name('AdmindataPertanian.delete');

    // -- Jenis Komoditas --
    Route::get('/jenis-komoditas', [AdminController::class, 'jenis_komoditas'])->name('jenisKomoditas.index');
    Route::post('/tambah-jenis-komoditas', [AdminController::class, 'create_jenisKomoditas']);
    Route::get('/jenis-komoditas/edit/{id}', [AdminController::class, 'edit_jenisKomoditas'])->name('jenisKomoditas.edit');
    Route::post('/jenis-komoditas/update/{id}', [AdminController::class, 'update_jenisKomoditas'])->name('jenisKomoditas.update');
    Route::post('/jenis-komoditas/delete/{id}', [AdminController::class, 'delete_jenisKomoditas'])->name('jenisKomoditas.delete');

    // -- Komoditas --
    Route::get('/komoditas', [AdminController::class, 'komoditas'])->name('komoditas.index');
    Route::post('/tambah-komoditas', [AdminController::class, 'create_komoditas']);
    Route::get('/komoditas/edit/{id}', [AdminController::class, 'edit_komoditas'])->name('komoditas.edit');
    Route::post('/komoditas/update/{id}', [AdminController::class, 'update_komoditas'])->name('komoditas.update');
    Route::post('/komoditas/delete/{id}', [AdminController::class, 'delete_komoditas'])->name('komoditas.delete');
   
    // -- Jenis Lahan--
    Route::get('/jenis-lahan', [AdminController::class, 'jenis_lahan'])->name('jenisLahan.index');
    Route::post('/tambah-jenis-lahan', [AdminController::class, 'create_jenisLahan']);
    Route::get('/jenis-lahan/edit/{id}', [AdminController::class, 'edit_jenisLahan'])->name('jenisLahan.edit');
    Route::post('/jenis-lahan/update/{id}', [AdminController::class, 'update_jenisLahan'])->name('jenisLahan.update');
    Route::post('/jenis-lahan/delete/{id}', [AdminController::class, 'delete_jenisLahan'])->name('jenisLahan.delete');
    
    // -- Lahan --
    Route::get('/lahan', [AdminController::class, 'lahan'])->name('lahan.index');
    Route::post('/tambah-lahan', [AdminController::class, 'create_lahan']);
    Route::get('/lahan/edit/{id}', [AdminController::class, 'edit_lahan'])->name('lahan.edit');
    Route::post('/lahan/update/{id}', [AdminController::class, 'update_lahan'])->name('lahan.update');
    Route::post('/lahan/delete/{id}', [AdminController::class, 'delete_lahan'])->name('lahan.delete');
    
    // -- Departemen --
    Route::get('/departemen', [AdminController::class, 'departemen'])->name('departemen.index');
    Route::post('/tambah-departemen', [AdminController::class, 'create_departemen']);
    Route::get('/departemen/edit/{id}', [AdminController::class, 'edit_departemen'])->name('departemen.edit');
    Route::post('/departemen/update/{id}', [AdminController::class, 'update_departemen'])->name('departemen.update');
    Route::post('/departemen/delete/{id}', [AdminController::class, 'delete_departemen'])->name('departemen.delete');
    
    // -- Bidang --
    Route::get('/bidang', [AdminController::class, 'bidang'])->name('bidang.index');
    Route::post('/tambah-bidang', [AdminController::class, 'create_bidang']);
    Route::get('/bidang/edit/{id}', [AdminController::class, 'edit_bidang'])->name('bidang.edit');
    Route::post('/bidang/update/{id}', [AdminController::class, 'update_bidang'])->name('bidang.update');
    Route::post('/bidang/delete/{id}', [AdminController::class, 'delete_bidang'])->name('bidang.delete');
    
    // -- Jabatan --
    Route::get('/jabatan', [AdminController::class, 'jabatan'])->name('jabatan.index');
    Route::post('/tambah-jabatan', [AdminController::class, 'create_jabatan']);
    Route::get('/jabatan/edit/{id}', [AdminController::class, 'edit_jabatan'])->name('jabatan.edit');
    Route::post('/jabatan/update/{id}', [AdminController::class, 'update_jabatan'])->name('jabatan.update');
    Route::post('/jabatan/delete/{id}', [AdminController::class, 'delete_jabatan'])->name('jabatan.delete');
    
    // -- Jabatan Bidang --
    Route::get('/jabatan-bidang', [AdminController::class, 'jabatan_bidang'])->name('jabatanBidang.index');
    Route::post('/tambah-jabatan-bidang', [AdminController::class, 'create_jabatanBidang']);
    Route::get('/jabatan-bidang/edit/{id}', [AdminController::class, 'edit_jabatanBidang'])->name('jabatanBidang.edit');
    Route::post('/jabatan-bidang/update/{id}', [AdminController::class, 'update_jabatanBidang'])->name('jabatanBidang.update');
    Route::post('/jabatan-bidang/delete/{id}', [AdminController::class, 'delete_jabatanBidang'])->name('jabatanBidang.delete');
    
    // -- Golongan Pangkat --
    Route::get('/golongan-pangkat', [AdminController::class, 'golongan_pangkat'])->name('golonganPangkat.index');
    Route::post('/tambah-golongan-pangkat', [AdminController::class, 'create_golonganPangkat']);
    Route::get('/golongan-pangkat/edit/{id}', [AdminController::class, 'edit_golonganPangkat'])->name('golonganPangkat.edit');
    Route::post('/golongan-pangkat/update/{id}', [AdminController::class, 'update_golonganPangkat'])->name('golonganPangkat.update');
    Route::post('/golongan-pangkat/delete/{id}', [AdminController::class, 'delete_golonganPangkat'])->name('golonganPangkat.delete');
    
    // -- Pegawai --
    Route::get('/pegawai', [AdminController::class, 'pegawai'])->name('pegawai.index');
    Route::post('/tambah-pegawai', [AdminController::class, 'create_pegawai']);
    Route::get('/pegawai/edit/{id}', [AdminController::class, 'edit_pegawai'])->name('pegawai.edit');
    Route::post('/pegawai/update/{id}', [AdminController::class, 'update_pegawai'])->name('pegawai.update');
    Route::post('/pegawai/delete/{id}', [AdminController::class, 'delete_pegawai'])->name('pegawai.delete');
    
    // -- Jabatan Petani --
    Route::get('/jabatan-petani', [AdminController::class, 'jabatan_petani'])->name('jabatanPetani.index');
    Route::post('/tambah-jabatan-petani', [AdminController::class, 'create_jabatanPetani']);
    Route::get('/jabatan-petani/edit/{id}', [AdminController::class, 'edit_jabatanPetani'])->name('jabatanPetani.edit');
    Route::post('/jabatan-petani/update/{id}', [AdminController::class, 'update_jabatanPetani'])->name('jabatanPetani.update');

    // -- Kecamatan --
    Route::get('/kecamatan', [AdminController::class, 'kecamatan'])->name('kecamatan.index');
    Route::post('/tambah-kecamatan', [AdminController::class, 'create_kecamatan']);
    Route::get('/kecamatan/edit/{id}', [AdminController::class, 'edit_kecamatan'])->name('kecamatan.edit');
    Route::post('/kecamatan/update/{id}', [AdminController::class, 'update_kecamatan'])->name('kecamatan.update');

    // -- Desa --
    Route::get('/desa', [AdminController::class, 'desa'])->name('desa.index');
    Route::post('/tambah-desa', [AdminController::class, 'create_desa']);
    Route::get('/desa/edit/{id}', [AdminController::class, 'edit_desa'])->name('desa.edit');
    Route::post('/desa/update/{id}', [AdminController::class, 'update_desa'])->name('desa.update');
    
    // -- Kelompok Tani --
    Route::get('/kelompok-tani', [AdminController::class, 'kelompok_tani'])->name('kelompokTani.index');
    Route::post('/tambah-kelompok-tani', [AdminController::class, 'create_kelompok_tani']);
    Route::get('/kelompok-tani/edit/{id}', [AdminController::class, 'edit_kelompok_tani'])->name('kelompokTani.edit');
    Route::post('/kelompok-tani/update/{id}', [AdminController::class, 'update_kelompok_tani'])->name('kelompokTani.update');
    Route::post('/kelompok-tani/delete/{id}', [AdminController::class, 'delete_kelompok_tani'])->name('kelompokTani.delete');
    
    // -- Petani --
    Route::get('/petani', [AdminController::class, 'petani'])->name('petani.index');
    Route::post('/tambah-petani', [AdminController::class, 'create_petani']);
    Route::get('/petani/edit/{id}', [AdminController::class, 'edit_petani'])->name('petani.edit');
    Route::post('/petani/update/{id}', [AdminController::class, 'update_petani'])->name('petani.update');
    Route::post('/petani/delete/{id}', [AdminController::class, 'delete_petani'])->name('petani.delete');
});


// -------------- PENYULUH ----------------
Route::middleware(['Role:Penyuluh'])->group(function () {

    Route::get('/penyuluh-dashboard', [PenyuluhController::class, 'penyuluh'])->name('penyuluh.dashboard');
    
    // -- Data Pertanian --
    Route::get('/data-pertanian', [PenyuluhController::class, 'data_pertanian'])->name('dataPertanian.index');
    Route::post('/tambah-data-pertanian', [PenyuluhController::class, 'create_data_pertanian']);
    Route::get('/data-pertanian/edit/{id}', [PenyuluhController::class, 'edit'])->name('dataPertanian.edit');
    Route::post('/data-pertanian/update/{id}', [PenyuluhController::class, 'update'])->name('dataPertanian.update');
    Route::post('/data-pertanian/delete/{id}', [PenyuluhController::class, 'delete'])->name('dataPertanian.delete');
});






