<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PenyuluhController extends Controller
{
    public function penyuluh()
    {
        return view('penyuluh/index');
    }
    public function data_pertanian()
    {
        return view('penyuluh/data/index');
    }
}
