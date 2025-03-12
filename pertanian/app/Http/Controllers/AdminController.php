<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;

class AdminController extends Controller
{

    //  --------------------- MENU -----------------------------

    public function admin()
    {
        return view('admin/index');
    }

    public function jenis_komoditas()
    {
        return view('admin/jenis_komoditas/index');
    }
    public function komoditas()
    {

        return view('admin/komoditas/index');
    }
    public function jenis_lahan()
    {

        return view('admin/jenis_lahan/index');
    }
    public function lahan()
    {
        return view('admin/lahan/index');
    }
    public function departemen()
    {

        return view('admin/departemen/index');
    }
    public function bidang()
    {

        return view('admin/bidang/index');
    }
    public function jabatan()
    {

        return view('admin/jabatan/index');
    }
    public function jabatan_bidang()
    {
        return view('admin/jabatan_bidang/index');
    }
    public function golongan_pangkat()
    {
        return view('admin/golongan_pangkat/index');
    }
    public function pegawai()
    {
        return view('admin/pegawai/index');
    }
    public function jabatan_petani()
    {
        return view('admin/jabatan_petani/index');
    }


    //  -------------------------- HALAMAN --------------------------------

    public function provinsi()
    {
        return view('admin/provinsi/index');
    }
    public function kabupaten()
    {
        return view('admin/kabupaten/index');
    }
    public function kecamatan()
    {
        return view('admin/kecamatan/index');
    }
    public function desa()
    {
        return view('admin/desa/index');
    }
    public function kelompok_tani()
    {
        return view('admin/kelompok_tani/index');
    }
    public function petani()
    {
        return view('admin/petani/index');
    }
}
