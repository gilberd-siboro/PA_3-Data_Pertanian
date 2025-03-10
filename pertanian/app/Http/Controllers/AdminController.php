<?php

namespace App\Http\Controllers;

use App\Models\Bidang;
use App\Models\Cities;
use App\Models\Departemen;
use App\Models\Districts;
use App\Models\GolonganPangkat;
use App\Models\Jabatan;
use App\Models\JabatanBidang;
use App\Models\JabatanPetani;
use App\Models\JenisKomoditas;
use App\Models\JenisLahan;
use App\Models\KelompokTani;
use App\Models\Komoditas;
use App\Models\Lahan;
use App\Models\Pegawai;
use App\Models\Petani;
use App\Models\Provinces;
use App\Models\SubDistricts;
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
        $data = JenisKomoditas::all();
        $totalData = $data->count();
        return view('admin/jenis_komoditas/index', compact('data', 'totalData'));
    }
    public function komoditas()
    {
        $data = Komoditas::all();
        $totalData = $data->count();
        return view('admin/komoditas/index', compact('data', 'totalData'));
    }
    public function jenis_lahan()
    {
        $data = JenisLahan::all();
        $totalData = $data->count();
        return view('admin/jenis_lahan/index', compact('data', 'totalData'));
    }
    public function lahan()
    {
        $data = Lahan::all();
        $totalData = $data->count();
        return view('admin/lahan/index', compact('data', 'totalData'));
    }
    public function departemen()
    {
        $data = Departemen::all();
        $totalData = $data->count();
        return view('admin/departemen/index', compact('data', 'totalData'));
    }
    public function bidang()
    {
        $data = Bidang::all();
        $totalData = $data->count();
        return view('admin/bidang/index', compact('data', 'totalData'));
    }
    public function jabatan()
    {
        $data = Jabatan::all();
        $totalData = $data->count();
        return view('admin/jabatan/index', compact('data', 'totalData'));
    }
    public function jabatan_bidang()
    {
        $data = JabatanBidang::all();
        $totalData = $data->count();
        return view('admin/jabatan_bidang/index', compact('data', 'totalData'));
    }
    public function golongan_pangkat()
    {
        $data = GolonganPangkat::all();
        $totalData = $data->count();
        return view('admin/golongan_pangkat/index', compact('data', 'totalData'));
    }
    public function pegawai()
    {
        $data = Pegawai::all();
        $totalData = $data->count();
        return view('admin/pegawai/index', compact('data', 'totalData'));
    }
    public function jabatan_petani()
    {
        $data = JabatanPetani::all();
        $totalData = $data->count();
        return view('admin/jabatan_petani/index', compact('data', 'totalData'));
    }


    //  -------------------------- HALAMAN --------------------------------

    public function provinsi()
    {
        $data = Provinces::all();
        $totalData = $data->count();
        return view('admin/provinsi/index', compact('data', 'totalData'));
    }
    public function kabupaten()
    {
        $data = Cities::all();
        $totalData = $data->count();
        return view('admin/kabupaten/index', compact('data', 'totalData'));
    }
    public function kecamatan()
    {
        $data = Districts::all();
        $totalData = $data->count();
        return view('admin/kecamatan/index', compact('data', 'totalData'));
    }
    public function desa()
    {
        $data = SubDistricts::all();
        $totalData = $data->count();
        return view('admin/desa/index', compact('data', 'totalData'));
    }
    public function kelompok_tani()
    {
        $data = KelompokTani::all();
        $totalData = $data->count();
        return view('admin/kelompok_tani/index', compact('data', 'totalData'));
    }
    public function petani()
    {
        $data = Petani::all();
        $totalData = $data->count();
        return view('admin/petani/index', compact('data', 'totalData'));
    }
}
