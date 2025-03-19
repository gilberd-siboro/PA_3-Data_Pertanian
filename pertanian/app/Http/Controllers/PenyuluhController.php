<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PenyuluhController extends Controller
{
    public function penyuluh()
    {
        $userData = session('userData');
        return view('penyuluh/index', compact('userData'));
    }
    public function data_pertanian()
    {
        return view('penyuluh/data/index');
    }
}
