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

    // -- Komoditas --
    Route::get('/komoditas', [AdminController::class, 'komoditas'])->name('komoditas.index');
    Route::post('/tambah-komoditas', [AdminController::class, 'create_komoditas']);
    Route::get('/komoditas/edit/{id}', [AdminController::class, 'edit_komoditas'])->name('komoditas.edit');
    Route::post('/komoditas/update/{id}', [AdminController::class, 'update_komoditas'])->name('komoditas.update');
   
    // -- Jenis Lahan--
    Route::get('/jenis-lahan', [AdminController::class, 'jenis_lahan'])->name('jenisLahan.index');
    Route::post('/tambah-jenis-lahan', [AdminController::class, 'create_jenisLahan']);
    
    // -- Lahan --
    Route::get('/lahan', [AdminController::class, 'lahan'])->name('lahan.index');
    Route::post('/tambah-lahan', [AdminController::class, 'create_lahan']);
    
    // -- Departemen --
    Route::get('/departemen', [AdminController::class, 'departemen'])->name('departemen.index');
    Route::post('/tambah-departemen', [AdminController::class, 'create_departemen']);
    
    // -- Bidang --
    Route::get('/bidang', [AdminController::class, 'bidang'])->name('bidang.index');
    Route::post('/tambah-bidang', [AdminController::class, 'create_bidang']);
    
    // -- Jabatan --
    Route::get('/jabatan', [AdminController::class, 'jabatan'])->name('jabatan.index');
    Route::post('/tambah-jabatan', [AdminController::class, 'create_jabatan']);
    
    // -- Jabatan Bidang --
    Route::get('/jabatan-bidang', [AdminController::class, 'jabatan_bidang'])->name('jabatanBidang.index');
    Route::post('/tambah-jabatan-bidang', [AdminController::class, 'create_jabatanBidang']);
    
    // -- Golongan Pangkat --
    Route::get('/golongan-pangkat', [AdminController::class, 'golongan_pangkat'])->name('golonganPangkat.index');
    Route::post('/tambah-golongan-pangkat', [AdminController::class, 'create_golonganPangkat']);
    
    // -- Pegawai --
    Route::get('/pegawai', [AdminController::class, 'pegawai'])->name('pegawai.index');
    Route::post('/tambah-pegawai', [AdminController::class, 'create_pegawai']);
    
    // -- Jabatan Petani --
    Route::get('/jabatan-petani', [AdminController::class, 'jabatan_petani'])->name('jabatanPetani.index');
    Route::post('/tambah-jabatan-petani', [AdminController::class, 'create_jabatanPetani']);

    // -- Kecamatan --
    Route::get('/kecamatan', [AdminController::class, 'kecamatan'])->name('kecamatan.index');
    Route::post('/tambah-kecamatan', [AdminController::class, 'create_kecamatan']);

    // -- Desa --
    Route::get('/desa', [AdminController::class, 'desa'])->name('desa.index');
    Route::post('/tambah-desa', [AdminController::class, 'create_desa']);
    
    // -- Kelompok Tani --
    Route::get('/kelompok-tani', [AdminController::class, 'kelompok_tani'])->name('kelompokTani.index');
    Route::post('/tambah-kelompok-tani', [AdminController::class, 'create_kelompok_tani']);
    
    // -- Petani --
    Route::get('/petani', [AdminController::class, 'petani'])->name('petani.index');
    Route::post('/tambah-petani', [AdminController::class, 'create_petani']);
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






