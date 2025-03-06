<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Lahan extends Model
{
    use HasFactory;

    protected $table = 'lahan';

    protected $primaryKey = 'id_lahan';

    protected $fillable = [
        'nama_lahan',
        'id_jenis_lahan',
    ];
}
