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
        $pasar = DB::select('CALL viewAll_pasar()');
        $totalPsr = count($pasar);

        return view('admin/index',  compact('userData', 'totalPetani', 'totalKel', 'totalKom', 'totalPsr','komoditas','pasar'));
    }

    public function getHargaKomoditasChart(Request $request)
    {
        $idKomoditas = $request->input('id_komoditas');
        $idPasar = $request->input('id_pasar');

        $results = DB::select('CALL get_harga_komoditas(?, ?)', [$idKomoditas, $idPasar]);

        $data = [];

        foreach ($results as $row) {
            $tanggal = date('M', strtotime($row->tanggal)); // Format jadi 'Jan', 'Feb', dst

            if (!isset($data[$tanggal])) {
                $data[$tanggal] = [
                    'tanggal' => $tanggal,
                    'high' => $row->harga,
                    'low' => $row->harga,
                ];
            } else {
                $data[$tanggal]['high'] = max($data[$tanggal]['high'], $row->harga);
                $data[$tanggal]['low'] = min($data[$tanggal]['low'], $row->harga);
            }
        }

        $response = [
            'categories' => array_keys($data),
            'high' => array_column($data, 'high'),
            'low' => array_column($data, 'low'),
        ];

        return response()->json($response);
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



    public function delete_pengguna($id)
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

    public function delete_jenisKomoditas($id)
    {
        $response = DB::statement('CALL delete_jenisKomoditas(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('jenisKomoditas.index');
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
        // Validasi file foto
        $request->validate([
            'gambar' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);
        // dd($validated);
        // Simpan foto jika ada
        if ($request->hasFile('gambar')) {

            $file = $request->file('gambar');
            $fileName = time() . '_' . $file->getClientOriginalName(); // Buat nama unik
            $destinationPath = public_path('assets/images'); // Simpan di public/assets/images
            $file->move($destinationPath, $fileName); // Pindahkan file
        }

        $Komoditas = json_encode([
            'JenisKomoditas' => $request->get('id_jenis_komoditas'),
            'NamaKomoditas' => $request->get('nama_komoditas'),
            'EstimasiPanen' => $request->get('estimasi_panen'),
            'Gambar' => $fileName,
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

        $komoditasData = DB::select('CALL view_komoditasById(' . $id . ')');
        $komoditas = $komoditasData[0];

        $fileName = $komoditas->gambar; // Gunakan nama file lama jika tidak ada file baru
        // Validasi gambar
        $request->validate([
            'gambar' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);
        // dd($request->gambar);

        // Jika ada file baru di-upload
        if ($request->hasFile('gambar')) {
            // Hapus foto lama jika bukan default atau tidak kosong
            if (!empty($komoditas->gambar) && file_exists(public_path('assets/images/' . $komoditas->gambar))) {
                unlink(public_path('assets/images/' . $komoditas->gambar));
            }

            // Simpan foto baru
            $file = $request->file('gambar');
            $fileName = time() . '_' . $file->getClientOriginalName();
            $file->move(public_path('assets/images/'), $fileName);
        }

        $Komoditas = json_encode([
            'IdKomoditas' => $id,
            'NamaKomoditas' => $request->get('namaKomoditas'),
            'IdJenisKomoditas' => $request->get('jenisKomoditas'),
            'EstimasiPanen' => $request->get('estimasiPanen'),
            'Gambar' => $fileName,
        ]);


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

    public function delete_komoditas($id)
    {
        $response = DB::statement('CALL delete_komoditas(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('komoditas.index');
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

    public function delete_jenisLahan($id)
    {
        $response = DB::statement('CALL delete_jenisLahan(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('jenisLahan.index');
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

    public function delete_lahan($id)
    {
        $response = DB::statement('CALL delete_lahan(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('lahan.index');
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

    public function delete_departemen($id)
    {
        $response = DB::statement('CALL delete_departemen(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('departemen.index');
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

    public function delete_bidang($id)
    {
        $response = DB::statement('CALL delete_bidang(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('bidang.index');
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

    public function delete_jabatan($id)
    {
        $response = DB::statement('CALL delete_jabatan(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('jabatan.index');
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

        return view('admin/jabatan_bidang/edit', compact('userData', 'jabatanBidang', 'bidang', 'jabatan'));
    }

    public function update_jabatanBidang(Request $request, $id)
    {
        $JabatanBidang = json_encode([
            'IdJabatanBidang' => $id,
            'Jabatan' => $request->get('jabatan'),
            'Bidang' => $request->get('bidang'),
            'JabatanBidang' => $request->get('namaJabatanBidang'),
            'Keterangan' => $request->get('keterangan'),
        ]);

        $jabatanBidangData = DB::select('CALL view_jabatanBidangById(' . $id . ')');
        $jabatanBidang = $jabatanBidangData[0];

        if ($jabatanBidang) {
            $response = DB::statement('CALL update_jabatanBidang(:dataJabatanBidang)', ['dataJabatanBidang' => $JabatanBidang]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('jabatanBidang.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('jabatanBidang.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('jabatanBidang.index');
        }
    }

    public function delete_jabatanBidang($id)
    {
        $response = DB::statement('CALL delete_jabatanBidang(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('jabatanBidang.index');
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

    public function edit_golonganPangkat($id)
    {
        $userData = session('userData');
        $golonganPangkatData = DB::select('CALL view_golonganPangkatById(' . $id . ')');
        $golonganPangkat = $golonganPangkatData[0];


        return view('admin/golongan_pangkat/edit', compact('userData', 'golonganPangkat'));
    }

    public function update_golonganPangkat(Request $request, $id)
    {
        $GolonganPangkat = json_encode([
            'IdGolonganPangkat' => $id,
            'Golongan' => $request->get('golongan'),
            'Pangkat' => $request->get('pangkat'),
            'Keterangan' => $request->get('keterangan'),
        ]);

        $golonganPangkatData = DB::select('CALL view_golonganPangkatById(' . $id . ')');
        $golonganPangkat = $golonganPangkatData[0];

        if ($golonganPangkat) {
            $response = DB::statement('CALL update_golonganPangkat(:dataGolonganPangkat)', ['dataGolonganPangkat' => $GolonganPangkat]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('golonganPangkat.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('golonganPangkat.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('golonganPangkat.index');
        }
    }

    public function delete_golonganPangkat($id)
    {
        $response = DB::statement('CALL delete_golonganPangkat(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('golonganPangkat.index');
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
    public function edit_pegawai($id)
    {
        $userData = session('userData');
        $golonganPangkat = DB::select('CALL viewAll_golonganPangkat()');
        $pegawaiData = DB::select('CALL view_pegawaiById(' . $id . ')');
        $pegawai = $pegawaiData[0];
        $jabatanBidang = DB::select('CALL viewAll_jabatanBidang()');
        $desa = DB::select('CALL viewAll_desa()');

        return view('admin/pegawai/edit', compact('userData', 'golonganPangkat', 'pegawai', 'jabatanBidang', 'desa'));
    }

    public function update_pegawai(Request $request, $id)
    {
        $pegawaiData = DB::select('CALL view_pegawaiById(' . $id . ')');
        $pegawai = $pegawaiData[0];

        if (!$pegawai) {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('pegawai.index');
        }

        $fileName = $pegawai->fileFoto; // Gunakan nama file lama jika tidak ada file baru

        // Validasi gambar
        $request->validate([
            'fileFoto' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);
        dd($request->fileFoto);
        // Jika ada file baru di-upload
        if ($request->hasFile('fileFoto')) {
            // Hapus foto lama jika bukan default atau tidak kosong
            if (!empty($pegawai->fileFoto) && file_exists(public_path('assets/images/' . $pegawai->fileFoto))) {
                unlink(public_path('assets/images/' . $pegawai->fileFoto));
            }

            // Simpan foto baru
            $file = $request->file('fileFoto');
            $fileName = time() . '_' . $file->getClientOriginalName();
            $file->move(public_path('assets/images/'), $fileName);
        }

        // Simpan data pegawai
        $Pegawai = json_encode([
            'IdPegawai' => $id,
            'Nip' => $request->get('nip'),
            'NamaPegawai' => $request->get('namaPegawai'),
            'GolonganPangkat' => $request->get('golonganPangkat'),
            'JabatanBidang' => $request->get('jabatanBidang'),
            'Alamat' => $request->get('alamat'),
            'Ponsel' => $request->get('ponsel'),
            'WA' => $request->get('wa'),
            'Desa' => $request->get('desa'),
            'Foto' => $fileName, // Tambahkan nama foto baru ke JSON
        ]);

        $response = DB::statement('CALL update_pegawai(:dataPegawai)', ['dataPegawai' => $Pegawai]);

        if ($response) {
            toast('Data berhasil diupdate!', 'success')->autoClose(3000);
            return redirect()->route('pegawai.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('pegawai.index');
        }
    }

    public function delete_pegawai($id)
    {
        $response = DB::statement('CALL delete_pegawai(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('pegawai.index');
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

    public function edit_jabatanPetani($id)
    {
        $userData = session('userData');
        $jabatanPetaniData = DB::select('CALL view_jabatanPetaniById(' . $id . ')');
        $jabatanPetani = $jabatanPetaniData[0];
        $jabatanPokTan = DB::select('CALL viewAll_jabatanBidangPokTan()');
        $kelompokTani = DB::select('CALL viewAll_kelompokTaniFull()');
        $petani = DB::select('CALL viewAll_petani()');

        return view('admin/jabatan_petani/edit', compact('userData', 'jabatanPetani', 'jabatanPokTan', 'kelompokTani', 'petani'));
    }

    public function update_jabatanPetani(Request $request, $id)
    {
        $JabatanPetani = json_encode([
            'IdJabatanPetani' => $id,
            'JabatanBidang' => $request->get('jabatanBidang'),
            'KelompokTani' => $request->get('kelompokTani'),
            'Petani' => $request->get('petani'),
        ]);

        $jabatanPetaniData = DB::select('CALL view_jabatanPetaniById(' . $id . ')');
        $jabatanPetani = $jabatanPetaniData[0];

        if ($jabatanPetani) {
            $response = DB::statement('CALL update_jabatanPetani(:dataJabatanPetani)', ['dataJabatanPetani' => $JabatanPetani]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('jabatanPetani.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('jabatanPetani.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
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

    public function edit_kecamatan($id)
    {
        $userData = session('userData');
        $kecamatanData = DB::select('CALL view_kecamatanById(' . $id . ')');
        $kecamatan = $kecamatanData[0];

        return view('admin/kecamatan/edit', compact('userData', 'kecamatan'));
    }

    public function update_kecamatan(Request $request, $id)
    {
        $Kecamatan = json_encode([
            'IdKecamatan' => $id,
            'Kecamatan' => $request->get('kecamatan'),
        ]);



        $kecamatanData = DB::select('CALL view_kecamatanById(' . $id . ')');
        $kecamatan = $kecamatanData[0];

        if ($kecamatan) {
            $response = DB::statement('CALL update_kecamatan(:dataKecamatan)', ['dataKecamatan' => $Kecamatan]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('kecamatan.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('kecamatan.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
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

    public function edit_desa($id)
    {
        $userData = session('userData');
        $desaData = DB::select('CALL view_desaById(' . $id . ')');
        $desa = $desaData[0];
        $kecamatan = DB::select('CALL viewAll_kecamatan()');

        return view('admin/desa/edit', compact('userData', 'desa', 'kecamatan'));
    }

    public function update_desa(Request $request, $id)
    {
        $Desa = json_encode([
            'IdDesa' => $id,
            'NamaDesa' => $request->get('namaDesa'),
            'Kecamatan' => $request->get('kecamatan'),
        ]);

        $desaData = DB::select('CALL view_desaById(' . $id . ')');
        $desa = $desaData[0];

        if ($desa) {
            $response = DB::statement('CALL update_desa(:dataDesa)', ['dataDesa' => $Desa]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('desa.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('desa.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('desa.index');
        }
    }

    // ------ KELOMPOK TANI -------

    public function kelompok_tani()
    {
        $userData = session('userData');
        $kelompokTani = DB::select('CALL viewAll_kelompokTani()');
        $totalData = count($kelompokTani);
        $kecamatan = DB::select('CALL viewAll_kecamatan()');

        return view('admin/kelompok_tani/index', compact('totalData', 'userData', 'kelompokTani', 'kecamatan'));
    }

    public function create_kelompok_tani(Request $request)
    {
        $KelompokTani = json_encode([
            'NamaKelompokTani' => $request->get('nama_kelompok'),
            'AlamatSekretariat' => $request->get('alamat_sekretariat'),
            'Kecamatan' => $request->get('kecamatan'),

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

    public function edit_kelompok_tani($id)
    {
        $userData = session('userData');
        $kelompokTaniData = DB::select('CALL view_kelompokTaniById(' . $id . ')');
        $kelompokTani = $kelompokTaniData[0];
        $kecamatan = DB::select('CALL viewAll_kecamatan()');

        return view('admin/kelompok_tani/edit', compact('userData', 'kelompokTani', 'kecamatan'));
    }

    public function update_kelompok_tani(Request $request, $id)
    {
        $KelompokTani = json_encode([
            'IdKelompokTani' => $id,
            'KelompokTani' => $request->get('kelompokTani'),
            'Alamat' => $request->get('alamat'),
            'Kecamatan' => $request->get('kecamatan'),
        ]);



        $kelompokTaniData = DB::select('CALL view_kelompokTaniById(' . $id . ')');
        $kelompokTani = $kelompokTaniData[0];

        if ($kelompokTani) {
            $response = DB::statement('CALL update_kelompokTani(:dataKelompokTani)', ['dataKelompokTani' => $KelompokTani]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('kelompokTani.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('kelompokTani.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('kelompokTani.index');
        }
    }

    public function delete_kelompok_tani($id)
    {
        $response = DB::statement('CALL delete_kelompokTani(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('kelompokTani.index');
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

    public function edit_petani($id)
    {
        $userData = session('userData');
        $petaniData = DB::select('CALL view_petaniById(' . $id . ')');
        $petani = $petaniData[0];
        $kelompokTani = DB::select('CALL viewAll_kelompokTaniFull()');

        return view('admin/petani/edit', compact('userData', 'petani', 'kelompokTani'));
    }

    public function update_petani(Request $request, $id)
    {
        $Petani = json_encode([
            'IdPetani' => $id,
            'NamaDepan' => $request->get('namaDepan'),
            'NamaBelakang' => $request->get('namaBelakang'),
            'Alamat' => $request->get('alamat'),
            'KelompokTani' => $request->get('kelompokTani'),
        ]);

        $petaniData = DB::select('CALL view_petaniById(' . $id . ')');
        $petani = $petaniData[0];

        if ($petani) {
            $response = DB::statement('CALL update_petani(:dataPetani)', ['dataPetani' => $Petani]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('petani.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('petani.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('petani.index');
        }
    }

    public function delete_petani($id)
    {
        $response = DB::statement('CALL delete_petani(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('petani.index');
    }


    // ---------- PASAR ---------------

    public function pasar()
    {
        $userData = session('userData');
        $pasar = DB::select('CALL viewAll_pasar()');
        $desa = DB::select('CALL viewAll_desa()');
        $totalData = count($pasar);

        return view('admin/pasar/index', compact('totalData', 'userData', 'pasar', 'desa'));
    }

    public function create_pasar(Request $request)
    {
        $Pasar = json_encode([
            'Pasar' => $request->get('pasar'),
            'Lokasi' => $request->get('lokasi'),

        ]);

        $response = DB::statement('CALL insert_pasar(:dataPasar)', ['dataPasar' => $Pasar]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('pasar.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('pasar.index');
        }
    }

    public function edit_pasar($id)
    {
        $userData = session('userData');
        $pasarData = DB::select('CALL view_pasarById(' . $id . ')');
        $desa = DB::select('CALL viewAll_desa()');
        $pasar = $pasarData[0];


        return view('admin/pasar/edit', compact('userData', 'pasar', 'desa'));
    }

    public function update_pasar(Request $request, $id)
    {
        $Pasar = json_encode([
            'IdPasar' => $id,
            'Pasar' => $request->get('pasar'),
            'Lokasi' => $request->get('lokasi'),
        ]);



        $pasarData = DB::select('CALL view_pasarById(' . $id . ')');
        $pasar = $pasarData[0];

        if ($pasar) {
            $response = DB::statement('CALL update_pasar(:dataPasar)', ['dataPasar' => $Pasar]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('pasar.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('pasar.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('pasar.index');
        }
    }

    public function delete_pasar($id)
    {
        $response = DB::statement('CALL delete_pasar(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('pasar.index');
    }


    # ----- Harga Komoditas -----------

    public function harga()
    {
        $userData = session('userData');
        $pasar = DB::select('CALL viewAll_pasar()');
        $komoditas = DB::select('CALL viewAll_Komoditas()');
        $harga = DB::select('CALL viewAll_hargaKomoditas()');
        $totalData = count($harga);

        return view('admin/harga/index', compact('totalData', 'userData', 'pasar', 'komoditas', 'harga'));
    }


    public function create_harga(Request $request)
    {
        $Harga = json_encode([
            'Harga' => $request->get('harga'),
            'Tanggal' => $request->get('tanggal'),
            'Pasar' => $request->get('pasar'),
            'Komoditas' => $request->get('komoditas'),
        ]);

        $response = DB::statement('CALL insert_harga(:dataHarga)', ['dataHarga' => $Harga]);

        if ($response) {
            toast('Data berhasil ditambahkan!', 'success')->autoClose(3000);
            return redirect()->route('Adminharga.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('Adminharga.index');
        }
    }

    public function edit_harga($id)
    {
        $userData = session('userData');
        $pasar = DB::select('CALL viewAll_pasar()');
        $komoditas = DB::select('CALL viewAll_Komoditas()');
        $hargaData = DB::select('CALL view_hargaKomoditasById(' . $id . ')');
        $harga = $hargaData[0];


        return view('admin/harga/edit', compact('userData', 'pasar', 'komoditas', 'harga'));
    }

    public function update_harga(Request $request, $id)
    {
        $Harga = json_encode([
            'IdHarga' => $id,
            'Harga' => $request->get('harga'),
            'Tanggal' => $request->get('tanggal'),
            'Pasar' => $request->get('pasar'),
            'Komoditas' => $request->get('komoditas'),
        ]);



        $hargaData = DB::select('CALL view_hargaKomoditasById(' . $id . ')');
        $harga = $hargaData[0];

        if ($harga) {
            $response = DB::statement('CALL update_harga(:dataHarga)', ['dataHarga' => $Harga]);

            if ($response) {
                toast('Data berhasil Di update!', 'success')->autoClose(3000);
                return redirect()->route('Adminharga.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('Adminharga.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('Adminharga.index');
        }
    }

    public function delete_harga($id)
    {
        $response = DB::statement('CALL delete_harga(?)', [$id]);

        if ($response) {
            toast('Data berhasil dihapus!', 'success')->autoClose(3000);
        } else {
            toast('Data gagal dihapus!', 'error')->autoClose(3000);
        }

        return redirect()->route('Adminharga.index');
    }
}
