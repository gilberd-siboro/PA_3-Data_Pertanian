<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Pagination\LengthAwarePaginator;

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

    public function getKomoditasByKecamatan(Request $request, $id)
    {
        $perPage = 6; // Jumlah item per halaman
        $page = $request->query('page', 1); // Ambil parameter halaman dari request

        if ($id === "all") {
            $komoditas = DB::select('CALL viewAll_komoditasKecamatan()');
        } else {
            $komoditas = DB::select('CALL view_komoditasByKecamatan(?)', [$id]);
        }

        // Konversi array hasil query menjadi Laravel paginator secara manual
        $komoditasPaginated = new LengthAwarePaginator(
            array_slice($komoditas, ($page - 1) * $perPage, $perPage), // Data sesuai halaman
            count($komoditas), // Total jumlah data
            $perPage,
            $page,
            ['path' => url()->current()] // URL dasar untuk pagination
        );

        return response()->json($komoditasPaginated);
    }

    public function komoditas_kecamatan()
    {
        $kecamatan = DB::select('CALL viewAll_kecamatan()');

        // Ambil data awal dengan pagination
        $komoditasRaw = DB::select('CALL viewAll_komoditasKecamatan()');
        $perPage = 6;
        $page = request()->query('page', 1);
        $komoditas = new LengthAwarePaginator(
            array_slice($komoditasRaw, ($page - 1) * $perPage, $perPage),
            count($komoditasRaw),
            $perPage,
            $page,
            ['path' => url()->current()]
        );

        return view('user.komoditas_kecamatan', compact('kecamatan', 'komoditas'));
    }
    public function persebaran_komoditas()
    {
        $komoditas = DB::select('CALL viewAll_komoditas()');

        // Ambil data awal dengan pagination
        $persebaranRaw = DB::select('CALL viewAll_persebaranKomoditas()');
        $perPage = 6;
        $page = request()->query('page', 1);
        $persebaran = new LengthAwarePaginator(
            array_slice($persebaranRaw, ($page - 1) * $perPage, $perPage),
            count($persebaranRaw),
            $perPage,
            $page,
            ['path' => url()->current()]
        );

        return view('user/persebaran_komoditas', compact('komoditas','persebaran'));
    }

    public function getPersebaranKomoditas(Request $request, $id)
    {
        $perPage = 6; // Jumlah item per halaman
        $page = $request->query('page', 1); // Ambil parameter halaman dari request

        if ($id === "all") {
            $persebaran = DB::select('CALL viewAll_persebaranKomoditas()');
        } else {
            $persebaran = DB::select('CALL view_persebaranKomoditas(?)', [$id]);
        }

        // Konversi array hasil query menjadi Laravel paginator secara manual
        $persebaranPaginated = new LengthAwarePaginator(
            array_slice($persebaran, ($page - 1) * $perPage, $perPage), // Data sesuai halaman
            count($persebaran), // Total jumlah data
            $perPage,
            $page,
            ['path' => url()->current()] // URL dasar untuk pagination
        );

        return response()->json($persebaranPaginated);
    }
}
