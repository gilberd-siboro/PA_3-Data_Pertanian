<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HargaKomoditas extends Model
{
    use HasFactory;
    
    protected $table = 'harga_komoditas';

    protected $primaryKey = 'id_harga';

    protected $fillable = [
        'harga',
        'tanggal',
        'id_pasar',
        'id_komoditas',
    ];
}
