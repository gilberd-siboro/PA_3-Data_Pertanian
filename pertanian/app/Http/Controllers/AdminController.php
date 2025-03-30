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
        $totalData = count($pengguna);
        return view('admin/pengguna/index', compact('totalData', 'userData', 'pengguna', 'pegawai', 'role'));
    }

    public function edit_pengguna($id)
    {

        $userData = session('userData');
        $penggunaData = DB::select('CALL view_penggunaById(' . $id . ')');
        $pengguna = $penggunaData[0];
        $role = DB::select('CALL viewAll_role()');

        return view('admin/pengguna/edit', compact('userData', 'pengguna', 'role'));
    }

    public function update_pengguna(Request $request, $id)
    {
        // Ambil data pengguna berdasarkan ID
        $penggunaData = DB::select('CALL view_penggunaById(' . $id . ')');
        if (empty($penggunaData)) {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('pengguna.index');
        }

        $pengguna = $penggunaData[0];

        // Validasi input termasuk password jika diisi
        $rules = [
            'username' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'role' => 'required|string',
        ];

        if ($request->filled('password')) {
            $rules['password'] = [
                'string',
                'min:8',           // Minimal 8 karakter
                'regex:/[0-9]/',   // Harus mengandung setidaknya satu angka
            ];
        }

        $customMessages = [
            'password.min' => 'Password harus memiliki minimal 8 karakter.',
            'password.regex' => 'Password harus mengandung setidaknya satu angka.',
        ];

        $request->validate($rules, $customMessages);

        // Cek apakah password diisi atau tidak
        $password = $request->filled('password') ? bcrypt($request->get('password')) : $pengguna->password;

        // Buat JSON untuk dikirim ke stored procedure
        $Pengguna = json_encode([
            'IdPengguna' => $id,
            'Username' => $request->get('username'),
            'Email' => $request->get('email'),
            'Password' => $password, // Password hanya diubah jika diisi
            'Role' => $request->get('role'),
        ]);

        // Panggil stored procedure update_pengguna
        $response = DB::statement('CALL update_pengguna(:dataPengguna)', ['dataPengguna' => $Pengguna]);

        if ($response) {
            toast('Data berhasil diperbarui!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
        }

        return redirect()->route('pengguna.index');
    }


    public function create_pengguna(Request $request)
    {
        $request->validate([
            'username' => 'required|string|max:16',
            'password' => [
                'required',
                'string',
                'min:8',            // Minimal 8 karakter
                'regex:/[0-9]/',    // Harus mengandung setidaknya satu angka
            ],
        ], [
            'password.required' => 'Password wajib diisi.',
            'password.min' => 'Password harus memiliki minimal 8 karakter.',
            'password.regex' => 'Password harus mengandung setidaknya satu angka.',
        ]);

        $Pengguna = json_encode([
            'Username' => $request->get('username'),
            'Email' => $request->get('email'),
            'Password' => bcrypt($request->get('password')),
            'Role' => $request->get('role'),
            'Pegawai' => $request->get('pegawai')
        ]);

        $response = DB::statement('CALL insert_pengguna(:dataPengguna)', ['dataPengguna' => $Pengguna]);

        if ($response) {
            toast('Pengguna berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('pengguna.index');
        } else {
            toast('Pengguna gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('pengguna.index');
        }
    }



    public function delete_pengguna(Request $request, $id)
    {
        $response = DB::statement('CALL delete_pengguna(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('pengguna.index');
    }

    // ------ Data Pertanian --------

    public function data_pertanian()
    {
        $userData = session('userData');
        $petani = DB::select('CALL viewAll_petani()');
        $lahan = DB::select('CALL viewAll_lahan()');
        $desa = DB::select('CALL viewAll_desa()');
        $komoditas = DB::select('CALL viewAll_Komoditas()');
        $dataPertanian = DB::select('CALL viewAll_dataPertanian()');
        $totalData = count($dataPertanian); // Menghitung jumlah data

        return view('admin/data/index', compact('userData', 'petani', 'lahan', 'desa', 'komoditas', 'dataPertanian', 'totalData'));
    }

    public function edit($id)
    {
        $userData = session('userData');
        $petani = DB::select('CALL viewAll_petani()');
        $lahan = DB::select('CALL viewAll_lahan()');
        $desa = DB::select('CALL viewAll_desa()');
        $komoditas = DB::select('CALL viewAll_Komoditas()');
        $dataPertanianData = DB::select('CALL view_dataPertanianById(' . $id . ')');
        $dataPertanian = $dataPertanianData[0];

        return view('admin/data/edit', compact('userData', 'petani', 'lahan', 'desa', 'komoditas', 'dataPertanian'));
    }
    public function update(Request $request, $id)
    {
        $DataPertanian = json_encode([
            'IdDataPertanian' => $id,
            'Petani' => $request->get('id_petani'),
            'Lahan' => $request->get('id_lahan'),
            'Komoditas' => $request->get('id_komoditas'),
            'LuasLahan' => $request->get('luasLahan'),
            'Desa' => $request->get('subdis_id'),
            'Alamat' => $request->get('alamatLengkap'),
            'TanggalTanam' => $request->get('tanggal_tanam'),
            'TanggalCatat' => $request->get('tanggal_pencatatan'),
        ]);



        $dataPertanianData = DB::select('CALL view_dataPertanianById(' . $id . ')');
        $dataPertanian = $dataPertanianData[0];

        if ($dataPertanian) {
            $response = DB::statement('CALL update_DataPertanian(:dataPertanian)', ['dataPertanian' => $DataPertanian]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('AdmindataPertanian.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('AdmindataPertanian.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('AdmindataPertanian.index');
        }
    }

    public function create_data_pertanian(Request $request)
    {
        $DataPertanian = json_encode([
            'Petani' => $request->get('id_petani'),
            'Lahan' => $request->get('id_lahan'),
            'Komoditas' => $request->get('id_komoditas'),
            'LuasLahan' => $request->get('luas_lahan'),
            'Desa' => $request->get('subdis_id'),
            'Alamat' => $request->get('alamat_lengkap'),
            'TanggalTanam' => $request->get('tanggal_tanam'),
            'TanggalCatat' => $request->get('tanggal_pencatatan'),
            'Pencatat' => session('userData')->user_id
        ]);

        $response = DB::statement('CALL insert_dataPertanian(:dataPertanian)', ['dataPertanian' => $DataPertanian]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('AdmindataPertanian.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('AdmindataPertanian.index');
        }
    }


    public function delete(Request $request, $id)
    {
        $response = DB::statement('CALL delete_dataPertanian(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('AdmindataPertanian.index');
    }



    // ------ JENIS KOMODITAS -------

    public function jenis_komoditas()
    {
        $userData = session('userData');
        $jenisKomoditas = DB::select('CALL viewAll_jenisKomoditas()');
        $totalData = count($jenisKomoditas);
        return view('admin/jenis_komoditas/index', compact('totalData', 'userData', 'jenisKomoditas'));
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

    public function edit_jenisKomoditas($id)
    {
        $userData = session('userData');
        $jenisKomoditasData = DB::select('CALL view_jenisKomoditasById(' . $id . ')');
        $jenisKomoditas = $jenisKomoditasData[0];

        return view('admin/jenis_komoditas/edit', compact('userData', 'jenisKomoditas'));
    }

    public function update_jenisKomoditas(Request $request, $id)
    {
        $JenisKomoditas = json_encode([
            'IdJenisKomoditas' => $id,
            'NamaJenisKomoditas' => $request->get('jenisKomoditas'),
        ]);



        $jenisKomoditasData = DB::select('CALL view_jenisKomoditasById(' . $id . ')');
        $jenisKomoditas = $jenisKomoditasData[0];

        if ($jenisKomoditas) {
            $response = DB::statement('CALL update_jenisKomoditas(:dataJenisKomoditas)', ['dataJenisKomoditas' => $JenisKomoditas]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('jenisKomoditas.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('jenisKomoditas.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('jenisKomoditas.index');
        }
    }


    // ------ KOMODITAS -------

    public function komoditas()
    {
        $userData = session('userData');
        $komoditas = DB::select('CALL viewAll_Komoditas()');
        $jenisKomoditas = DB::select('CALL viewAll_jenisKomoditas()');
        $totalData = count($komoditas);

        return view('admin/komoditas/index', compact('totalData', 'userData', 'komoditas', 'jenisKomoditas'));
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

    public function edit_komoditas($id)
    {
        $userData = session('userData');
        $komoditasData = DB::select('CALL view_komoditasById(' . $id . ')');
        $komoditas = $komoditasData[0];
        $jenisKomoditas = DB::select('CALL viewAll_jenisKomoditas()');

        return view('admin/komoditas/edit', compact('userData', 'komoditas', 'jenisKomoditas'));
    }

    public function update_komoditas(Request $request, $id)
    {
        $Komoditas = json_encode([
            'IdKomoditas' => $id,
            'NamaKomoditas' => $request->get('namaKomoditas'),
            'IdJenisKomoditas' => $request->get('jenisKomoditas'),
            'EstimasiPanen' => $request->get('estimasiPanen'),
        ]);

        $komoditasData = DB::select('CALL view_komoditasById(' . $id . ')');
        $komoditas = $komoditasData[0];

        if ($komoditas) {
            $response = DB::statement('CALL update_komoditas(:dataKomoditas)', ['dataKomoditas' => $Komoditas]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('komoditas.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('komoditas.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('komoditas.index');
        }
    }

    // ------ JENIS LAHAN -------

    public function jenis_lahan()
    {
        $userData = session('userData');
        $jenisLahan = DB::select('CALL viewAll_jenisLahan()');
        $totalData = count($jenisLahan);

        return view('admin/jenis_lahan/index', compact('totalData', 'userData', 'jenisLahan'));
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

    public function edit_jenisLahan($id)
    {
        $userData = session('userData');
        $jenisLahanData = DB::select('CALL view_jenisLahanById(' . $id . ')');
        $jenisLahan = $jenisLahanData[0];


        return view('admin/jenis_lahan/edit', compact('userData', 'jenisLahan'));
    }

    public function update_jenisLahan(Request $request, $id)
    {
        $JenisLahan = json_encode([
            'IdJenisLahan' => $id,
            'NamaJenisLahan' => $request->get('jenisLahan'),
        ]);



        $jenisLahanData = DB::select('CALL view_jenisLahanById(' . $id . ')');
        $jenisLahan = $jenisLahanData[0];

        if ($jenisLahan) {
            $response = DB::statement('CALL update_jenisLahan(:dataJenisLahan)', ['dataJenisLahan' => $JenisLahan]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('jenisLahan.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('jenisLahan.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('jenisLahan.index');
        }
    }
    // ------ LAHAN -------

    public function lahan()
    {
        $userData = session('userData');
        $lahan = DB::select('CALL viewAll_lahan()');
        $jenisLahan = DB::select('CALL viewAll_jenisLahan()');
        $totalData = count($lahan);

        return view('admin/lahan/index', compact('totalData', 'userData', 'lahan', 'jenisLahan'));
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

    public function edit_lahan($id)
    {
        $userData = session('userData');
        $lahanData = DB::select('CALL view_lahanById(' . $id . ')');
        $lahan = $lahanData[0];
        $jenisLahan = DB::select('CALL viewAll_jenisLahan()');

        return view('admin/lahan/edit', compact('userData', 'lahan', 'jenisLahan'));
    }

    public function update_lahan(Request $request, $id)
    {
        $Lahan = json_encode([
            'IdLahan' => $id,
            'NamaLahan' => $request->get('namaLahan'),
            'IdJenisLahan' => $request->get('jenisLahan'),
        ]);

        $lahanData = DB::select('CALL view_lahanById(' . $id . ')');
        $lahan = $lahanData[0];

        if ($lahan) {
            $response = DB::statement('CALL update_lahan(:dataLahan)', ['dataLahan' => $Lahan]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('lahan.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('lahan.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('lahan.index');
        }
    }



    // ------ DEPARTEMEN -------


    public function departemen()
    {
        $userData = session('userData');
        $departemen = DB::select('CALL viewAll_departemen()');
        $totalData = count($departemen);

        return view('admin/departemen/index', compact('totalData', 'userData', 'departemen'));
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

    public function edit_departemen($id)
    {
        $userData = session('userData');
        $departemenData = DB::select('CALL view_departemenById(' . $id . ')');
        $departemen = $departemenData[0];


        return view('admin/departemen/edit', compact('userData', 'departemen'));
    }

    public function update_departemen(Request $request, $id)
    {
        $Departemen = json_encode([
            'IdDepartemen' => $id,
            'NamaDepartemen' => $request->get('departemen'),
            'Keterangan' => $request->get('keterangan'),
        ]);



        $departemenData = DB::select('CALL view_departemenById(' . $id . ')');
        $departemen = $departemenData[0];

        if ($departemen) {
            $response = DB::statement('CALL update_departemen(:dataDepartemen)', ['dataDepartemen' => $Departemen]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('departemen.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('departemen.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('departemen.index');
        }
    }

    // ------ BIDANG -------

    public function bidang()
    {
        $userData = session('userData');
        $bidang = DB::select('CALL viewAll_bidang()');
        $departemen = DB::select('CALL viewAll_departemen()');
        $totalData = count($bidang);

        return view('admin/bidang/index', compact('totalData', 'userData', 'bidang', 'departemen'));
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

    public function edit_bidang($id)
    {
        $userData = session('userData');
        $bidangData = DB::select('CALL view_bidangById(' . $id . ')');
        $bidang = $bidangData[0];
        $departemen = DB::select('CALL viewAll_departemen()');

        return view('admin/bidang/edit', compact('userData', 'bidang', 'departemen'));
    }

    public function update_bidang(Request $request, $id)
    {
        $Bidang = json_encode([
            'IdBidang' => $id,
            'NamaBidang' => $request->get('namaBidang'),
            'IdDepartemen' => $request->get('departemen'),
            'Keterangan' => $request->get('keterangan'),
        ]);

        $bidangData = DB::select('CALL view_bidangById(' . $id . ')');
        $bidang = $bidangData[0];

        if ($bidang) {
            $response = DB::statement('CALL update_bidang(:dataBidang)', ['dataBidang' => $Bidang]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('bidang.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('bidang.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('bidang.index');
        }
    }


    // ------ JABATAN -------

    public function jabatan()
    {
        $userData = session('userData');
        $jabatan = DB::select('CALL viewAll_jabatan()');
        $totalData = count($jabatan);

        return view('admin/jabatan/index', compact('totalData', 'userData', 'jabatan'));
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

    public function edit_jabatan($id)
    {
        $userData = session('userData');
        $jabatanData = DB::select('CALL view_jabatanById(' . $id . ')');
        $jabatan = $jabatanData[0];


        return view('admin/jabatan/edit', compact('userData', 'jabatan'));
    }

    public function update_jabatan(Request $request, $id)
    {
        $Jabatan = json_encode([
            'IdJabatan' => $id,
            'Jabatan' => $request->get('jabatan'),
            'Keterangan' => $request->get('keterangan'),
        ]);

        $jabatanData = DB::select('CALL view_jabatanById(' . $id . ')');
        $jabatan = $jabatanData[0];

        if ($jabatan) {
            $response = DB::statement('CALL update_jabatan(:dataJabatan)', ['dataJabatan' => $Jabatan]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('jabatan.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('jabatan.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
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
        $totalData = count($jabatanBidang);

        return view('admin/jabatan_bidang/index', compact('totalData', 'userData', 'jabatanBidang', 'jabatan', 'bidang'));
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
    public function edit_jabatanBidang($id)
    {
        $userData = session('userData');
        $jabatanBidangData = DB::select('CALL view_jabatanBidangById(' . $id . ')');
        $jabatanBidang = $jabatanBidangData[0];
        $jabatan = DB::select('CALL viewAll_jabatan()');
        $bidang = DB::select('CALL viewAll_bidang()');

        return view('admin/jabatan_bidang/edit', compact('userData','jabatanBidang' ,'bidang', 'jabatan'));
    }

    // ------ GOLONGAN PANGKAT -------

    public function golongan_pangkat()
    {
        $userData = session('userData');
        $golonganPangkat = DB::select('CALL viewAll_golonganPangkat()');
        $totalData = count($golonganPangkat);

        return view('admin/golongan_pangkat/index', compact('totalData', 'userData', 'golonganPangkat'));
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
        $totalData = count($pegawai);

        return view('admin/pegawai/index', compact('totalData', 'userData', 'pegawai', 'golonganPangkat', 'jabatanBidang', 'desa'));
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
        $totalData = count($jabatanPetani);

        return view('admin/jabatan_petani/index', compact('totalData', 'userData', 'jabatanPetani', 'jabatanPokTan', 'kelompokTani', 'petani'));
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

    // ------ KECAMATAN -------

    public function kecamatan()
    {
        $userData = session('userData');
        $kecamatan = DB::select('CALL viewAll_kecamatan()');
        $totalData = count($kecamatan);

        return view('admin/kecamatan/index', compact('totalData', 'userData', 'kecamatan'));
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
        $totalData = count($desa);

        return view('admin/desa/index', compact('totalData', 'userData', 'desa', 'kecamatan'));
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
        $totalData = count($kelompokTani);

        return view('admin/kelompok_tani/index', compact('totalData', 'userData', 'kelompokTani'));
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
        $totalData = count($petani);

        return view('admin/petani/index', compact('totalData', 'userData', 'petani', 'kelompokTani'));
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
