<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KelompokTani extends Model
{
    use HasFactory;

    protected $table = 'kelompok_tani';

    protected $primaryKey = 'id_kelompok_tani';

    protected $fillable = [
        'nama_kelompok_tani',
        'tanggal_berdiri',
    ];
}
