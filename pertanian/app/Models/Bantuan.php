<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bantuan extends Model
{
    use HasFactory;
    protected $table = 'bantuan';

    protected $primaryKey = 'id_bantuan';

    protected $fillable = [
        'jenis_bantuan',
        'tanggal',
        'id_kelompok_tani',
        'nama_kepala_cabang',
    ];
}
