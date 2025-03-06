<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JenisKomoditas extends Model
{
    use HasFactory;

    protected $table = 'jenis_komoditas';

    protected $primaryKey = 'id_jenis_komoditas';

    protected $fillable = [
        'nama_jenis_komoditas',
    ];
}
