<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JenisLahan extends Model
{
    use HasFactory;

    protected $table = 'jenis_lahan';

    protected $primaryKey = 'id_jenis_lahan';

    protected $fillable = [
        'nama_jenis_lahan',
    ];
}
