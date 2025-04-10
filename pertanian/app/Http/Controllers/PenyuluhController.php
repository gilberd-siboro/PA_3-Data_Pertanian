<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PenyuluhController extends Controller
{
    public function penyuluh()
    {
        $userData = session('userData');
        $petani = DB::select('CALL viewAll_petani()');
        $totalPetani = count($petani);
        $kelompokTani = DB::select('CALL viewAll_kelompokTani()');
        $totalKel = count($kelompokTani);
        $komoditas = DB::select('CALL viewAll_Komoditas()');
        $totalKom = count($komoditas);
        $pasar = DB::select('CALL viewAll_pasar()');
        $totalPsr = count($pasar);

        return view('penyuluh/index', compact('userData', 'totalPetani', 'totalKel', 'totalKom', 'totalPsr', 'komoditas', 'pasar'));
    }

    public function getHargaKomoditasChart(Request $request)
    {
        $idKomoditas = $request->input('id_komoditas');
        $idPasar = $request->input('id_pasar');

        $results = DB::select('CALL get_harga_komoditas(?, ?)', [$idKomoditas, $idPasar]);

        $data = [];

        foreach ($results as $row) {
            // Karena tanggal dari stored procedure sudah dalam format 'Y-m-d'
            if (!$row->tanggal) continue;

            $dateObj = new \DateTime($row->tanggal);
            $tanggal = $dateObj->format('M Y'); // Contoh: 'Feb 2025'

            if (!isset($data[$tanggal])) {
                $data[$tanggal] = [
                    'tanggal' => $tanggal,
                    'high' => $row->harga_tertinggi,
                    'low' => $row->harga_terendah,
                ];
            } else {
                $data[$tanggal]['high'] = max($data[$tanggal]['high'], $row->harga_tertinggi);
                $data[$tanggal]['low'] = min($data[$tanggal]['low'], $row->harga_terendah);
            }
        }

        // Siapkan response sesuai kebutuhan chart di JS
        $response = [
            'categories' => array_keys($data),
            'high' => array_column($data, 'high'),
            'low' => array_column($data, 'low'),
        ];

        return response()->json($response);
    }

    public function data_pertanian()
    {
        $userData = session('userData');
        $petani = DB::select('CALL viewAll_petani()');
        $lahan = DB::select('CALL viewAll_lahan()');
        $desa = DB::select('CALL viewAll_desa()');
        $komoditas = DB::select('CALL viewAll_Komoditas()');
        $dataPertanian = DB::select('CALL viewAll_dataPertanian()');
        $totalData = count($dataPertanian); // Menghitung jumlah data

        return view('penyuluh/data/index', compact('userData', 'petani', 'lahan', 'desa', 'komoditas', 'dataPertanian', 'totalData'));
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

        return view('penyuluh/data/edit', compact('userData', 'petani', 'lahan', 'desa', 'komoditas', 'dataPertanian'));
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
                return redirect()->route('dataPertanian.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('dataPertanian.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('dataPertanian.index');
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
            return redirect()->route('dataPertanian.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('dataPertanian.index');
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

        return redirect()->route('dataPertanian.index');
    }

    # ----- Harga Komoditas -----------

    public function harga()
    {
        $userData = session('userData');
        $pasar = DB::select('CALL viewAll_pasar()');
        $komoditas = DB::select('CALL viewAll_Komoditas()');
        $harga = DB::select('CALL viewAll_hargaKomoditas()');
        $totalData = count($harga);

        return view('penyuluh/harga/index', compact('totalData', 'userData', 'pasar', 'komoditas', 'harga'));
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
            return redirect()->route('harga.index');
        } else {
            toast('Data gagal disimpan!', 'error')->autoClose(3000);
            return redirect()->route('harga.index');
        }
    }

    public function edit_harga($id)
    {
        $userData = session('userData');
        $pasar = DB::select('CALL viewAll_pasar()');
        $komoditas = DB::select('CALL viewAll_Komoditas()');
        $hargaData = DB::select('CALL view_hargaKomoditasById(' . $id . ')');
        $harga = $hargaData[0];


        return view('penyuluh/harga/edit', compact('userData', 'pasar', 'komoditas', 'harga'));
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
                return redirect()->route('harga.index');
            } else {
                toast('Data gagal disimpan!', 'error')->autoClose(3000);
                return redirect()->route('harga.index');
            }
        } else {
            toast('Data tidak ditemukan!', 'error')->autoClose(3000);
            return redirect()->route('harga.index');
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

        return redirect()->route('harga.index');
    }
}
