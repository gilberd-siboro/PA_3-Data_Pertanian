<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminController;


Route::get('/admin-dashboard', [AdminController::class, 'admin'])->name('admin');
Route::get('/jenis-komoditas', [AdminController::class, 'jenis_komoditas']);
Route::get('/komoditas', [AdminController::class, 'komoditas']);
Route::get('/jenis-lahan', [AdminController::class, 'jenis_lahan']);
Route::get('/lahan', [AdminController::class, 'lahan']);
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
Route::get('/kelompok-tani', [AdminController::class, 'kelompok_tani']);
Route::get('/petani', [AdminController::class, 'petani']);
