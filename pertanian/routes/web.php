<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\PenyuluhController;


Route::get('/login', [AuthController::class, 'showLoginForm'])->name('login.form');
Route::post('/proses-login', [AuthController::class, 'proses_login'])->name('login.process');
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');


Route::middleware(['Role:Admin'])->group(function () {
    //  ------------------- Admin Utama ------------------------------------
    Route::get('/admin-dashboard', [AdminController::class, 'admin'])->name('admin.dashboard');

    // -- Pengguna --
    Route::get('/admin-pengguna', [AdminController::class, 'pengguna'])->name('pengguna.index');
    Route::post('/tambah-pengguna', [AdminController::class, 'create_pengguna']);

    // -- Jenis Komoditas ---
    Route::get('/jenis-komoditas', [AdminController::class, 'jenis_komoditas'])->name('jenisKomoditas.index');
    Route::post('/tambah-jenis-komoditas', [AdminController::class, 'create_jenisKomoditas']);
    
    Route::get('/komoditas', [AdminController::class, 'komoditas'])->name('komoditas.index');
    Route::post('/tambah-komoditas', [AdminController::class, 'create_komoditas']);
   
    Route::get('/jenis-lahan', [AdminController::class, 'jenis_lahan'])->name('jenisLahan.index');
    Route::post('/tambah-jenis-lahan', [AdminController::class, 'create_jenisLahan']);
    
    Route::get('/lahan', [AdminController::class, 'lahan'])->name('lahan.index');
    Route::post('/tambah-lahan', [AdminController::class, 'create_lahan']);
    
    Route::get('/departemen', [AdminController::class, 'departemen']);
    Route::get('/bidang', [AdminController::class, 'bidang']);
    Route::get('/jabatan', [AdminController::class, 'jabatan']);
    Route::get('/jabatan-bidang', [AdminController::class, 'jabatan_bidang']);
    Route::get('/golongan-pangkat', [AdminController::class, 'golongan_pangkat']);
    Route::get('/pegawai', [AdminController::class, 'pegawai']);
    Route::get('/jabatan-petani', [AdminController::class, 'jabatan_petani']);



    Route::get('/provinsi', [AdminController::class, 'provinsi']);
    Route::get('/kabupaten', [AdminController::class, 'kabupaten']);
    Route::get('/kecamatan', [AdminController::class, 'kecamatan']);
    Route::get('/desa', [AdminController::class, 'desa']);
    
    Route::get('/kelompok-tani', [AdminController::class, 'kelompok_tani'])->name('kelompokTani.index');
    Route::post('/tambah-kelompok-tani', [AdminController::class, 'create_kelompok_tani']);
    
    Route::get('/petani', [AdminController::class, 'petani'])->name('petani.index');
    Route::post('/tambah-petani', [AdminController::class, 'create_petani']);
});
// -------------- PENYULUH ----------------
Route::middleware(['Role:Penyuluh'])->group(function () {

    Route::get('/penyuluh-dashboard', [PenyuluhController::class, 'penyuluh'])->name('penyuluh.dashboard');
    Route::get('/data-pertanian', [PenyuluhController::class, 'data_pertanian'])->name('dataPertanian.index');
    Route::post('/tambah-data-pertanian', [PenyuluhController::class, 'create_data_pertanian']);
    Route::get('/data-pertanian/edit/{id}', [PenyuluhController::class, 'edit'])->name('dataPertanian.edit');
});





Route::get('/', function () {
    return redirect('/admin-dashboard'); // Ganti dengan route tujuan
});
