<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class AdminController extends Controller
{

    //  --------------------- MENU -----------------------------
    public function admin()
    {
        $userData = session('userData');

        return view('admin/index', compact('userData'));
    }


    public function pengguna()
    {
        $userData = session('userData');
        $pengguna = DB::select('CALL viewAll_Pengguna()');
        $pegawai = DB::select('CALL viewAll_pegawai()');
        $role = DB::select('CALL viewAll_role()');

        return view('admin/pengguna/index', compact('userData', 'pengguna', 'pegawai', 'role'));
    }

    public function create_pengguna(Request $request)
    {
        $Pengguna = json_encode([
            'Username' => $request->get('username'),
            'Email' => $request->get('email'),
            'Password'  => bcrypt($request->get('password')),
            'Role'  => $request->get('role'),
            'Pegawai'  => $request->get('pegawai')
        ]);

        $response = DB::statement('CALL insert_pengguna(:dataPengguna)', ['dataPengguna' => $Pengguna]);

        if ($response) {
            toast('Pengguna berhasil ditambahkan!', 'success')->autoClose(3000); // Auto close dalam 3 detik
            return redirect()->route('pengguna.index');
        } else {
            toast('Pengguna gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('pengguna.index');
        }
    }

    // Jenis komoditas

    public function jenis_komoditas()
    {
        $userData = session('userData');
        $jenisKomoditas = DB::select('CALL viewAll_jenisKomoditas()');
        return view('admin/jenis_komoditas/index', compact('userData','jenisKomoditas'));
    }

    public function create_jenisKomoditas(Request $request)
    {
        $JenisKomoditas = json_encode([
            'JenisKomoditas' => $request->get('nama_jenis'),
        ]);

        $response = DB::statement('CALL insert_jenisKomoditas(:dataJenisKomoditas)', ['dataJenisKomoditas' => $JenisKomoditas]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('jenisKomoditas.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('jenisKomoditas.index');
        }
    }

    public function komoditas()
    {
        $userData = session('userData');
        $komoditas = DB::select('CALL viewAll_Komoditas()');

        return view('admin/komoditas/index', compact('userData','komoditas'));
    }
    public function jenis_lahan()
    {
        $userData = session('userData');
        $jenisLahan = DB::select('CALL viewAll_jenisLahan()');

        return view('admin/jenis_lahan/index', compact('userData','jenisLahan'));
    }
    public function lahan()
    {
        $userData = session('userData');
        $lahan = DB::select('CALL viewAll_lahan()');

        return view('admin/lahan/index', compact('userData','lahan'));
    }
    public function departemen()
    {
        $userData = session('userData');
        $departemen = DB::select('CALL viewAll_departemen()');

        return view('admin/departemen/index', compact('userData','departemen'));
    }
    public function bidang()
    {
        $userData = session('userData');
        $bidang = DB::select('CALL viewAll_bidang()');

        return view('admin/bidang/index', compact('userData','bidang'));
    }
    public function jabatan()
    {
        $userData = session('userData');
        $jabatan = DB::select('CALL viewAll_jabatan()');

        return view('admin/jabatan/index', compact('userData','jabatan'));
    }
    public function jabatan_bidang()
    {
        $userData = session('userData');
        $jabatanBidang = DB::select('CALL viewAll_jabatanBidang()');

        return view('admin/jabatan_bidang/index', compact('userData','jabatanBidang'));
    }
    public function golongan_pangkat()
    {
        $userData = session('userData');
        $golonganPangkat = DB::select('CALL viewAll_golonganPangkat()');

        return view('admin/golongan_pangkat/index', compact('userData','golonganPangkat'));
    }
    public function pegawai()
    {
        $userData = session('userData');
        $pegawai = DB::select('CALL viewAll_pegawaiFull()');
        return view('admin/pegawai/index', compact('userData','pegawai'));
    }
    public function jabatan_petani()
    {
        $userData = session('userData');
        $jabatanPetani = DB::select('CALL viewAll_jabatanPetani()');

        return view('admin/jabatan_petani/index', compact('userData','jabatanPetani'));
    }


    //  -------------------------- HALAMAN --------------------------------

    public function provinsi()
    {
        $userData = session('userData');
        $provinsi = DB::select('CALL viewAll_provinsi()');

        return view('admin/provinsi/index', compact('userData','provinsi'));
    }
    public function kabupaten()
    {
        $userData = session('userData');
        $kabupaten = DB::select('CALL viewAll_kabupaten()');

        return view('admin/kabupaten/index', compact('userData','kabupaten'));
    }
    public function kecamatan()
    {
        $userData = session('userData');
        $kecamatan = DB::select('CALL viewAll_kecamatan()');

        return view('admin/kecamatan/index', compact('userData','kecamatan'));
    }
    public function desa()
    {
        $userData = session('userData');
        $desa = DB::select('CALL viewAll_desa()');

        return view('admin/desa/index', compact('userData','desa'));
    }
    public function kelompok_tani()
    {
        $userData = session('userData');
        $kelompokTani = DB::select('CALL viewAll_kelompokTani()');

        return view('admin/kelompok_tani/index', compact('userData','kelompokTani'));
    }
    public function petani()
    {
        $userData = session('userData');
        $petani = DB::select('CALL viewAll_petani()');

        return view('admin/petani/index', compact('userData','petani'));
    }
}
