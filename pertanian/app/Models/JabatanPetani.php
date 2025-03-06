<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JabatanPetani extends Model
{
    use HasFactory;

    protected $table = 'jabatan_petani';

    protected $primaryKey = 'id_jabatan_petani';

    protected $fillable = [
        'idJabatanBidang',
        'id_kelompok_tani',
        'id_petani',
    ];
}
