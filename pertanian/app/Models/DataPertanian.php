<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DataPertanian extends Model
{
    use HasFactory;

    protected $table = 'data_pertanian';

    protected $primaryKey = 'id_data_pertanian';

    protected $fillable = [
        'id_petani',
        'id_lahan',
        'id_komoditas',
        'luas_lahan',
        'subdis_id',
        'tanggal_tanam',
        'tanggal_pencatatan',
        'user_id',
        'alamat_lengkap'
    ];
}
