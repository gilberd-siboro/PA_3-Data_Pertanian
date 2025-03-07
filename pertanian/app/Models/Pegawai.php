<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pegawai extends Model
{
    use HasFactory;

    protected $table = 'pegawai';

    protected $primaryKey = 'idPegawai';

    protected $fillable = [
        'nip',
        'namaPegawai',
        'idGolonganPangkat',
        'idJabatanBidang',
        'subdis_id',
        'alamat',
        'noPonsel',
        'noWA',
        'fileFoto',
    ];
}
