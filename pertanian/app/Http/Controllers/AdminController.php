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
        $userData = session('userData');
        $petani = DB::select('CALL viewAll_petani()');
        $totalPetani = count($petani);
        $kelompokTani = DB::select('CALL viewAll_kelompokTani()');
        $totalKel = count($kelompokTani);
        $komoditas = DB::select('CALL viewAll_Komoditas()');
        $totalKom = count($komoditas);

        return view('admin/index',  compact('userData', 'totalPetani', 'totalKel', 'totalKom'));
    }

    // ------ PENGGUNA -------

    public function pengguna()
    {
        $userData = session('userData');
        $pengguna = DB::select('CALL viewAll_Pengguna()');
        $pegawai = DB::select('CALL viewAll_pegawai()');
        $role = DB::select('CALL viewAll_role()');

        return view('admin/pengguna/index', compact('userData', 'pengguna', 'pegawai', 'role'));
    }

    public function edit_pengguna($id)
    {
        $userData = session('userData');
        $penggunaData = DB::select('CALL view_penggunaById(' . $id . ')');
        $pengguna = $penggunaData[0];
        $role = DB::select('CALL viewAll_role()');

        return view('admin/pengguna/edit', compact('userData', 'pengguna', 'role'));
    }
    // public function update_pengguna(Request $request, $id)
    // {
    //     $DataPengguna
    //     return view('admin/pengguna/edit', compact('userData', 'pengguna', 'role'));
    // }


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

    // ------ JENIS KOMODITAS -------

    public function jenis_komoditas()
    {
        $userData = session('userData');
        $jenisKomoditas = DB::select('CALL viewAll_jenisKomoditas()');
        return view('admin/jenis_komoditas/index', compact('userData', 'jenisKomoditas'));
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

    // ------ KOMODITAS -------

    public function komoditas()
    {
        $userData = session('userData');
        $komoditas = DB::select('CALL viewAll_Komoditas()');
        $jenisKomoditas = DB::select('CALL viewAll_jenisKomoditas()');

        return view('admin/komoditas/index', compact('userData', 'komoditas', 'jenisKomoditas'));
    }

    public function create_komoditas(Request $request)
    {
        $Komoditas = json_encode([
            'JenisKomoditas' => $request->get('id_jenis_komoditas'),
            'NamaKomoditas' => $request->get('nama_komoditas'),
            'EstimasiPanen' => $request->get('estimasi_panen'),
        ]);

        $response = DB::statement('CALL insert_komoditas(:dataKomoditas)', ['dataKomoditas' => $Komoditas]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('komoditas.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('komoditas.index');
        }
    }

    // ------ JENIS LAHAN -------

    public function jenis_lahan()
    {
        $userData = session('userData');
        $jenisLahan = DB::select('CALL viewAll_jenisLahan()');

        return view('admin/jenis_lahan/index', compact('userData', 'jenisLahan'));
    }

    public function create_jenisLahan(Request $request)
    {
        $JenisLahan = json_encode([
            'JenisLahan' => $request->get('jenis_lahan'),
        ]);

        $response = DB::statement('CALL insert_jenisLahan(:dataJenisLahan)', ['dataJenisLahan' => $JenisLahan]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('jenisLahan.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('jenisLahan.index');
        }
    }

    // ------ LAHAN -------

    public function lahan()
    {
        $userData = session('userData');
        $lahan = DB::select('CALL viewAll_lahan()');
        $jenisLahan = DB::select('CALL viewAll_jenisLahan()');

        return view('admin/lahan/index', compact('userData', 'lahan', 'jenisLahan'));
    }

    public function create_lahan(Request $request)
    {
        $Lahan = json_encode([
            'JenisLahan' => $request->get('id_jenis_lahan'),
            'Lahan' => $request->get('lahan'),

        ]);

        $response = DB::statement('CALL insert_lahan(:dataLahan)', ['dataLahan' => $Lahan]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('lahan.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('lahan.index');
        }
    }

    // ------ DEPARTEMEN -------


    public function departemen()
    {
        $userData = session('userData');
        $departemen = DB::select('CALL viewAll_departemen()');

        return view('admin/departemen/index', compact('userData', 'departemen'));
    }

    public function create_departemen(Request $request)
    {
        $Departemen = json_encode([
            'NamaDepartmen' => $request->get('departemen'),
            'Keterangan' => $request->get('keterangan'),

        ]);

        $response = DB::statement('CALL insert_departmen(:dataDepartmen)', ['dataDepartmen' => $Departemen]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('departemen.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('departemen.index');
        }
    }

    // ------ BIDANG -------

    public function bidang()
    {
        $userData = session('userData');
        $bidang = DB::select('CALL viewAll_bidang()');
        $departemen = DB::select('CALL viewAll_departemen()');


        return view('admin/bidang/index', compact('userData', 'bidang', 'departemen'));
    }


    public function create_bidang(Request $request)
    {
        $Bidang = json_encode([
            'NamaDepartmen' => $request->get('idDepartemen'),
            'NamaBidang' => $request->get('nama_bidang'),
            'Keterangan' => $request->get('keterangan'),

        ]);

        $response = DB::statement('CALL insert_bidang(:dataBidang)', ['dataBidang' => $Bidang]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('bidang.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('bidang.index');
        }
    }

    // ------ JABATAN -------

    public function jabatan()
    {
        $userData = session('userData');
        $jabatan = DB::select('CALL viewAll_jabatan()');

        return view('admin/jabatan/index', compact('userData', 'jabatan'));
    }

    public function create_jabatan(Request $request)
    {
        $Jabatan = json_encode([
            'Jabatan' => $request->get('jabatan'),
            'Keterangan' => $request->get('keterangan'),

        ]);

        $response = DB::statement('CALL insert_jabatan(:dataJabatan)', ['dataJabatan' => $Jabatan]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('jabatan.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('jabatan.index');
        }
    }

    // ------ JABATAN BIDANG -------


    public function jabatan_bidang()
    {
        $userData = session('userData');
        $jabatanBidang = DB::select('CALL viewAll_jabatanBidang()');
        $jabatan = DB::select('CALL viewAll_jabatan()');
        $bidang = DB::select('CALL viewAll_bidang()');

        return view('admin/jabatan_bidang/index', compact('userData', 'jabatanBidang', 'jabatan', 'bidang'));
    }

    public function create_jabatanBidang(Request $request)
    {
        $JabatanBidang = json_encode([
            'Jabatan' => $request->get('id_jabatan'),
            'Bidang' => $request->get('id_bidang'),
            'JabatanBidang' => $request->get('jabatan_bidang'),
            'Keterangan' => $request->get('keterangan'),

        ]);

        $response = DB::statement('CALL insert_jabatanBidang(:dataJabatanBidang)', ['dataJabatanBidang' => $JabatanBidang]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('jabatanBidang.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('jabatanBidang.index');
        }
    }

    // ------ GOLONGAN PANGKAT -------

    public function golongan_pangkat()
    {
        $userData = session('userData');
        $golonganPangkat = DB::select('CALL viewAll_golonganPangkat()');

        return view('admin/golongan_pangkat/index', compact('userData', 'golonganPangkat'));
    }

    public function create_golonganPangkat(Request $request)
    {
        $GolonganPangkat = json_encode([
            'Golongan' => $request->get('golongan'),
            'Pangkat' => $request->get('pangkat'),
            'Keterangan' => $request->get('keterangan'),

        ]);

        $response = DB::statement('CALL insert_golonganPangkat(:dataGolonganPangkat)', ['dataGolonganPangkat' => $GolonganPangkat]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('golonganPangkat.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('golonganPangkat.index');
        }
    }

    // ------ PEGAWAI -------

    public function pegawai()
    {
        $userData = session('userData');
        $golonganPangkat = DB::select('CALL viewAll_golonganPangkat()');
        $pegawai = DB::select('CALL viewAll_pegawaiFull()');
        $jabatanBidang = DB::select('CALL viewAll_jabatanBidang()');
        $desa = DB::select('CALL viewAll_desa()');

        return view('admin/pegawai/index', compact('userData', 'pegawai', 'golonganPangkat', 'jabatanBidang', 'desa'));
    }

    public function create_pegawai(Request $request)
    {
        // Validasi file foto
       $request->validate([
            'foto' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);
        // dd($validated);
        // Simpan foto jika ada
        if ($request->hasFile('foto')) {

            $file = $request->file('foto');
            $fileName = time() . '_' . $file->getClientOriginalName(); // Buat nama unik
            $destinationPath = public_path('assets/images'); // Simpan di public/assets/images
            $file->move($destinationPath, $fileName); // Pindahkan file
        }

        // JSON untuk dikirim ke Stored Procedure
        $Pegawai = json_encode([
            'NIP' => $request->get('nip'),
            'Nama' => $request->get('nama_pegawai'),
            'GolonganPangkat' => $request->get('id_golongan_pangkat'),
            'JabatanBidang' => $request->get('id_jabatan_bidang'),
            'Desa' => $request->get('subdis_id'),
            'Alamat' => $request->get('alamat'),
            'Ponsel' => $request->get('ponsel'),
            'WA' => $request->get('wa'),
            'Foto' => $fileName, // Simpan path file foto
        ]);

        $response = DB::statement('CALL insert_pegawai(:dataPegawai)', ['dataPegawai' => $Pegawai]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('pegawai.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('pegawai.index');
        }
    }

    // ------ JABATAN PETANI -------

    public function jabatan_petani()
    {
        $userData = session('userData');
        $jabatanPetani = DB::select('CALL viewAll_jabatanPetani()');
        $jabatanPokTan = DB::select('CALL viewAll_jabatanBidangPokTan()');
        $kelompokTani = DB::select('CALL viewAll_kelompokTaniFull()');
        $petani = DB::select('CALL viewAll_petani()');
        
        return view('admin/jabatan_petani/index', compact('userData', 'jabatanPetani','jabatanPokTan','kelompokTani','petani'));
    }

    public function create_jabatanPetani(Request $request)
    {
        // dd($request->all());
        $JabatanPetani = json_encode([
            'JabatanBidang' => $request->get('id_jabatan_bidang'),
            'KelompokTani' => $request->get('id_kelompok_tani'),
            'Petani' => $request->get('id_petani'),
        ]);

        $response = DB::statement('CALL insert_jabatanPetani(:dataJabatanPetani)', ['dataJabatanPetani' => $JabatanPetani]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('jabatanPetani.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('jabatanPetani.index');
        }
    }

    //  -------------------------- HALAMAN --------------------------------

    // ------ PROVINSI -------
    
    public function provinsi()
    {
        $userData = session('userData');
        $provinsi = DB::select('CALL viewAll_provinsi()');

        return view('admin/provinsi/index', compact('userData', 'provinsi'));
    }

    // ------ KABUPATEN -------

    public function kabupaten()
    {
        $userData = session('userData');
        $kabupaten = DB::select('CALL viewAll_kabupaten()');

        return view('admin/kabupaten/index', compact('userData', 'kabupaten'));
    }

    // ------ KECAMATAN -------

    public function kecamatan()
    {
        $userData = session('userData');
        $kecamatan = DB::select('CALL viewAll_kecamatan()');

        return view('admin/kecamatan/index', compact('userData', 'kecamatan'));
    }


    public function create_kecamatan(Request $request)
    {
        $Kecamatan = json_encode([
            'Kecamatan' => $request->get('dis_name'),

        ]);

        $response = DB::statement('CALL insert_kecamatan(:dataKecamatan)', ['dataKecamatan' => $Kecamatan]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('kecamatan.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('kecamatan.index');
        }
    }

    // ------ DESA -------

    public function desa()
    {
        $userData = session('userData');
        $desa = DB::select('CALL viewAll_desa()');
        $kecamatan = DB::select('CALL viewAll_kecamatan()');

        return view('admin/desa/index', compact('userData', 'desa', 'kecamatan'));
    }

    public function create_desa(Request $request)
    {
        $Desa = json_encode([
            'NamaDesa' => $request->get('subdis_name'),
            'Kecamatan' => $request->get('dis_id'),

        ]);

        $response = DB::statement('CALL insert_desa(:dataDesa)', ['dataDesa' => $Desa]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('desa.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('desa.index');
        }
    }

    // ------ KELOMPOK TANI -------

    public function kelompok_tani()
    {
        $userData = session('userData');
        $kelompokTani = DB::select('CALL viewAll_kelompokTani()');

        return view('admin/kelompok_tani/index', compact('userData', 'kelompokTani'));
    }

    public function create_kelompok_tani(Request $request)
    {
        $KelompokTani = json_encode([
            'NamaKelompokTani' => $request->get('nama_kelompok'),
            'AlamatSekretariat' => $request->get('alamat_sekretariat'),

        ]);

        $response = DB::statement('CALL insert_kelompokTani(:dataKelompokTani)', ['dataKelompokTani' => $KelompokTani]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('kelompokTani.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('kelompokTani.index');
        }
    }

    // ------ PETANI -------

    public function petani()
    {
        $userData = session('userData');
        $kelompokTani = DB::select('CALL viewAll_kelompokTaniFull()');
        $petani = DB::select('CALL viewAll_petani()');

        return view('admin/petani/index', compact('userData', 'petani', 'kelompokTani'));
    }

    public function create_petani(Request $request)
    {
        $Petani = json_encode([
            'NamaDepan' => $request->get('nama_depan'),
            'NamaBelakang' => $request->get('nama_belakang'),
            'AlamatRumah' => $request->get('alamat_rumah'),
            'KelompokTani' => $request->get('id_kelompok_tani'),

        ]);

        $response = DB::statement('CALL insert_petani(:dataPetani)', ['dataPetani' => $Petani]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('petani.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('petani.index');
        }
    }
}
