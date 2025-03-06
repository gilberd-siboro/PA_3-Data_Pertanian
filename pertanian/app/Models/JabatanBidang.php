<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JabatanBidang extends Model
{
    use HasFactory;

    protected $table = 'jabatanbidang';

    protected $primaryKey = 'idJabatanBidang';

    protected $fillable = [
        'idJabatan',
        'id_bidang',
        'namaJabatanBidang',
        'keterangan'
    ];
}
