<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index()
    {
        return view('user/index');
    }
    public function tentang()
    {
        return view('user/tentang');
    }
    public function komoditas_kecamatan()
    {
        return view('user/komoditas_kecamatan');
    }
    public function persebaran_komoditas()
    {
        return view('user/persebaran_komoditas');
    }
}
