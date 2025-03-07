<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Petani extends Model
{
    use HasFactory;

    protected $table = 'petani';

    protected $primaryKey = 'id_petani';

    protected $fillable = [
        'nama_depan',
        'nama_belakang',
        'alamat_rumah',
        'id_kelompok_tani',
    ];
}
