<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminController;


Route::get('/', [AdminController::class, 'admin'])->name('admin');
