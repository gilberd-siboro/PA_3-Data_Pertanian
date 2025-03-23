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

        return view('penyuluh/index', compact('userData','totalPetani','totalKel','totalKom'));
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

        return view('penyuluh/data/index', compact('userData', 'petani', 'lahan', 'desa', 'komoditas', 'dataPertanian','totalData'));
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
}
